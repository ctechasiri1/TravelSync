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
    }
}

private struct EventMapCard: View {
    @Binding var event: Event?
    let directionAction: () -> Void
    
    @State private var verticalDragAmount = 0.0
    @State private var opacityAmount = 1.0

    var body: some View {
        if let unwrapped = event {
            VStack (alignment: .center){
                Capsule()
                    .frame(width: 50, height: 5)
                    .foregroundStyle(.secondaryText.opacity(0.4))
                
                HStack(spacing: 20) {
                    Image(systemName: unwrapped.category.imageName)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    Color.secondaryText.opacity(0.4),
                                    style: StrokeStyle(lineWidth: 0.5)
                                )
                        )
                    
                    VStack(alignment: .leading) {
                        Text(unwrapped.title)
                            .font(.system(size: 20, weight: .semibold))
                        
                        Text(unwrapped.location)
                            .font(.system(size: 14))
                            .foregroundStyle(.secondaryText)
                    }
                }
                .padding([.horizontal, .top])
                
                HStack(alignment: .center) {
                    Button {
                        directionAction()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.triangle.turn.up.right.circle")
                            
                            Text("Directions")
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(.accentPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    
                    NavigationLink {
                        EventDetailScreen(event: unwrapped)
                    } label: {
                        HStack {
                            Image(systemName: "calendar")
                            
                            Text("View Event")
                        }
                        .padding()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    Color.secondaryText.opacity(0.2),
                                    style: StrokeStyle(lineWidth: 0.5)
                                )
                        )
                    }
                }
                .padding(.vertical, 10)
            }
            .padding()
            .createCardBackgroud()
            // TODO: Segment this out to a reusbale viewmodifier
            .offset(y: verticalDragAmount)
            .opacity(opacityAmount)
            .onChange(of: event, { oldValue, newValue in
                if newValue == oldValue || event == newValue {
                    verticalDragAmount = 0
                    opacityAmount = 1
                }
            })
            .gesture(
                DragGesture()
                    .onChanged { drag in
                        withAnimation {
                            verticalDragAmount = drag.translation.height
                            if drag.translation.height < 100 {
                                opacityAmount = (100 - verticalDragAmount) / 100
                            } else {
                                opacityAmount = 0
                            }
                        }
                    }
                    .onEnded { drag in
                        withAnimation {
                            if drag.translation.height > 100 {
                                opacityAmount = 0
                                event = nil
                            } else {
                                verticalDragAmount = 0
                                opacityAmount = 1
                            }
                        }
                    }
            )
            .padding()
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
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: "map.circle.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 30)
                }
            
            Image(systemName: "triangle.fill")
                .foregroundStyle(.accentPrimary)
                .frame(width: 2, height: 2)
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
        }
        .scaleEffect(selectedEvent == event ? 1.1 : 1)
        .animation(.easeInOut, value: selectedEvent == event)
    }
}

#Preview {
    EventMapScreen(trip: Trip.example, viewModel: EventMapViewModel())
        .environment(AppState())
}
