//
//  AuthenticationViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 30/09/21.
//

import Foundation

final class AuthenticationViewModel: BaseViewModel {
    
    let service: RemoteDataService
    var response: String = ""
    
    override init() {
        self.service = RemoteDataService()
        super.init()
    }
    
    func verifyOTP(user: User, otp: String, myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                let parameters = ["phoneNumber": user.phoneNumber,
                                  "otp": otp]
                response = try await service.postStringData(url: .verifyOTP, parameter: parameters)
                myComplete(true)
            } catch {
                response = error.localizedDescription
                print(error.localizedDescription)
                myComplete(false)
            }
        }
    }
    
    func resendOTP(phoneNumber: String, myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                let parameters = ["phoneNumber": phoneNumber]
                response = try await service.postStringData(url: .resendOTP, parameter: parameters)
                print(response)
                
                myComplete(true)
            } catch {
                response = error.localizedDescription
                print(error.localizedDescription)
                
                myComplete(false)
            }
        }
    }
    
    func registerUser(user: User, myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                let parameters = user
                response = try await service.postStringData(url: .register, parameter: parameters)
                print(response)
                
                myComplete(true)
            } catch {
                response = error.localizedDescription
                print(error.localizedDescription)
                myComplete(false)
            }
        }
    }
    
    func loginUser(phone: String, password: String, myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                let parameters = Login(phoneNumber: phone, password: password)
                response = try await service.postStringData(url: .login, parameter: parameters)
                print(response)
                
                myComplete(true)
            } catch {
                response = error.localizedDescription
                print(error.localizedDescription)
                myComplete(false)
            }
        }
    }
}
