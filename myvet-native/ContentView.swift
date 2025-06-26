//
//  ContentView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authManager = AuthManager.shared
    
    var body: some View {
            Group {
                if authManager.isAuthenticated {
                    TabNavView()
                } else {
                    LoginView()
                }
            }
        }
}

#Preview {
    ContentView()
}
