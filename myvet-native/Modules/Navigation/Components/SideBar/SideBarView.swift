//
//  SideBarView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 29/06/25.
//

import SwiftUI

struct SideBarView: View {
    @Binding var selectedItem: SidebarItem?
    @Binding var searchText: String
    
    var body: some View {
        NavigationSplitView {
            VStack {
                TextField("Cerca…", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding([.top, .horizontal])
                List(selection: $selectedItem) {
                    Section {
                        NavigationLink(value: SidebarItem.account) {
                            ProfileTabView()
                        }
                    }
                    Section("Principali") {
                        NavigationLink(value: SidebarItem.home) {
                            Label("Home", systemImage: "house.fill")
                        }
                        NavigationLink(value: SidebarItem.myPet) {
                            Label("MyPet", systemImage: "pawprint.fill")
                        }
                        NavigationLink(value: SidebarItem.myVet) {
                            Label("MyVet", systemImage: "stethoscope")
                        }
                    }
                }
                .listStyle(.sidebar)
            }
            .navigationSplitViewColumnWidth(ideal: 200)
        } detail: {
            switch selectedItem {
            case .account:
                EmptyView()
            case .home:
                NavigationStack{
                    HomeView()
                }
            case .myPet:
                NavigationStack{
                    MyPetView()
                }
            case .myVet:
                NavigationStack{
                    MyVetView()
                }
            case .search:
                NavigationStack{
                    SearchView()
                }
            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedItem: SidebarItem? = .home
    @Previewable @State var searchText: String = ""
    SideBarView(selectedItem: $selectedItem, searchText: $searchText)
}
