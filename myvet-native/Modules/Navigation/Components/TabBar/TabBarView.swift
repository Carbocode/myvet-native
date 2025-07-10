//
//  TabBarView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 29/06/25.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedItem: SidebarItem?
    
    var body: some View {
        TabView(selection: $selectedItem) {
            Tab(value: SidebarItem.home) {
                NavigationStack {
                    HomeView()
                }
            } label: {
                Label {
                    Text("Home")
                } icon: {
                    Image(systemName: "house")
                }
            }
            
            Tab(value: SidebarItem.myPet) {
                NavigationStack {
                    MyPetView()
                }
            } label: {
                Label {
                    Text("MyPet")
                } icon: {
                    Image(systemName: "pawprint")
                }
            }
            
            Tab(value: SidebarItem.myVet) {
                NavigationStack {
                    MyVetView()
                }
            } label: {
                Label {
                    Text("MyVet")
                } icon: {
                    Image(systemName: "stethoscope")
                }
            }
            
            Tab(value: SidebarItem.search, role: .search) {
                
                NavigationStack {
                    SearchView()
                }
            }label: {
                Label {
                    Text("Search")
                } icon: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    @Previewable @State var selectedItem: SidebarItem? = .home
    TabBarView(selectedItem: $selectedItem)
}

#if os(iOS)
struct TabIcon: View {
    var icon: UIImage
    var size: CGSize = CGSize(width: 30, height: 30)

    // Based on https://stackoverflow.com/a/32303467
    var roundedIcon: UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        defer {
            UIGraphicsEndImageContext()
        }

        UIBezierPath(
            roundedRect: rect,
            cornerRadius: 0
            ).addClip()
        icon.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    var body: some View {
        Image(uiImage: roundedIcon.withRenderingMode(.alwaysOriginal))
    }
}
#endif
