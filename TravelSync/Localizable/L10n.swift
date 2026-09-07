//
//  L10n.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/6/26.
//

import Foundation

enum L10n {
    enum TSLoadingView {
        static let title = String(localized: "tsLoadingView_title")
        static let subtitle = String(localized: "tsLoadingView_subtitle")
        static let loadingText = String(localized: "tsLoadingView_loading_text")
    }
    enum TSTabBarView {
        static let calendar = String(localized: "tsTabBarView_calendar")
        static let home = String(localized: "tsTabBarView_home")
        static let profile = String(localized: "tsTabBarView_profile")
        static let search =  String(localized: "tsTabBarView_search")
    }
    
    enum TSLoginView {
        static let title1 = String(localized: "tsLoginView_title_welcome_back")
        static let title2 = String(localized: "tsLoginView_title_explorer")
        static let subtitle = String(localized: "tsLoginView_subtitle")
        static let signUp = String(localized: "tsLoginView_signUp")
        static let signUpDescription = String(localized: "tsLoginView_signUp_description")
    }
    
    enum TSSignUpView {
        static let title = String(localized: "tsSignUpView_title")
        static let subtitle = String(localized: "tsSignUpView_subtitle")
        static let login = String(localized: "tsSignUpView_login")
        static let loginDescription = String(localized: "tsSignUpView_login_description")
    }
    
    enum TSTextField {
        static let emailTitle = String(localized: "tsTextField_email_title")
        static let emailPlaceholder = String(localized: "tsTextField_email_placeholder")
        static let passwordTitle = String(localized: "tsTextField_password_title")
        static let passwordPlaceholder = String(localized: "tsTextField_password_placeholder")
        static let fullNameTitle = String(localized: "tsTextField_fullname_title")
        static let fullNamePlaceHolder = String(localized: "tsTextField_fullname_placeholder")
        static let usernameTitle = String(localized: "tsTextField_username_title")
        static let usernamePlaceholder = String(localized: "tsTextField_username_placeholder")
    }
}
