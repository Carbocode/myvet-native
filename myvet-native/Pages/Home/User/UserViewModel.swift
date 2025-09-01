//
//  UserViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 10/07/25.
//

import Foundation

@Observable @MainActor
class UserViewModel {
    var user: User?
    
    init() {
        getUser()
    }
    
    func getUser() {
        Task{
            do{
                user = try await UsersActions.read()
            }catch{
                
            }
        }
        
    }
}
