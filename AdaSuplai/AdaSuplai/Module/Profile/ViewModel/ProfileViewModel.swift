//
//  ProfileViewModel.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 11/10/21.
//

import Foundation
import UIKit

class ProfileViewModel: BaseViewModel {
    let service = RemoteDataService()
    var profileData: Observable<[User]> = Observable([])
    let userDefault = UserDefaults()
    var updateResponse = InitialUser(message: "", data: User(id: "", name: "", birthDate: "", gender: "", businessName: "", businessCategory: "", phoneNumber: "", email: "", password: "", date: "", v: 0, profilePicture: ""))
    
    override init() {
        super.init()
        self.fetchProfile()
    }
    
    func fetchProfile() {
        Task {
            do {
                let userId = userDefault.string(forKey: "userId")
                let parent = try await service.getData(InitialUser.self, url: .profile, keyword: userId ?? "")
                profileData.value?.removeAll()
                self.profileData.value?.append(parent.data)
            } catch {
                print("Fetch Profile in ProfileViewModel error: \(error)")
            }
        }
    }
    
    func updateProfile(data: [String: String], myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                let body = Empty()
                var parameters = data
                if let userId = userDefault.string(forKey: "userId") {
                    parameters.updateValue(userId, forKey: "user_id")
                }
                print(parameters)
                let data = try await service.postData(url: .editProfile, parameter: body, header: parameters)
                let decodedData = try JSONDecoder().decode(UpdateProfileResponse.self, from: data)
                print(decodedData)
                myComplete(true)
            } catch {
                print("Update Profile in ProfileViewModel error: \(error)")
                myComplete(false)
            }
        }
    }
    
    func updateProfileImage(data: [String: String]) {
        Task {
            do {
                var parameters = data
                let header = data
                if let userId = userDefault.string(forKey: "userId") {
                    parameters.updateValue(userId, forKey: "user_id")
                }
                let parent = try await service.postData(url: .editProfile, parameter: parameters, header: header)
                print(parent)
            } catch {
                print("Update Profile in ProfileViewModel error: \(error)")
            }
        }
    }
}
