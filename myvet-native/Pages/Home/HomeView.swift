//
//  HomeView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct HomeView: View {
    var onLogout: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            ProfilePicturePicker()
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    onLogout?()
                } label: {
                    Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
        }
    }
}

#Preview {    NavigationStack {
        HomeView(onLogout: { print("Logout tapped") })
    }
}
