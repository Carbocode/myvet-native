//
//  CalendarViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 01/09/25.
//

import Foundation

@Observable @MainActor
class CalendarViewModel: ObservableObject {
    let vet: Vet

    var selectedDate: Date?
    var selectedSlot: Date?
    var currentMonth: Date = Date()
    
    var calendar = Calendar.current
    
    
    var timeSlots: [Date] = []
    var isLoadingSlots: Bool = false
    var slotsError: String? = nil
    
    init(vet: Vet){
        self.vet = vet
        selectDate(.init())
    }

    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    func selectDate(_ date: Date) {
        selectedDate = date
        selectedSlot = nil
        Task { await fetchSlots(for: date) }
    }
    
    func selectSlot(_ slot: Date) {
        selectedSlot = slot
    }
    
    func fetchSlots(for date: Date) async {
        isLoadingSlots = true
        slotsError = nil
        do {
            timeSlots = try await AppointmentsActions.readSlots(date: date, idVeterinario: vet.idVeterinario)
        } catch {
            slotsError = error.localizedDescription
            timeSlots = []
        }
        isLoadingSlots = false
    }
}

