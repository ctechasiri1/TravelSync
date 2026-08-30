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
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
//                    CoverImage(coverUIImage: $viewModel.eventCoverImage)
//                        .padding(.horizontal, 10)
                    
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
                        TSInputTextField(inputText: $viewModel.eventName, option: .name, title: "Event Name", content: "e.g. Sushi Dinner")
                        
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
                            TSTimePicker(
                                selectedTime: $viewModel.startTime,
                                title: "START TIME"
                            )
                            
                            Image(systemName: "arrow.right")
                                .padding(.top, 25)
                            
                            TSTimePicker(
                                selectedTime: $viewModel.endTime,
                                title: "END TIME"
                            )
                        }
                        .frame(height: 80, alignment: .center)
                        
                        InputMultilineTextField(
                            notesContent: $viewModel.notes,
                            fieldTitle: "NOTES"
                        )
                        
                        TSFillButton(title: "Save to Itinerary") {
                                
                        }
                    }
                    .padding(.horizontal)
                }
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
                    TSIcon(iconShape: .circle, iconName: event.imageName, iconColor: isSelected ? .accentPrimary : .secondaryText
                        .opacity(0.5))
                    .frame(width: 40, height: 40)
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
