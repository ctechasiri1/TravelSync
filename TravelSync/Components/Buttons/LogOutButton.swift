//
//  LogOutButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import SwiftUI

struct LogOutButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Logout")
                .foregroundStyle(Color.accentWarning)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .createCardBackgroud()
    }
}

#Preview {
    LogOutButton(action: {})
}
