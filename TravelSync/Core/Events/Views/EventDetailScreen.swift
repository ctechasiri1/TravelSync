//
//  EventDetailScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import SwiftUI

struct EventDetailScreen: View {
    let event: Event
    
    var body: some View {
        ScrollView {
            VStack {
                Text(event.title)
                
                VStack {
                    HStack {
                        Text("SCHEDULE")
                        
                        Spacer()
                        
                        Image(systemName: "clock")
                    }
                    
                    HStack {
                        Text("\(event.startTime)")
                        
                        Text("\(event.endTime)")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    EventDetailScreen(event: Event.example.first!)
}
