//
//  EditPersonalInfoScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct EditPersonalInfoScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: UserSessionViewModel
    
    let user: User
    
    init(user: User, viewModel: UserSessionViewModel) {
        _viewModel = State(wrappedValue: viewModel)
        self.user = user
    }
    
    var body: some View {
        ScrollView {
            VStack {
                // TODO: Fix this when you get a chance
//                ProfileImage(
//                    imageURL: viewModel.currentUser.profileImage,
//                    selectedImage: viewModel.selectedProfileImage,
//                    canEditPhoto: true
//                )
//                .frame(width: 100, height: 100)
                
                Text("PROFILE PHOTO")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.secondaryText)
            }
            .padding()
            
            VStack(spacing: 25) {
                TSInputTextField(inputText: $viewModel.username, option: .name, title: "Username", content: "Edit Username")
                
                TSInputTextField(inputText:  $viewModel.fullName, option: .username, title: "Full Name", content: "Edit Name")
                
                TSInputTextField(inputText: $viewModel.email, option: .email, title: "Email", content: "Edit Email")
            }
            .padding()
            
            TSFillButton(
                title: "Save Changes") {
                    
                }
                .padding()
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Personal Information")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditPersonalInfoScreen(user: User.example, viewModel: UserSessionViewModel(userService: UserService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
