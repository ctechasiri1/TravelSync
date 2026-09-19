//
//  TSSegmentButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 8/18/26.
//

import SwiftUI

protocol SegmentOption: Hashable, CaseIterable, Identifiable {
    var title: String { get }
}

// MARK: All custom of type SegmentOption.self will automatically have these parameters and prevent boilerplate
extension SegmentOption where Self: RawRepresentable, RawValue == String {
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
}

struct TSSegmentBar<Option: SegmentOption>: View {
    
    @Binding var selectedSegment: Option
    @Namespace var transition
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(Option.allCases)) { segment in
                Button {
                    selectedSegment = segment
                } label: {
                    VStack {
                        Text(segment.title)
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

#Preview("TripFeedView Segment Options") {
    @State @Previewable var selectedSegment: TripsFeedSegmentOption = .upcoming
    
    TSSegmentBar(selectedSegment: $selectedSegment)
}
