//
//  SearchListViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 14/07/25.
//

import Foundation
import CoreLocation

@Observable @MainActor
class SearchListViewModel {
    var searchText = ""
    var searchResults: [Vet] = []
    var isLoading = false
    var errorMessage: String? = nil
    var userLocation: CLLocationCoordinate2D? = nil

    init(userLocation: CLLocationCoordinate2D? = nil) {
        self.userLocation = userLocation
    }
    
    func updateUserLocation(_ location: CLLocationCoordinate2D?) {
        userLocation = location
    }
    
    func search() async {
        isLoading = true
        errorMessage = nil
        do {
            let results = try await SearchActions.read(
                query: searchText,
                idSpecializzazione: nil,
                showMap: false,
                lat: userLocation?.latitude,
                lon: userLocation?.longitude,
                indexes: ["index_search_real_vets_dev"]
            )
            self.searchResults = results
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
