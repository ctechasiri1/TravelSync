//
//  GroupCard.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

// TODO: All of this needs to be seperated out too, i can rethink to make this simplier
// This creates a 'group' for multiples views to be passed into
struct GroupCard<T: View>: View {
    let title: String?
    @ViewBuilder let content: () -> T
    
    init(title: String? = nil, @ViewBuilder content: @escaping () -> T) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if let unwrappedTitle = title {
                Text(unwrappedTitle)
                    .sectionTitle()
                    .padding(.leading, 5)
            }
            
            VStack {
                content()
            }
            .cardBackground()
        }
    }
}

#Preview {
    @State @Previewable var isOn: Bool = false
    
//    GroupCard(title: "ACCOUNT") {
//        TSToggleRow(title: "Dark Mode", iconName: TSSystemImage.moonFill, isOn: $isOn)
//            .padding()
//        
//        TSToggleRow(title: "Dark Mode", iconName: TSSystemImage.moonFill, isOn: $isOn)
//            .padding()
//        
//        TSToggleRow(title: "Dark Mode", iconName: TSSystemImage.moonFill, isOn: $isOn)
//            .padding()
//    }
    
    List {
        Section("Account") {
            TSToggleRow(title: "Dark Mode", iconName: TSSystemImageName.moonFill, isOn: $isOn)
                .padding()
        }
    }
}
