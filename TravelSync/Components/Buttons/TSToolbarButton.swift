//
//  TSToolbarButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 7/17/26.
//

import SwiftUI

enum ToolbarOption {
    case add
    case delete
    case save
    case cancel
}

extension View {
    func saveCancelToolbar(isEnabled: Bool = true, cancelAction: @escaping () -> Void, saveAction: @escaping () -> Void) -> some View {
        self
            .toolbar {
                TSToolbarButton(option: .cancel, placement: .cancellationAction) { cancelAction() }
                TSToolbarButton(option: .save, placement: .confirmationAction, isEnabled: isEnabled) { saveAction() }
            }
    }
}

struct TSToolbarButton: ToolbarContent {
    
    let option: ToolbarOption
    let placement: ToolbarItemPlacement
    let isEnabled: Bool?
    let action: () -> Void
    
    init(option: ToolbarOption, placement: ToolbarItemPlacement, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.option = option
        self.placement = placement
        self.isEnabled = isEnabled
        self.action = action
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Group {
                switch option {
                case .add:
                    addButton
                case .delete:
                    deleteButton
                case .save:
                    saveButton
                case .cancel:
                    cancelButton
                }
            }
            .disabled(!(isEnabled ?? true))
            .opacity(!(isEnabled ?? true) ? 0.5 : 1.0)
            .animation(.smooth, value: isEnabled)
        }
        .sharedBackgroundVisibility(.hidden)
    }

    private var addButton: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .padding(8)
                .background(.accentPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .imageScale(.medium)
        }
    }
    
    private var deleteButton: some View {
        Button {
            action()
        } label: {
            Image(systemName: "trash.fill")
                .foregroundStyle(.accentPrimary)
                .imageScale(.large)
        }
    }
        
    private var saveButton: some View {
        Button {
            action()
        } label: {
            Text("Save")
        }
        .foregroundStyle(.accentPrimary)
        .fontWeight(.semibold)
    }
    
    private var cancelButton: some View {
        Button {
            action()
        } label: {
            Text("Cancel")
        }
        .foregroundStyle(.accentPrimary)
        .fontWeight(.semibold)
    }
}

#Preview("Image Buttons") {
    @State @Previewable var isEnabled: Bool = true
    
    NavigationStack {
        VStack {
            Text("Toolbar Buttons")
        }
        .navigationTitle("Toolbar Buttons")
        .toolbar {
            TSToolbarButton(option: .add, placement: .topBarTrailing) { }
            TSToolbarButton(option: .delete, placement: .topBarLeading, isEnabled: isEnabled) { }
        }
    }
}

#Preview("Text Buttons") {
    @State @Previewable var isEnabled: Bool = true
    
    NavigationStack {
        VStack {
            Text("Toolbar Buttons")
        }
        .navigationTitle("Toolbar Buttons")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            TSToolbarButton(option: .save, placement: .topBarTrailing) { }
            TSToolbarButton(option: .cancel, placement: .topBarLeading, isEnabled: isEnabled) { }
        }
    }
}
