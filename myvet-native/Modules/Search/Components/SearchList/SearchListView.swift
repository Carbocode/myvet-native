//
//  SearchListView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 14/07/25.
//

import SwiftUI
import Foundation
import CoreLocation

// Equatable conformance for CLLocationCoordinate2D
extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        let lhsLoc = CLLocation(latitude: lhs.latitude, longitude: lhs.longitude)
        let rhsLoc = CLLocation(latitude: rhs.latitude, longitude: rhs.longitude)
        return lhsLoc.distance(from: rhsLoc) < 400 // meters
    }
}

struct SearchListView: View {
    @State private var userLocation: CLLocationCoordinate2D? = nil
    @State private var viewModel: SearchListViewModel
    @State private var selectedVet: Vet? = nil

    /// Closure da chiamare quando arrivano nuovi risultati di ricerca
    var onResults: (([Vet]) -> Void)?

    init(position: CLLocationCoordinate2D? = nil, onResults: (([Vet]) -> Void)? = nil) {
        self._viewModel = State(initialValue: SearchListViewModel(userLocation: position))
        self.onResults = onResults
    }

    var body: some View {
            List {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    ForEach(viewModel.searchResults, id: \.self) { vet in
                        NavigationLink(destination: VetView(vet: vet)){
                            SearchResultView(vet: vet)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .listRowBackground(Color.clear)
            .onAppear {
                Task { await viewModel.search() }
            }
            .searchable(text: $viewModel.searchText, placement: .sidebar, prompt: "Cerca veterinario...")
            .onChange(of: viewModel.searchText) { _,_ in
                Task { await viewModel.search() }
            }
            .onChange(of: userLocation) { _, newLocation in
                viewModel.updateUserLocation(newLocation)
                Task { await viewModel.search() }
            }
            .onChange(of: viewModel.searchResults) { _, newResults in
                onResults?(newResults)
            }
#if os(iOS)
            .sheet(item: $selectedVet) { vet in
                NavigationStack{
                    VetView(vet: vet)
                }
            }
#elseif os(macOS)
            .popover(item: $selectedVet, arrowEdge: .trailing) { vet in
                VetView(vet: vet)
                    .frame(width: 400, height: 550)
            }
#endif
    }
}

#Preview {
    SearchListView()
}

