//
//  AnimalDetailsView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 28/06/25.
//

import SwiftUI

struct RowView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title).fontWeight(.semibold)
            Spacer()
            Text(value).foregroundStyle(.secondary)
        }
    }
}

struct AnimalDetailsView: View {
    @StateObject var viewModel: AnimalDetailsViewModel
    
    init(animal: Animal) {
        _viewModel = StateObject(wrappedValue: AnimalDetailsViewModel(animal: animal))
    }
    
    var body: some View {
        Form {
            RowView(title: "Nome", value: viewModel.animal.nome)
            RowView(title: "Specie", value: viewModel.animal.nomeSpecie ?? "-")
            RowView(title: "Razza", value: viewModel.animal.nomeRazza ?? "-")
            RowView(title: "Data di nascita", value: viewModel.animal.dataNascita ?? "-")
            RowView(title: "Luogo di nascita", value: viewModel.animal.luogoNascita ?? "-")
            RowView(title: "Sesso", value: viewModel.animal.sesso ?? "-")
            RowView(title: "Taglia", value: viewModel.animal.nomeTaglia ?? "-")
            RowView(title: "Peso", value: viewModel.animal.peso != nil ? "\(viewModel.animal.peso!) kg" : "-")
            RowView(title: "Numero Microchip", value: viewModel.animal.microchip ?? "-")
            RowView(title: "Numero Passaporto", value: viewModel.animal.passaporto ?? "-")
            RowView(title: "Mantello", value: viewModel.animal.mantello ?? "-")
            RowView(title: "Descrizione", value: viewModel.animal.descrizione ?? "-")
        }
        .formStyle(.grouped)
    }
}

#Preview {
    AnimalDetailsView(animal: Animal.example)
}
