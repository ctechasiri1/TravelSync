//
//  PlanNewEventView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import SwiftUI

struct PlanNewEventView: View {
    @State private var viewModel: PlanNewEventViewModel
    
    init(viewModel: PlanNewEventViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            SheetToolBar(title: "Add Event", enableSave: true) {
                
            }
            
            VStack(spacing: 30) {
                CoverImage(coverUIImage: $viewModel.eventCoverImage)
                    .padding(.horizontal, 10)
                
                VStack (alignment: .leading){
                    Text("CATEGORY")
                        .padding(.horizontal)
                        .foregroundStyle(.primaryText)
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.leading, 5)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(EventOption.allCases, id: \.self) { event in
                                EventOptionButton(
                                    event: event,
                                    isSelected: viewModel.selectedEvent == event) {
                                        viewModel.selectedEvent = event
                                    }
                                    .padding(.vertical, 8)
                            }
                            .padding(.horizontal, 8)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                Group {
                    InputTextField(
                        text: $viewModel.eventName,
                        fieldTitle: "EVENT NAME",
                        fieldImage: "pencil",
                        fieldContent: "e.g. Sushi Dinner",
                        iconColor: .secondaryText
                    )
                    
                    InputLocationSearchField(
                        text: $viewModel.location,
                        fieldTitle: "LOCATION",
                        fieldImage: "magnifyingglass",
                        fieldContent: "Search for a place...",
                        iconColor: .secondaryText,
                        completions: viewModel.completions) {
                            
                        } onChangeAction: {
                            
                        }
                    
                    HStack {
                        TimePicker(
                            selectedTime: $viewModel.startTime,
                            pickerTitle: "START TIME"
                        )
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.secondaryText)
                            .padding(.top, 25)
                            .padding(.horizontal, 10)
                        
                        TimePicker(
                            selectedTime: $viewModel.endTime,
                            pickerTitle: "END TIME"
                        )
                    }
                    
                    InputMultilineTextField(
                        notesContent: $viewModel.notes,
                        fieldTitle: "NOTES"
                    )
                    
                    FillButton(
                        text: "Save to Itinerary") {
                            
                        }
                }
                .padding(.horizontal)
            }
        }
    }
}

private struct EventOptionButton: View {
    let event: EventOption
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    CircleIcon(
                        iconName: event.imageName,
                        iconColor: isSelected ? .accentPrimary : .secondaryText
                            .opacity(0.5),
                        width: 40,
                        height: 40
                    )
                    .padding([.top, .leading, .trailing])
                    
                    Text(event.title)
                        .foregroundStyle(
                            isSelected ? .accentPrimary : .secondaryText.opacity(0.5)
                        )
                        .font(.system(size: 12, weight: .semibold))
                        .padding(.top, 10)
                }
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 15)
            .cardBackground()
        }
    }
}

#Preview {
    PlanNewEventView(viewModel: PlanNewEventViewModel())
}
