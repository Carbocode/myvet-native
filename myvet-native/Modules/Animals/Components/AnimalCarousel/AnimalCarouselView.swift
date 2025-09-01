//
//  AnimalCarouselView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 03/07/25.
//

import SwiftUI

struct AnimalCarouselView: View {
    @State var viewModel = AnimalCarouselViewModel()

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(viewModel.animals, id: \.id) { animal in
                        NavigationLink(destination: AnimalView(animal: animal)) {
                            AnimalProfileCardView(animal: animal, isVertical: true)
                        }
                        .scrollTransition{content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.5)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .contentMargins(16, for: .scrollContent)
            .frame(height: 150)
        }
    }
}

#Preview {
    NavigationStack {
        AnimalCarouselView()
    }
}
