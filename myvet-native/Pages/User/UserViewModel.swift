//
//  UserViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 10/07/25.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    init() {
        getUser()
    }
    
    func getUser() {
        UsersActions.read() { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print("Failed to fetch user:", error)
                self.user = nil
            }
            
        }
    }
}
