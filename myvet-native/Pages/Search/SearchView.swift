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
    @State private var cameraPosition = MapCameraPosition.userLocation(fallback: .automatic)
    
    var body: some View {
        Map{
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
    }
}

#Preview {
    SearchView()
}
