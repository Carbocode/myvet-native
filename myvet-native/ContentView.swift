//
//  ContentView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
            Group {
                if AuthManager.shared.isAuthenticated {
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
