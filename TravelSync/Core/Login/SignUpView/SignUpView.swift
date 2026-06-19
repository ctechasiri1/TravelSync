//
//  SignUpView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct SignUpView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground

            OptionsCard {
                VStack(alignment: .center) {
                    Text("Create Your Account")
                        .font(.system(.title, weight: .semibold))
                        .padding(.top)
                        
                    Text("Start your next adventure today.")
                        .font(.system(.subheadline))
                        .foregroundStyle(.secondaryText.opacity(0.6))
                        .padding(.bottom)
                    
                    VStack(spacing: 15) {
                        InputTextField(
                            text: $viewModel.fullName,
                            fieldTitle: "Full Name",
                            fieldImage: "pencil",
                            fieldContent: "Enter your name",
                            iconColor: .gray
                        )
                        
                        InputTextField(
                            text: $viewModel.username,
                            fieldTitle: "Username",
                            fieldImage: "person",
                            fieldContent: "Enter your username",
                            iconColor: .gray
                        )
                        
                        InputTextField(
                            text: $viewModel.email,
                            fieldTitle: "Email",
                            fieldImage: "envelope",
                            fieldContent: "hello@example.com",
                            iconColor: .gray
                        )
                        
                        InputTextField(
                            text: $viewModel.password,
                            isSecureField: true,
                            toggleSecurityButton: true,
                            fieldTitle: "Password",
                            fieldImage: "lock",
                            fieldContent: "••••••••••",
                            iconColor: .gray
                        )
                    }
                    .textInputAutocapitalization(.never)
                        
                    MultipurposeButton(
                        buttonText: "Sign Up",
                        foregroundColor: .white,
                        backgroundColor: .accentPrimary) {
                            Task {
                                await viewModel.signup()
                            }
                        }
                        .padding(.top)
                        
                    Spacer()
                        
                    HStack {
                        Text("Already have an account?")
                            .foregroundStyle(.secondaryText.opacity(0.6))
                            
                        TextButton(text: "Sign In") {
                            appState.navigate(to: .login)
                        }
                    }
                    .padding()
                    .font(.system(.subheadline))
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding()
            .padding(.vertical, 10)
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.didSignUpSucceed) { _, succeeded in
            if succeeded {
                appState.navigate(to: .login)
            }
        }
        .showLoading(isLoading: viewModel.isNetworkActive)
        .showToast(toastOption: $viewModel.toastOption, text: viewModel.errorMessage)
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel(userAuthService: UserAuthService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
