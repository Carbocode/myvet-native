import Foundation

class AppointmentsActions {
    static func readSlots(date: Date, idVeterinario: Int) async throws -> [Date] {
        // Formatter per "yyyy-MM-dd", senza manipolare il fuso
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current // usa il fuso dell'utente

        // Ottieni la stringa giorno nel formato richiesto
        let dateString = dateFormatter.string(from: date)
        
        let queryParams = [
            URLQueryItem(name: "IDVeterinario", value: String(idVeterinario)),
            URLQueryItem(name: "DataRichiesta", value: dateString)
        ]
        
        let slotStrings: [String] = try await Fetch.get(endpoint: "/vets/hours/read", queryParams: queryParams, headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
        
        let calendar = Calendar(identifier: .gregorian)
        let midnight = calendar.startOfDay(for: date)
        
        let slots: [Date] = slotStrings.compactMap { string in
            let components = string.split(separator: ":")
            guard
                components.count == 2,
                let hour = Int(components[0]),
                let minute = Int(components[1])
            else { return nil }
            return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: midnight)
        }

        return slots
    }
    
    static func create(_ appointment: AppointmentCreateRequest) async throws -> EmptyResponse {
        return try await Fetch.post(endpoint: "/vets/appointments/create", body: appointment, headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
}
