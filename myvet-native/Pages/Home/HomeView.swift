//
//  HomeView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack(spacing: 16) {
            AnimalCarouselView()
        }
        .toolbar {            
            ToolbarItem(placement: .automatic) {
                Button {
                    AuthManager.shared.removeToken()
                } label: {
                    Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview {
    HomeView()
}
