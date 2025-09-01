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
    
    let locationManager = CLLocationManager()
    
    var body: some View {
#if os(macOS)
        map
        .inspector(isPresented: $inspectorPresented){
            search
        }
        .sheet(item: $selectedVet) { vet in
            NavigationStack{
                VetView(vet: vet)
            }
        }
#else
        map
        .sheet(isPresented: $showSheet) {
            search
            .presentationDetents([.fraction(0.35), .medium, .large])
            .interactiveDismissDisabled(true)
            .presentationBackgroundInteraction(.enabled)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSheet.toggle()
                } label: {
                    Label("Home", systemImage: "house.fill")
                }
            }
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
        .onAppear{
            locationManager.requestWhenInUseAuthorization()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .sheet(item: $selectedVet) { vet in
            NavigationStack{
                VetView(vet: vet)
            }
        }
    }
    
    var search: some View{
        NavigationStack{
            SearchListView(position: cameraPosition.camera?.centerCoordinate) { results in
                lastResults = results
            }
        }
        
    }
}

#Preview {
    SearchView()
}
