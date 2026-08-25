//
//  PhotoPickerItem+Ext.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 8/21/26.
//

import _PhotosUI_SwiftUI

extension PhotosPickerItem {
    func convertPhotoPickerItemToUIImage() async -> UIImage? {
        if let data = try? await self.loadTransferable(type: Data.self) {
            if let uiImage = UIImage(data: data) {
                return uiImage
            }
        }
        return nil
    }
}
