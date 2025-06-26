//
//  TabNav.View.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct TabNavView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: 0){
                HomeView()
            }
            Tab("MyPet", systemImage: "pawprint.fill", value: 1){
                MyPetView()
            }
            
            Tab("MyVet", systemImage: "stethoscope", value: 2){
                MyVetView()
            }
            
            Tab("Search", systemImage: "magnifyingglass", value: 3, role: .search){
                SearchView()
            }
        }
        .tabViewStyle(.tabBarOnly)
    }
}

#Preview {
    TabNavView()
}
