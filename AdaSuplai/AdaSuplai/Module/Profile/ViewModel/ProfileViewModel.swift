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
    var error = ""
    
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
                self.error = error.localizedDescription
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
                self.error = error.localizedDescription
                print("Update Profile in ProfileViewModel error: \(error)")
                myComplete(false)
            }
        }
    }
    
    func updateProfileImage(data: UIImage, myComplete:@escaping(Bool) -> Void) {
        Task {
            do {
                var header: [String: String] = [:]
                if let userId = userDefault.string(forKey: "userId") {
                    header.updateValue(userId, forKey: "user_id")
                }
                let parent = try await service.postProfileImage(url: .editProfile, fileName: "profilePicture", imageData: data, header: header)
                
                let decodedData = try JSONDecoder().decode(UpdateProfileResponse.self, from: parent)
                print(decodedData)
                myComplete(true)
            } catch {
                self.error = error.localizedDescription
                print("Update Image Profile in ProfileViewModel error: \(error)")
                myComplete(false)
            }
        }
    }
}
