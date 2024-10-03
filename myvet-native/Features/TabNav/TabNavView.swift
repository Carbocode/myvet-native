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
            Tab("MyPet", systemImage: "pawprint.fill", value: 3){
                MyPetView()
            }
            
            Tab("MyVet", systemImage: "stethoscope", value: 1){
                MyVetView()
            }
            
            Tab("Home", systemImage: "house.fill", value: 0){
                HomeView()
            }
            
            Tab("PetCare", systemImage: "scissors", value: 2){
                PetCareView()
            }
            
            Tab("PetShop", systemImage: "cart.fill", value: 4){
                PetShopView()
            }
        }
        .accentColor(.orange)
        .tabViewStyle(.tabBarOnly)
    }
}

#Preview {
    TabNavView()
}
