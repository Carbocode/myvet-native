//
//  AnimalCarouselView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 03/07/25.
//

import SwiftUI

struct AnimalCarouselView: View {
    @StateObject var viewModel = AnimalCarouselViewModel()

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(viewModel.animals, id: \.id) { animal in
                        NavigationLink(destination: AnimalView(animal: animal)) {
                            AnimalProfileCardView(animal: animal, isVertical: true)
                        }
                    }
                }
            }
            .frame(height: 150)
        }
        .navigationTitle("I miei animali")
    }
}

#Preview {
    NavigationStack {
        AnimalCarouselView()
    }
}
