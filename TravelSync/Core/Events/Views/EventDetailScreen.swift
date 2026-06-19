//
//  EventDetailScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import MapKit
import SwiftUI

struct EventDetailScreen: View {
    let event: Event
    
    @State private var tempPosition: MapCameraPosition
    private let linearGradientColor: [Color] = [
        Color.white,
        Color.white.opacity(0.5),
        Color.white.opacity(0.2),
        Color.white.opacity(0.1),
        Color.white.opacity(0.05),
        Color.white.opacity(0.01),
        Color.white.opacity(0.05),
        Color.white.opacity(0.1),
        Color.white.opacity(0.2),
        Color.white.opacity(0.5),
        Color.white
    ]
    
    init(event: Event) {
        self.event = event
        self.tempPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 50) {
                    Map(position: $tempPosition) {
                        Marker(event.title, coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude))
                    }
                    .frame(width: 400, height: 400)
                    .overlay {
                        LinearGradient(
                            colors: linearGradientColor,
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                    
                    Spacer()
                    
                    VStack {
                        if !event.notes.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("EVENT NOTES")
                                    .foregroundStyle(Color.secondaryText)
                                    .font(.system(size: 15, weight: .semibold))
                                
                                Text(event.notes)
                            }
                            .padding(.horizontal)
                        }
                        
                        LocationButton(event: event)
                    }
                }

                EventDetailCard(event: event)
            }
        }
    }
}

private struct EventDetailCard: View {
    let event: Event
    
    var body: some View {
        VStack {
            HStack {
                Text("EXPERIENCE")
                    .foregroundStyle(Color.accentPrimary)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.leading, 5)
                
                Spacer()
            }
            .padding([.top, .leading, .trailing])
            
            Text(event.title)
                .font(.system(size: 40, weight: .semibold))
                .padding(5)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("SCHEDULE")
                        .foregroundStyle(Color.secondaryText)
                        .font(.system(size: 15, weight: .semibold))
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.accentPrimary)
                        
                        Text(event.startTime.formattedTime + ", " + event.startTime.formattedMonthDay)
                    }
                    .font(.system(size: 18, weight: .semibold))
                }
                .padding()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10){
                    Text("DURATION")
                        .foregroundStyle(Color.secondaryText)
                        .font(.system(size: 15, weight: .semibold))
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(.accentPrimary)
                        
                        Text(event.startTime.formattedDuration(to: event.endTime).capitalized)
                    }
                    .font(.system(size: 18, weight: .semibold))
                }
                .padding()
            }
        }
        .padding()
        .createCardBackgroud()
        .padding()
    }
}

private struct LocationButton: View {
    let event: Event
    
    var body: some View {
        HStack {
            CircleIcon(
                iconName: "map",
                iconColor: .accentPrimary,
                width: 50,
                height: 50
            )
            .padding()
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Location")
                    .foregroundStyle(Color.secondaryText)
                    .font(.system(size: 15, weight: .semibold))
                
                Text(event.location)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16, weight: .semibold))
                    .minimumScaleFactor(0.5)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Open Maps")
            }
            .foregroundStyle(.white)
            .padding()
            .background(.accentPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .padding(20)
        .createCardBackgroud()
        .padding()
    }
}

#Preview {
    EventDetailScreen(event: Event.example.last!)
    .environment(AppState())
}
