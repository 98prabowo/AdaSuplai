//
//  TransactionViewModel.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 12/10/21.
//

import Foundation
import Combine
import CoreData

enum TransactionSource {
    case productPage(data: Cart)
    case cartPage
}

class TransactionViewModel: BaseViewModel {
    let service: RemoteDataService
    var suppliers = [Supplier]()
    var shipmentSectionIndex = [Int]()
    var cart = CurrentValueSubject<[Cart], Never>([Cart]())
    var shipmentPrices = CurrentValueSubject<[ShipmentPrice], Never>([ShipmentPrice]())
    var transaction = CurrentValueSubject<Transaction, Never>(Transaction(suppliers: nil, payment: nil))
    
    init(from sourcePage: TransactionSource) {
        self.service = RemoteDataService()
        super.init()
        self.cart.value.removeAll()
        self.suppliers.removeAll()
        switch sourcePage {
        case .productPage(let data):
            self.cart.value.append(data)
        case .cartPage:
            self.fetchCart()
        }
        self.getShipmentRate()
    }
    
    private func fetchCart() {
        guard let context = self.context else { return }
        do {
            let request = Cart.fetchRequest() as NSFetchRequest
            self.cart.value = try context.fetch(request)
        } catch {
            print("Fetch Cart in TransactionDetailViewModel error: \(error.localizedDescription)")
        }
    }
    
    // MARK: Communication Data
    func getShipmentRate() {
        Task {
            do {
                if let data = self.prepareShipmentData() {
                    let apiKey = ["X-API-Key": RemoteURL.postShipperAPIKey.rawValue]
                    let shipmentRateData = try await self.service.postData(url: .postShipper, parameter: data, header: apiKey)
                    let shipmentRate = try JSONDecoder().decode(ShipmentRate.self, from: shipmentRateData)
                    self.shipmentPrices.value = shipmentRate.data.pricings
                }
            } catch {
                print("Post ShipmentRate error in TransactionViewModel: \(error.localizedDescription)")
            }
        }
    }
    
    func getSupplier() {
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts {
                let supplierIDs = suppliers.map { $0.id }
                if let supplierID = product.supplierID,
                   let supplierName = product.supplierName,
                   !supplierIDs.contains(supplierID) {
                    let supplier = Supplier(id: supplierID, supplierName: supplierName, address: nil, v: nil)
                    self.suppliers.append(supplier)
                }
            }
        }
    }
    
    func getProductPerSection(with supplierID: String) -> [ProductCart] {
        var products = [ProductCart]()
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts
            where product.supplierID == supplierID && product.isMarked {
                products.append(product)
            }
            
            products = products.sorted { prev, after in
                guard let prev = prev.productID else { return false }
                guard let after = after.productID else { return false }
                return prev < after
            }
        }
        return products
    }
    
    func getProductCountPerSection(with supplierID: String) -> Int {
        let products = self.getProductPerSection(with: supplierID)
        return products.count
    }
    
    func getTotalProductPricePerSection(with supplierID: String) -> Int {
        var result: Int = 0
        let products = self.getProductPerSection(with: supplierID)
        for product in products {
            result += Int(product.productPrice * product.quantity)
        }
        return result
    }
    
    func getTotalProductPrice() -> Int {
        var result: Int = 0
        if let products = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in products
            where product.isMarked {
                result += Int(product.productPrice * product.quantity)
            }
        }
        return result
    }
    
    func getTotalDeliveryPrice() -> Int {
        var result: Int = 0
        if let suppliers = transaction.value.suppliers {
            let shipments = suppliers.compactMap { $0.shipmentPrice }
            for shipment in shipments {
                result += shipment.totalPrice
            }
        }
        return result
    }
    
    // MARK: Shipment Data
    private func prepareShipmentData() -> ShipmentData? {
        let origin = RequestDestination(areaID: 30085, suburbID: 2570, lat: "-7.285491", lng: "112.631044")
        let destination = RequestDestination(areaID: 627, suburbID: 48, lat: "-8.810128", lng: "115.196463")
        if let products = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            let shipment = ShipmentData(products: products,
                                        destination: destination,
                                        origin: origin)
            return shipment
        }
        return nil
    }
    
    // MARK: Transaction Data
    func addProductToTransaction() {
        let suppliers = self.createSupplierData()
        self.transaction.value.suppliers = suppliers
    }
    
    private func createSupplierData() -> [Supplier] {
        var result = [Supplier]()
        for supplier in suppliers {
            let _supplier = self.setupSuppliersProduct(from: supplier)
            result.append(_supplier)
        }
        return result
    }
    
    private func setupSuppliersProduct(from supplier: Supplier) -> Supplier {
        var result = supplier
        if let productCarts = self.cart.value.first?.products?.allObjects as? [ProductCart] {
            for product in productCarts
            where product.supplierID == result.id && product.isMarked {
                if let productTransaction = self.createProductTransaction(from: product) {
                    if (result.products?.append(productTransaction)) == nil {
                        result.products = [productTransaction]
                    }
                }
                
            }
        }
        return result
    }
    
    private func createProductTransaction(from product: ProductCart) -> TransactionProduct? {
        let productTransaction = TransactionProduct(id: product.id ?? "",
                                         name: product.productName ?? "",
                                         dimension: product.dimension ?? "",
                                         price: Int(product.productPrice),
                                         image: product.image ?? "",
                                         quantity: Int(product.quantity))
        return productTransaction
    }
}
