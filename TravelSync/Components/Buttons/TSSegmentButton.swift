//
//  TSSegmentButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 8/18/26.
//

import SwiftUI

struct TSSegmentButton: View {
    
    @Binding var selectedSegment: String
    @Namespace var transition
    
    private let segments: [String] = ["Upcoming", "Past"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selectedSegment = segment
                } label: {
                    VStack {
                        Text(segment)
                            .font(.system(.headline, weight: .medium))
                            .foregroundStyle(selectedSegment == segment ? .accentPrimary : .secondary)
                        
                        ZStack {
                            Capsule()
                                .foregroundStyle(.clear)
                                .frame(height: 4)
                            
                            if selectedSegment == segment {
                                Capsule()
                                    .foregroundStyle(.accentPrimary)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "SegmentTransition", in: transition)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @State @Previewable var selectedSegment: String = "Upcoming"
    
    TSSegmentButton(selectedSegment: $selectedSegment)
}
