//
//  CoverImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/4/26.
//

import PhotosUI
import SwiftUI

struct CoverImage: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var planNewTripViewModel = appState.planNewTrip
        
        ZStack(alignment: .bottomTrailing) {
            planNewTripViewModel.displayImage
                .resizable()
                .scaledToFill()
                .frame(width: 375, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            PhotosPicker(selection: $planNewTripViewModel.selectedItem) {
                HStack {
                    Image(systemName: "camera.fill")
                    
                    Text("Edit Cover")
                        .font(.system(size: 15, weight: .bold))
                }
                    .foregroundStyle(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.white.opacity(0.3))
                            .strokeBorder(Color.white, lineWidth: 1)
                            .frame(width: 150, height: 40)
                            .foregroundStyle(Color.accentBlue)
                    )
            }
            .offset(x: -40, y: -25)
        }
        .onChange(of: planNewTripViewModel.selectedItem) { _, newItem in
            handleImageChange(newItem, in: planNewTripViewModel)
        }
    }
    
    private func handleImageChange(_ item: PhotosPickerItem?, in viewModel: PlanNewTripViewModel) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                viewModel.profileUIImage = uiImage
            }
        }
    }
}

#Preview {
    CoverImage()
        .environment(AppState())
}
