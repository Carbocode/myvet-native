//
//  MyPetView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 26/06/25.
//

import SwiftUI

struct MyPetView: View {
    
    @State var isSheetPresented = false
    
    var body: some View {
        AnimalListView()
            .navigationTitle("Animali")
        #if os(iOS)
            .listStyle(.insetGrouped)
        #endif
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                NavigationStack{
                    AnimalFormView()
                }
            }
    }
}

#Preview {
    NavigationStack{
        MyPetView()
    }
}
