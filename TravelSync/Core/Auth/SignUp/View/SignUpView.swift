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

            GroupCard {
                VStack(alignment: .center) {
                    SignUpTitleSection()

                    SignUpFormSection(
                        fullName: $viewModel.fullName,
                        username: $viewModel.username,
                        email: $viewModel.email,
                        password: $viewModel.password
                    )
                    
                    TSFillButton(
                        title: "Sign Up") {
                            onSignUpButtonPressed()
                        }
                        .padding(.top)
                        
                    Spacer()
                    
                    PromptLoginSection {
                        appState.navigate(to: .login)
                    }
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
        .showToast(toastOption: $viewModel.toastOption, text: viewModel.errorMessage)
        .ignoresSafeArea(edges: .bottom)
    }
    
    private func onSignUpButtonPressed() {
        Task {
            await viewModel.signup()
        }
    }
}

private struct SignUpTitleSection: View {
    var body: some View {
        Text("Create Your Account")
            .font(.system(.title, weight: .semibold))
            .padding(.top)
            
        Text("Start your next adventure today.")
            .font(.system(.subheadline))
            .foregroundStyle(.secondaryText.opacity(0.6))
            .padding(.bottom)
    }
}

private struct SignUpFormSection: View {
    
    @Binding var fullName: String
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 15) {
            TSInputTextField(inputText: $fullName, option: .name, title: "Full Name", content: "Enter your name")
            
            TSInputTextField(inputText: $username, option: .username, title: "Username", content: "Enter your username")
            
            TSInputTextField(inputText: $email, option: .email, title: "Email", content: "hello@example.com")
            
            TSInputTextField(inputText: $password, showSecuredFieldButton: true, option: .password, title: "Password", content: "••••••••••")
        }
    }
}

private struct PromptLoginSection: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text("Already have an account?")
                .foregroundStyle(.secondaryText.opacity(0.6))
                
            TSTextButton(title: "Sign In") {
                action()
            }
        }
        .padding()
        .font(.system(.subheadline))
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    SignUpView(
        viewModel: SignUpViewModel(
            userAuthService: UserAuthService(
                networkService: NetworkRequestService(),
                keychainService: KeychainService()
            ),
            loadingManager: LoadingManager()
        )
    )
    .environment(AppState())
}
