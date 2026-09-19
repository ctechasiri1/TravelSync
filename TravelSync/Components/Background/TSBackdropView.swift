//
//  TSBackdropView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/18/26.
//

import SwiftUI

struct TSBackdropView: View {
    
    let action: (() -> Void)?
    
    init(action: (() -> Void)? = nil) {
        self.action = action
    }
    
    var body: some View {
        Color.gray.opacity(0.09)
            .ignoresSafeArea()
            .onTapGesture {
                action?()
            }
    }
}

#Preview {
    TSBackdropView()
}
