//
//  AppointmentFormViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 31/08/25.
//

import Foundation
import SwiftUI

@Observable @MainActor
class AppointmentFormViewModel {
    var idServizio: Int?
    var idAnimale: Int?
    var dataOraAppuntamento: Date?
    var note: String = ""
    
    // Dati di supporto per i Picker
    var servizi: [VetService] = []
    var animali: [Animal] = []
    
    // Il veterinario associato
    let vet: Vet
    
    init(vet: Vet) {
        self.vet = vet
        
        Task {
            await getServices()
            await getAnimals()
        }
    }
    
    func getServices() async {
        do {
            // Usa l'id del vet per caricare i servizi preferiti
            servizi = try await VetSericesActions.readFavorite(idVeterinario: vet.idVeterinario)
        } catch {
            // Gestione dell'errore (potresti loggare o mostrare un alert)
        }
    }
    
    func getAnimals() async {
        do {
            animali = try await AnimalsActions.readAll()
        } catch {
            // Gestione dell'errore
        }
    }

    /// Crea un nuovo appuntamento utilizzando l'action AppointmentsActions.create
    /// - Throws: rilancia errori in caso di problemi
    func createAppointment() async throws {
        // Verifica che tutti i campi richiesti siano presenti
        guard
            let idServizio = idServizio,
            let idAnimale = idAnimale,
            let dataOraAppuntamento = dataOraAppuntamento
        else {
            throw AppointmentFormError.missingFields
        }
        
        // Prepara la stringa ISO8601 per la data
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let dataAppuntamentoString = isoFormatter.string(from: dataOraAppuntamento)
        
        let request = AppointmentCreateRequest(
            IDVeterinario: vet.idVeterinario,
            IDServizio: idServizio,
            IDAnimale: idAnimale,
            DataAppuntamento: dataAppuntamentoString,
            Note: note
        )
        
        _ = try await AppointmentsActions.create(request)
    }

    enum AppointmentFormError: Error, LocalizedError {
        case missingFields
        
        var errorDescription: String? {
            switch self {
            case .missingFields:
                return "Tutti i campi obbligatori devono essere compilati."
            }
        }
    }
}
