//
//  AnimalCardView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import SwiftUI

struct AnimalCardView: View {
    @ObservedObject var viewModel: AnimalCardViewModel
    
    var body: some View {
           
            HStack{
                let fullURL = URL(string: viewModel.animal.image, relativeTo: Config.animalURL)
                AsyncImage(url: fullURL)
                { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .padding(10)
                
                VStack(alignment: .leading){
                    Text(viewModel.animal.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Text("quagliano")
                        .font(.caption)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                
            }
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 3, x:0, y: 2)
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 2)
        
    }
}

#Preview {
    let animal: Animal = .init(id: 1, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png")
    let viewModel: AnimalCardViewModel = .init(animal: animal)
    AnimalCardView(viewModel: viewModel)
}
