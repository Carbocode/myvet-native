//
//  AnimalDetailsView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 28/06/25.
//

import SwiftUI

struct AnimalDetailsView: View {
    @State var viewModel: AnimalDetailsViewModel
    
    init(animal: Animal) {
        _viewModel = State(wrappedValue: AnimalDetailsViewModel(animal: animal))
    }
    
    var body: some View {
        InlineListView {
            InlineListRow {
                ListRowView(title: "Nome", value: viewModel.animal.nome)
            }
            InlineListRow {
                ListRowView(title: "Specie", value: viewModel.animal.nomeSpecie ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Razza", value: viewModel.animal.nomeRazza ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Data di nascita", value: viewModel.animal.dataNascita ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Luogo di nascita", value: viewModel.animal.luogoNascita ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Sesso", value: viewModel.animal.sesso ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Taglia", value: viewModel.animal.nomeTaglia ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Peso", value: viewModel.animal.peso != nil ? "\(viewModel.animal.peso!) kg" : "-")
            }
            InlineListRow {
                ListRowView(title: "Numero Microchip", value: viewModel.animal.microchip ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Numero Passaporto", value: viewModel.animal.passaporto ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Mantello", value: viewModel.animal.mantello ?? "-")
            }
            InlineListRow {
                ListRowView(title: "Descrizione", value: viewModel.animal.descrizione ?? "-")
            }
        }
        .padding()
    }
}

#Preview {
    AnimalDetailsView(animal: Animal.example)
}
