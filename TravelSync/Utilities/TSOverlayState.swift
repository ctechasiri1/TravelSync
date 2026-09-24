//
//  TSOverlayState.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/23/26.
//

import Observation
import Foundation

@Observable
@MainActor

final class TSOverlayState {
    private(set) var toastOption: ToastOption = .idle
    private(set) var modalOption: ModalOption?
    
    private(set) var isLoading: Bool = false
    private(set) var isModalPresented: Bool = false
    
    func setToast(to option: ToastOption) {
        toastOption = option
    }
    
    func hideToast() {
        toastOption = .idle
    }
    
    func showLoader() {
        isLoading = true
    }
    
    func hideLoader() {
        isLoading = false
    }
    
    func setModal(modalOption: ModalOption) {
        self.modalOption = modalOption
        isModalPresented = true
    }
    
    func hideModal() {
        isModalPresented = false
    }
}
