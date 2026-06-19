//
//  EventMapScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/20/26.
//

import CoreLocation
import MapKit
import SwiftUI

struct EventMapScreen: View {
    @Environment(AppState.self) private var appState
    let trip: Trip
    
    @State private var viewModel: EventMapViewModel
    
    init(trip: Trip, viewModel: EventMapViewModel) {
        self.trip = trip
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        Map(position: $viewModel.position, selection: $viewModel.selectedEvent) {
            ForEach(viewModel.locations, id: \.self) { event in
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)) {
                    CustomAnnotation(
                        event: event,
                        selectedEvent: viewModel.selectedEvent
                    )
                }
            }
        }
        .overlay(alignment: .bottom) {
            VStack {
                Spacer()
                
                if let event = viewModel.selectedEvent {
                    EventMapCard(event: $viewModel.selectedEvent) {
                        viewModel
                            .openInMaps(
                                latitude: event.latitude,
                                longitude: event.longitude,
                                name: event.location
                            )
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

private struct EventMapCard: View {
    @Binding var event: Event?
    let directionAction: () -> Void
    
    @State private var verticalDragAmount = 0.0
    @State private var opacityAmount = 1.0

    var body: some View {
        if let unwrappedEvent = event {
            VStack (alignment: .center){
                Capsule()
                    .frame(width: 50, height: 5)
                    .foregroundStyle(.secondaryText.opacity(0.2))
                    .padding(.bottom, 10)
                    
                VStack(alignment: .leading) {
                    HStack(spacing: 20) {
                        CircleIcon(
                            iconName: unwrappedEvent.category.imageName,
                            iconColor: .blue,
                            width: 50,
                            height: 50
                        )
                            
                        VStack(alignment: .leading, spacing: 5) {
                            Text("EXPERIENCE")
                                .foregroundStyle(.accentPrimary)
                                .font(.system(size: 14, weight: .semibold))
                                
                            Text(unwrappedEvent.title)
                                .font(.system(size: 20, weight: .semibold))
                                
                            Text(unwrappedEvent.location)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondaryText)
                        }
                    }
                }
                .padding()
                    
                HStack {
                    VStack(alignment: .leading) {
                        Text("SCHEDULE")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 12, weight: .semibold))
                            
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(.accentPrimary)
                                
                            Text(
                                unwrappedEvent.startTimeToString + ", " + unwrappedEvent.dateToString
                            )
                            .font(.system(size: 12, weight: .semibold))
                        }
                    }
                    .frame(maxWidth: .infinity)
                        
                    VStack(alignment: .leading) {
                        Text("DURATION")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 12, weight: .semibold))
                            
                        HStack {
                            Image(systemName: "clock")
                                .foregroundStyle(.accentPrimary)
                                
                            Text(unwrappedEvent.timeDuration)
                                .font(.system(size: 12, weight: .semibold))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 10)
                    
                HStack(alignment: .center) {
                    MultipurposeButton(
                        buttonImageString: "arrow.triangle.turn.up.right.circle",
                        buttonText: "Directions",
                        foregroundColor: .white,
                        backgroundColor: .accentPrimary) {
                            directionAction()
                        }
                        
                    NavigationLink {
                        EventDetailScreen(event: unwrappedEvent)
                    } label: {
                        HStack {
                            Image(systemName: "calendar")
                                
                            Text("View Event")
                        }
                        .applyButtonStyle(
                            foregroundColor: .black,
                            backgroundColor: .secondaryBackground
                        )
                    }
                }
                .padding(.vertical, 10)
            }
            .padding()
            .createCardBackgroud()
            .offset(y: verticalDragAmount)
            .opacity(opacityAmount)
            .onChange(of: event, { oldValue, newValue in
                onChangeEventAction(oldEvent: oldValue, newEvent: newValue)
            })
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        onChangeDragGestureAction(dragGesture: gesture)
                    }
                    .onEnded { gesture in
                        onEndDragGestureAction(dragGesture: gesture)
                    }
            )
            .padding()
        }
    }
    
    private func onChangeEventAction(oldEvent: Event?, newEvent: Event?) {
        if newEvent == oldEvent || event == newEvent {
            verticalDragAmount = 0
            opacityAmount = 1
        }
    }
    
    private func onChangeDragGestureAction(dragGesture: DragGesture.Value) {
        withAnimation(.smooth) {
            verticalDragAmount = dragGesture.translation.height
            if dragGesture.translation.height < 100 {
                opacityAmount = (100 - verticalDragAmount) / 100
            } else {
                opacityAmount = 0
            }
        }
    }
    
    private func onEndDragGestureAction(dragGesture: DragGesture.Value) {
        withAnimation(.smooth) {
            if dragGesture.translation.height > 100 {
                opacityAmount = 0
                event = nil
            } else {
                verticalDragAmount = 0
                opacityAmount = 1
            }
        }
    }
}

private struct CustomAnnotation: View {
    let event: Event
    let selectedEvent: Event?
    
    var body: some View {
        VStack(spacing: 2) {
            Circle()
                .fill(.accentPrimary)
                .frame(width: 35, height: 35)
                .overlay {
                    Image(systemName: "map")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 16, height: 16)
                }
            
            Image(systemName: "triangle.fill")
                .foregroundStyle(.accentPrimary)
                .frame(width: 0.5, height: 0.5)
                .rotationEffect(Angle(degrees: 180))
                .padding(.bottom, 5)
            
            ZStack {
                Text(event.title)
                    .foregroundStyle(.white)
                    .font(.system(size: 12.5, weight: .bold))
                
                Text(event.title)
                    .foregroundStyle(.black.opacity(0.9))
                    .font(.system(size: 12, weight: .bold))
            }
//            .padding()
//            .background(.primaryBackground)
//            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .scaleEffect(selectedEvent == event ? 1.1 : 1.0)
        .animation(.easeInOut, value: selectedEvent == event)
    }
}

#Preview {
    EventMapScreen(trip: Trip.example, viewModel: EventMapViewModel())
        .environment(AppState())
}
