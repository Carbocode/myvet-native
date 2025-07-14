//
//  SearchListView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 14/07/25.
//

import SwiftUI

struct SearchListView: View {
    // Lista di esempio
    let items = [
        "Cane",
        "Gatto",
        "Coniglio",
        "Tartaruga",
        "Uccello",
        "Criceto"
    ]
    
    @State private var searchText = ""
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Animali")
            .searchable(text: $searchText, prompt: "Cerca animale...")
        }
    }
}

#Preview {
    SearchListView()
}
