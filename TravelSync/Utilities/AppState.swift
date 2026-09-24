//
//  TSAppState.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import Observation
import Foundation

@MainActor
@Observable
class TSAppState {
    
//    private(set) var currentAuthScreen: AuthState = .loading
//    private(set) var prevAuthScreen: AuthState?
//    private(set) var toastOption: ToastOption = .idle
//    private(set) var modalOption: ModalOption?
    
    private(set) var hasBooted: Bool = false
//    private(set) var isLoading: Bool = false
//    private(set) var isModalPresented: Bool = false
    
    var isNotificationEnabled: Bool = false
    var isDarkModeEnabled: Bool = false
    
    let managers: ManagerContainer
    
    init(managers: ManagerContainer = ManagerContainer()) {
        self.managers = managers
    }
    
    func navigate(to flow: AuthState) {
        currentAuthScreen = flow
    }
    
//    func setToast(to option: ToastOption) {
//        toastOption = option
//    }
//    
//    func hideToast() {
//        toastOption = .idle
//    }
    
//    func setAuthScreen(to screen: AuthState) {
//        currentAuthScreen = screen
//    }
//    
//    func setPrevAuthScreen(to screen: AuthState) {
//        prevAuthScreen = screen
//    }
//    
    func setHasBooted(to state: Bool) {
        hasBooted = state
    }
    
//    func showLoader() {
//        isLoading = true
//    }
//    
//    func hideLoader() {
//        isLoading = false
//    }
//    
//    func setModal(modalOption: ModalOption) {
//        self.modalOption = modalOption
//        isModalPresented = true
//    }
//    
//    func hideModal() {
//        isModalPresented = false
//    }
}
