//
//  EventDetailView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import MapKit
import SwiftUI

struct EventDetailView: View {
    let event: Event
    
    @State private var tempPosition: MapCameraPosition
    @State private var showEventNotes: Bool
    private let linearGradientColor: [Color]
    
    init(event: Event) {
        self.event = event
        self.tempPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        self.showEventNotes = false
        self.linearGradientColor = [
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
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
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
                    .overlay {
                        EventDetailCard(event: event)
                            .padding(.top, 300)
                    }
                    .padding(.bottom, 80)
                    
                    EventNotesButton(showNotes: $showEventNotes, event: event)
                    
                    LocationButton(event: event)
                }
            }
        }
    }
}

private struct EventDetailCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("EXPERIENCE")
                    .foregroundStyle(Color.accentPrimary)
                    .font(.system(size: 15, weight: .semibold))
                
                Spacer()
            }
            .padding([.top, .leading, .trailing])
            
            Text(event.title)
                .font(.system(size: 40, weight: .semibold))
                .padding(.horizontal)
                .padding(.top, 5)
            
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

private struct EventNotesButton: View {
    @Binding var showNotes: Bool
    let event: Event
    
    var body: some View {
        VStack {
            HStack {
                CircleIcon(
                    iconName: "line.3.horizontal",
                    iconColor: .accentPrimary,
                    width: 50,
                    height: 50
                )
                .padding()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Event Notes")
                        .font(.system(size: 15, weight: .semibold))
                }
                
                Spacer()
                
                Button {
                    showNotes.toggle()
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.secondaryText)
                        .rotationEffect(Angle(degrees: showNotes ? 180 : 0))
                }
            }
            if showNotes {
                Text(event.notes)
                    .foregroundStyle(.secondaryText)
                    .padding()
            }
        }
        .padding(20)
        .createCardBackgroud()
        .padding()
    }
}

private struct LocationButton: View {
    let event: Event
    
    var body: some View {
        VStack {
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
            }
            Button {
                
            } label: {
                Text("Open Maps")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(.accentPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
        }
        .padding(20)
        .createCardBackgroud()
        .padding()
    }
}



#Preview {
    EventDetailView(event: Event.example.last!)
}
