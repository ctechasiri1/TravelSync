//
//  CardRow.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 7/23/26.
//

import SwiftUI
import UIKit

enum CardRowOption {
    case navigation
    case toggle
}

struct CardRow<Destination: View>: View {
    
    let cardOption: CardRowOption
    let title: String
    let iconName: String
    let iconColor: Color
    let destination: Destination
    
    // TODO: Might need to come back here to fix make the bool optional
    @Binding var isOn: Bool
    
    init(cardOption: CardRowOption, title: String, iconName: String, iconColor: Color = .secondary, destination: Destination, isOn: Binding<Bool>? = nil) {
        self.cardOption = cardOption
        self.title = title
        self.iconName = iconName
        self.iconColor = iconColor
        self.destination = destination
            
        if let passBinding = isOn {
            self._isOn = passBinding
        } else {
            self._isOn = .constant(false)
        }
    }

    var body: some View {
        switch cardOption {
        case .navigation:
            NavigationOptionRow(
                title: title,
                iconName: iconName,
                iconColor: iconColor,
                destination: destination
            )
        case .toggle:
            ToggleOptionRow(
                title: title,
                iconName: iconName,
                isOn: $isOn
            )
        }
    }
}

struct NavigationOptionRow<Destination: View>: View {
    
    let title: String
    let iconName: String
    let iconColor: Color
    let destination: Destination
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Label {
                Text(title)
                    .foregroundColor(.primaryText)
            } icon: {
                Image(systemName: iconName)
                    .foregroundStyle(iconColor)
            }
        }
    }
}

struct ToggleOptionRow: View {
    
    let title: String
    let iconName: String
    
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Label {
                Text(title)
                    .foregroundColor(.primaryText)
            } icon: {
                Image(systemName: iconName)
                    .foregroundStyle(.secondaryText)
            }
        }
    }
}

#Preview("Combination Row") {
    
    @State @Previewable var isOn: Bool = false
    
    NavigationStack {
        List {
            Section("Personal Information") {
                CardRow(
                    cardOption: .navigation,
                    title: "Personal Information",
                    iconName: "person.fill",
                    destination: EmptyView()
                )
                .padding()
                
                ToggleOptionRow(title: "Dark Mode", iconName: "moon.fill", isOn: $isOn)
                    .padding()
            }
        }
    }
}

#Preview("Navigation Row") {
    NavigationStack {
        List {
            Section("Personal Information") {
                CardRow(
                    cardOption: .navigation,
                    title: "Personal Information",
                    iconName: "person.fill",
                    destination: EmptyView()
                )
                .padding()
            }
        }
    }
}

#Preview("Toggle Row") {
    
    @State @Previewable var isOn: Bool = false
    
    NavigationStack {
        List {
            Section("Personal Information") {
                ToggleOptionRow(title: "Dark Mode", iconName: "moon.fill", isOn: $isOn)
                    .padding()
            }
        }
    }
}
