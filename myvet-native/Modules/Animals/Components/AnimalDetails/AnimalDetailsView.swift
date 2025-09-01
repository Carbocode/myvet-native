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
            ListRowView(title: "Nome", value: viewModel.animal.nome)
            ListRowView(title: "Specie", value: viewModel.animal.nomeSpecie ?? "-")
            ListRowView(title: "Razza", value: viewModel.animal.nomeRazza ?? "-")
            ListRowView(title: "Data di nascita", value: viewModel.animal.dataNascita ?? "-")
            ListRowView(title: "Luogo di nascita", value: viewModel.animal.luogoNascita ?? "-")
            ListRowView(title: "Sesso", value: viewModel.animal.sesso ?? "-")
            ListRowView(title: "Taglia", value: viewModel.animal.nomeTaglia ?? "-")
            ListRowView(title: "Peso", value: viewModel.animal.peso != nil ? "\(viewModel.animal.peso!) kg" : "-")
            ListRowView(title: "Numero Microchip", value: viewModel.animal.microchip ?? "-")
            ListRowView(title: "Numero Passaporto", value: viewModel.animal.passaporto ?? "-")
            ListRowView(title: "Mantello", value: viewModel.animal.mantello ?? "-")
            ListRowView(title: "Descrizione", value: viewModel.animal.descrizione ?? "-")
    }
}

#Preview {
    AnimalDetailsView(animal: Animal.example)
}
