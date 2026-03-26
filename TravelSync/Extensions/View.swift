//
//  View.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/25/26.
//

import SwiftUI

extension View {
    func showLoading(if isLoading: Bool) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading))
    }
}
