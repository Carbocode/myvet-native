//
//  TabNav.View.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct AccountSidebarHeaderView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading, spacing: 2) {
                Text("Ciao Ciaone")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text("utente@email.com")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
}

struct TabNavView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    
    var body: some View {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad{
            NavigationSplitView {
                VStack {
                    TextField("Cerca…", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding([.top, .horizontal])
                    List() {
                        Section {
                            NavigationLink(destination: AccountSidebarHeaderView()){
                                AccountSidebarHeaderView()
                            }
                        }
                        Section("Principali") {
                            NavigationLink(destination: HomeView()){
                                Label("Home", systemImage: "house.fill")
                            }
                            NavigationLink(destination: MyPetView()){
                                Label("MyPet", systemImage: "pawprint.fill")
                            }
                            NavigationLink(destination: MyVetView()){
                                Label("MyVet", systemImage: "stethoscope")
                            }
                        }
                    }
                    .listStyle(.sidebar)
                }
                .navigationSplitViewColumnWidth(ideal: 200)
            } detail: {}
        }
        else{
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "house.fill", value: 0) {
                    HomeView()
                }
                Tab("MyPet", systemImage: "pawprint.fill", value: 1) {
                    MyPetView()
                }
                
                Tab("MyVet", systemImage: "stethoscope", value: 2) {
                    MyVetView()
                }
                Tab("Search", systemImage: "magnifyingglass", value: 3, role: .search) {
                    SearchView()
                }
            }
            .tabViewStyle(.sidebarAdaptable)
        }
        
        #elseif os(macOS)
        NavigationSplitView {
            VStack {
                TextField("Cerca…", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding([.top, .horizontal])
                List() {
                    Section {
                        NavigationLink(destination: AccountSidebarHeaderView()){
                            AccountSidebarHeaderView()
                        }
                                              }
                    Section("Principali") {
                        NavigationLink(destination: HomeView()){
                            Label("Home", systemImage: "house.fill")
                        }
                        NavigationLink(destination: MyPetView()){
                            Label("MyPet", systemImage: "pawprint.fill")
                        }
                        NavigationLink(destination: MyVetView()){
                            Label("MyVet", systemImage: "stethoscope")
                        }
                    }
                }
                .listStyle(.sidebar)
            }
            .navigationSplitViewColumnWidth(ideal: 200)
        } detail: {}
        #endif
    }
}

#Preview {
    TabNavView()
}
