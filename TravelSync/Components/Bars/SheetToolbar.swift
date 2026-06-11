//
//  SheetToolbar.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import SwiftUI

struct SheetToolbar: View {
    @Environment(\.dismiss) private var dismiss
    
    let title: String
    let enableSave: Bool
    let saveAction: () -> Void
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.accentPrimary)
            
            Text(title)
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 20, weight: .semibold))
                .padding(.leading, 5)
                .frame(maxWidth: .infinity)
            
            Button {
                saveAction()
            } label: {
                Text("Save")
            }
            .fontWeight(.semibold)
            .foregroundStyle(.accentPrimary)
            .frame(maxWidth: .infinity)
            .disabled(!enableSave)
            .opacity(!enableSave ? 0.5 : 1.0)
            .animation(.smooth, value: enableSave)
        }
    }
}

#Preview {
    SheetToolbar(title: "Add a Trip", enableSave: true) { }
}
