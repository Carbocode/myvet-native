//
//  VetListView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 30/08/25.
//

import SwiftUI
import Foundation

struct VetListView: View {
    @State private var viewModel = VetListViewModel()

    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                ForEach(viewModel.favoriteVets, id: \.id) { vet in
                    NavigationLink(destination: VetView(vet: vet)){
                        VetProfileCardView(vet: vet)
                    }
                }
            }
        }
        .onAppear {
            Task { await viewModel.read() }
        }
    }
}

#Preview {
    VetListView()
}

