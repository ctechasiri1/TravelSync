//
//  SignUpScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground

            OptionsCard(title: "") {
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
                            fieldImage: "person.fill",
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
                        
                    AuthButton(
                        text: "Sign Up",
                        foregroundColor: .white,
                        backgroundColor: .accentPrimary) {
                            Task {
                                await viewModel.signup()
                            }
                        }
                        .padding(.top)
                        
                    AuthDivider(text: "Or sign up with")
                        .padding()
                        
                    HStack(spacing: 20) {
                        SocialLoginButton(
                            iconImage: "google_icon",
                            text: "Google"
                        ) {
 
                        }
                        SocialLoginButton(iconImage: "apple_icon",text: "Apple") {
 
                        }
                    }
                    .frame(maxWidth: .infinity)
                        
                    Spacer()
                        
                    HStack {
                        Text("Already have an account?")
                            .foregroundStyle(.secondaryText.opacity(0.6))
                            
                        TextNavigationButton(text: "Sign In") {
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
            .padding(.vertical, 20)
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.didSignUpSucceed) { _, succeeded in
            if succeeded {
                appState.navigate(to: .login)
            }
        }
    }
}

#Preview {
    SignUpScreen(viewModel: SignUpViewModel(userAuthService: UserAuthService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
