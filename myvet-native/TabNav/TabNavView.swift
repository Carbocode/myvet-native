//
//  TabNav.View.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

enum SidebarItem: Hashable, Identifiable {
    case account
    case home
    case myPet
    case myVet
    case search
    
    var id: Self { self }
}

struct TabNavView: View {
    @State private var selectedItem: SidebarItem? = .home
    @State private var searchText = ""
    
    var body: some View {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            SideBarView(selectedItem: $selectedItem, searchText: $searchText)
        } else {
            TabBarView(selectedItem: $selectedItem)
        }
        
        #elseif os(macOS)
        SideBarView(selectedItem: $selectedItem, searchText: $searchText)
        #endif
    }
}

#Preview {
    TabNavView()
}
