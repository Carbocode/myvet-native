//
//  AnimalCardView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import SwiftUI

struct AnimalProfileCardView: View {
    @State var viewModel: AnimalProfileCardViewModel
    let isVertical: Bool
    
    init(animal: Animal, isVertical: Bool = false) {
        self.viewModel = .init(animal: animal)
        self.isVertical = isVertical
    }
    
    var body: some View {
        if isVertical {
            VStack {
                let fullURL = Config.animalURL.appendingPathComponent("/" + (viewModel.animal.immagine))
                AsyncImage(url: fullURL)
                { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                
                Text(viewModel.animal.nome)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            .padding()
        } else {
            HStack {
                let fullURL = Config.animalURL.appendingPathComponent("/" + (viewModel.animal.immagine))
                AsyncImage(url: fullURL)
                { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                VStack(alignment: .leading) {
                    Text(viewModel.animal.nome)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Text(viewModel.animal.nomeSpecie ?? "")
                        .font(.caption)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    VStack {
        AnimalProfileCardView(animal: Animal.example)
        AnimalProfileCardView(animal: Animal.example, isVertical: true)
    }
}



