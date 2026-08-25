//
//  TSPhotoPicker.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 8/21/26.
//

import SwiftUI
import _PhotosUI_SwiftUI

enum PickerShapeOption {
    case circle, pill
}

struct TSPhotoPicker: View {
    
    @Binding var coverUIImage: UIImage?
    let pickerIconName: String
    let pickerTitle: String?
    let pickerShape: PickerShapeOption
    
    @State private var selectedImage: PhotosPickerItem?
    
    init(coverUIImage: Binding<UIImage?>, pickerIconName: String, pickerTitle: String? = nil,
         pickerShape: PickerShapeOption) {
        self._coverUIImage = coverUIImage
        self.pickerIconName = pickerIconName
        self.pickerTitle = pickerTitle
        self.pickerShape = pickerShape
    }
    
    var body: some View {
        PhotosPicker(selection: $selectedImage) {
            HStack {
                Image(systemName: pickerIconName)
                
                if let title = pickerTitle {
                    Text(title)
                }
            }
            .padding()
            .foregroundStyle(Color.white)
            .background(
                Group {
                    switch pickerShape {
                    case .circle:
                       Circle()
                            .fill(.accentPrimary)
                            .strokeBorder(.white, lineWidth: 2)
                    case .pill:
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.white.opacity(0.3))
                            .strokeBorder(Color.white, lineWidth: 1)
                    }
                }
            )
        }
        .onChange(of: selectedImage, { oldPickerItem, newPickerItem in
            Task {
                coverUIImage = await newPickerItem?.convertPhotoPickerItemToUIImage()
            }
        })
    }
}

#Preview("Circle Photo Picker") {
    @State @Previewable var coverUIImageURL: UIImage? = nil
    
    ZStack {
        Color.secondary
            .ignoresSafeArea()
        
        TSPhotoPicker(coverUIImage: $coverUIImageURL, pickerIconName: "camera.fill", pickerShape: .circle)
    }
}

#Preview("Pill Photo Picker") {
    @State @Previewable var coverUIImageURL: UIImage? = nil
    
    ZStack {
        Color.secondary
            .ignoresSafeArea()
        
        TSPhotoPicker(coverUIImage: $coverUIImageURL, pickerIconName: "camera.fill", pickerTitle: "Select Photo", pickerShape: .pill)
            .frame(width: 180, height: 40)
    }
}
