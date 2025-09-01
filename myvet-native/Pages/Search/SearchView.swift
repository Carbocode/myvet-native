//
//  SearchView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 26/06/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct SearchView: View {
    @State private var cameraPosition: MapCameraPosition = MapCameraPosition.userLocation(fallback: .automatic)
    @State private var showSheet = true
    @State private var lastResults: [Vet] = []
    @State private var selectedVet: Vet?
    
    @State private var inspectorPresented = true
    
    var body: some View {
#if os(macOS)
        map
        .inspector(isPresented: $inspectorPresented){
            search
        }
        .sheet(item: $selectedVet) { vet in
            VetView(vet: vet)
        }
#else
        map
        .sheet(isPresented: $showSheet) {
            search
            .presentationDetents([.fraction(0.35), .medium, .large])
            .interactiveDismissDisabled(true)
            .presentationBackgroundInteraction(.enabled)
        }
#endif
    }
    var map: some View{
        return Map(position: $cameraPosition, selection: $selectedVet) {
            UserAnnotation()
            ForEach(lastResults) { vet in
                if let pos = vet.posizione {
                    Marker(
                        vet.nome,
                        systemImage: "cross.case.fill",
                        coordinate: CLLocationCoordinate2D(latitude: pos.lat, longitude: pos.lon)
                    )
                    .tag(vet)
                }
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .sheet(item: $selectedVet) { vet in
            VetView(vet: vet)
        }
    }
    
    var search: some View{
        return SearchListView(position: cameraPosition.camera?.centerCoordinate) { results in
            lastResults = results
        }
    }
}

#Preview {
    SearchView()
}
