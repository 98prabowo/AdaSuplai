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
    var loginData: LoginData?
    
    override init() {
        self.service = RemoteDataService()
        super.init()
    }
    
    func verifyOTP(phoneNumber: String, otp: String, myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                let parameters = VerifyOTP(phoneNumber: phoneNumber, otp: otp)
                let data = try await service.postData(url: .verifyOTP, parameter: parameters)
                response = String(decoding: data, as: UTF8.self)
                print(response)
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
                let parameters = GenerateOTP(phoneNumber: phoneNumber)
                let data = try await service.postData(url: .generateOTP, parameter: parameters)
                response = String(decoding: data, as: UTF8.self)
                print(response)
                myComplete(true)
            } catch {
                response = error.localizedDescription
                print(error.localizedDescription)
                myComplete(false)
            }
        }
    }
    
    func registerUser(userReg: Register, myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                let parameters = userReg
                let data = try await service.postData(url: .register, parameter: parameters)
                response = String(decoding: data, as: UTF8.self)
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
                let data = try await service.postData(url: .login, parameter: parameters)
                loginData = try JSONDecoder().decode(LoginData.self, from: data)
                myComplete(true)
            } catch {
                response = error.localizedDescription
                print(error.localizedDescription)
                myComplete(false)
            }
        }
    }
}
