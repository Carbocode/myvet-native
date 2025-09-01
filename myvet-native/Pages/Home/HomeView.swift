//
//  HomeView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct HomeView: View {
    @State private var showProfileSheet = false

    var body: some View {
        VStack() {
            AnimalCarouselView()
        }
        .navigationTitle("Benvenuto")
#if os(iOS)
        .navigationBarTitleDisplayMode(.large)
#endif
#if os(iOS)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showProfileSheet = true
                } label: {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                }
                .accessibilityLabel("Profilo")
            }
        }
        .sheet(isPresented: $showProfileSheet) {
            NavigationStack{
                UserView()
            }
        }
#endif
    }
}

#Preview {
    HomeView()
}
