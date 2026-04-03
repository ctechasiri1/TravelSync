//
//  CustomSegmentButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct CustomSegmentButton: View {
    @Binding var selection: TripOption
    @Namespace private var namespace
    let options: [TripOption]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selection = option
                    }
                } label: {
                    Text(option.title)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(selection == option ? Color.primaryText.opacity(0.7) : Color.secondaryText)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background {
                            if selection == option {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.secondaryBackground)
                                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                                    .matchedGeometryEffect(id: "selection", in: namespace)
                            }
                        }
                }
            }
        }
        .padding(2)
        .background(Color.tertiaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(5)
        .background(
            Capsule()
                .strokeBorder(Color.secondaryBackground, lineWidth: 0.2)
                .background(Color.tertiaryBackground)
                .clipped()
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    @State @Previewable var selection: TripOption = .upcoming
    
    CustomSegmentButton(selection: $selection, options: TripOption.allCases)
}
