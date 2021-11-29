//
//  DataURL.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/10/21.
//

import Foundation

enum LocalFile: String {
    case regions
}

enum RemoteURL: String {
    case product = "https://adasuplai-api-env-staging.herokuapp.com/product/fetch"
    case searchProduct = "https://adasuplai-api-env-staging.herokuapp.com/product/search/"
    case searchProductByID = "https://adasuplai-api-env-staging.herokuapp.com/product/info/"
    case searchProductByCategoryID = "https://adasuplai-api-env-staging.herokuapp.com/product/fetch/category/"
    case image = "https://adasuplai-api-env-staging.herokuapp.com/image/"
    case category = "https://adasuplai-api-env-staging.herokuapp.com/category/fetch"
    case supplier = "https://adasuplai-api-env-staging.herokuapp.com/supplier/fetch"
    case searchSupplier = "https://adasuplai-api-env-staging.herokuapp.com/supplier/info/"
    case paymentMethod = "https://adasuplai-api-env-staging.herokuapp.com/payment/list"
    case paymentInstruction = "https://adasuplai-api-env-staging.herokuapp.com/payment/getVaInstructions"
    case postShipper = "https://merchant-api-sandbox.shipper.id/v3/pricing/domestic"
    case postShipperAPIKey = "OXwMaD7mY09Gd4VP3FVEmzQG4fpo4nO4EmQSmarkQEohrUtI75lJHYp2eoBWQFjA"
    case verifyOTP = "https://adasuplai-api-env-staging.herokuapp.com/api/user/verifyOTP"
    case login = "https://adasuplai-api-env-staging.herokuapp.com/api/user/login"
    case register = "https://adasuplai-api-env-staging.herokuapp.com/api/user/register"
    case generateOTP = "https://adasuplai-api-env-staging.herokuapp.com/api/user/generateOTP"
    case allUser = "https://adasuplai-api-env-staging.herokuapp.com/user/fetch"
    case profile = "https://adasuplai-api-env-staging.herokuapp.com/user/info/"
    case editProfile = "https://adasuplai-api-env-staging.herokuapp.com/user/update"
    case getAddress = "https://adasuplai-api-env-staging.herokuapp.com/user/getAddress"
    case addAddress = "https://adasuplai-api-env-staging.herokuapp.com/user/addAddress"
    case createOrder = "https://adasuplai-api-env-staging.herokuapp.com/order/create"
}
