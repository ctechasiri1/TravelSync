//
//  DeleteConfirmationManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/30/26.
//

import Observation
import Foundation
import SwiftUI

@MainActor
@Observable
class DeleteConfirmationManager {
    var title: LocalizedStringKey?
    var description: LocalizedStringKey?
    var isPresented: Bool = false
    var deleteAction: () -> Void = {}
    
    func show(title: LocalizedStringKey, description: LocalizedStringKey, deleteAction: @escaping () -> Void) {
        self.isPresented = true
        self.title = title
        self.description = description
        self.deleteAction = deleteAction
    }
    
    func hide() {
        self.isPresented = false
    }
}
