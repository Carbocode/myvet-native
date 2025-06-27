//
//  AnimalCardView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import SwiftUI

struct AnimalProfileCardView: View {
    @ObservedObject var viewModel: AnimalProfileCardViewModel
    
    init(animal: Animal){
        self.viewModel = .init(animal: animal)
    }
    
    var body: some View {
           
            HStack{
                let fullURL = Config.animalURL.appendingPathComponent("/" + (viewModel.animal.immagine ?? "/default.png"))
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
                
                VStack(alignment: .leading){
                    Text(viewModel.animal.nome)
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
        
    }
}
