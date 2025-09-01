//
//  CalendarView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 31/08/25.
//

import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel: CalendarViewModel
    @Binding private var selectedDateTime: Date?
    @State private var selectedDate: Date

    // MARK: - Init
    init(vet: Vet, selectedDateTime: Binding<Date?>) {
        _viewModel = StateObject(wrappedValue: CalendarViewModel(vet: vet))
        _selectedDateTime = selectedDateTime
        // initialize date to today or a given selectedDateTime
        _selectedDate = State(initialValue: selectedDateTime.wrappedValue ?? Date())
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .onChange(of: selectedDate) { _, newDate in
                    viewModel.selectDate(newDate)
                }
                .padding(.horizontal)

            pickerSlot
        }
        .padding(.vertical)
        .onChange(of: viewModel.selectedSlot) { _, newSlot in
            selectedDateTime = newSlot
        }
        .onAppear {
            viewModel.selectDate(selectedDate)
        }
    }
    
    var pickerSlot: some View {
        VStack() {
            if viewModel.selectedDate != nil {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.timeSlots, id: \.self) { slot in
                            Button(action: {
                                viewModel.selectSlot(slot)
                            }) {
                                Text(viewModel.timeFormatter.string(from: slot))
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(viewModel.selectedSlot == slot ? Color.accentColor : Color.secondary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarView(vet: Vet.example, selectedDateTime: .constant(nil))
}

