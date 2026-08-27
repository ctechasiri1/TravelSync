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
                TSInputTextField(inputText: $viewModel.username, title: "USERNAME", iconName: TSSystemImageName.pencil, content: "Edit Username", iconColor: .gray)
                
                TSInputTextField(inputText: $viewModel.fullName, title: "FULL NAME", iconName: TSSystemImageName.personFill, content: "Edit Name", iconColor: .gray)
                

                TSInputTextField(inputText:  $viewModel.email, title: "EMAIL", iconName: TSSystemImageName.envelopeFill, content: "Edit Email", iconColor: .gray)
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
