//
//  MyVet.swift
//  myvet-native
//
//  Created by Ligmab Allz on 18/07/25.
//

import SwiftUI

struct MyVetView: View {
    var body: some View {
        VetListView()
            .navigationTitle("Veterinari")
        #if os(iOS)
            .listStyle(.insetGrouped)
        #endif
    }
}

#Preview {
    MyVetView()
}
