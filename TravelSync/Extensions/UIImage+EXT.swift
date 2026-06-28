//
//  UIImage+EXT.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/4/26.
//

import Foundation
import UIKit

extension UIImage {
    var convertImageToData: Data? {
        return self.jpegData(compressionQuality: 0.8)
    }
}
