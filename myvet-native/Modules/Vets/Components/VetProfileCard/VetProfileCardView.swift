//
//  VetProfileCardView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 30/08/25.
//

import SwiftUI

struct VetProfileCardView: View {
    @State var viewModel: VetProfileCardViewModel
    
    init(vet: Vet) {
        self.viewModel = .init(vet: vet)
    }
    
    var body: some View {
        HStack {
            let fullURL = Config.vetURL.appendingPathComponent("/" + (viewModel.vet.immagine))
            let defaultURL = Config.vetURL.appendingPathComponent("/default.png")
            AsyncImage(url: fullURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    AsyncImage(url: defaultURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            ProgressView()
                        @unknown default:
                            ProgressView()
                        }
                    }
                @unknown default:
                    ProgressView()
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            
            VStack(alignment: .leading) {
                Text(viewModel.vet.nome + " " + (viewModel.vet.cognome ?? ""))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(viewModel.vet.nomeSpecializzazione ?? "")
                    .font(.caption)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    VStack {
        VetProfileCardView(vet: Vet.example)
    }
}
