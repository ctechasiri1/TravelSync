//
//  SignUpView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct TSSignUpView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
            
            GroupCard {
                VStack(alignment: .center, spacing: 5) {
                    Text(L10n.TSSignUpView.title)
                        .font(.system(.title, weight: .semibold))
                        .padding(.top)
                        
                    Text(L10n.TSSignUpView.subtitle)
                        .font(.system(.subheadline))
                        .foregroundStyle(.secondaryText.opacity(0.6))
                        .padding(.bottom)
                    
                    VStack(spacing: 20) {
                        TSInputTextField(
                            inputText: $viewModel.fullName,
                            option: .name,
                            title: L10n.TSTextField.fullNameTitle,
                            content: L10n.TSTextField.fullNamePlaceHolder
                        )
                        
                        TSInputTextField(
                            inputText: $viewModel.username,
                            option: .username,
                            title: L10n.TSTextField.usernameTitle,
                            content: L10n.TSTextField.usernamePlaceholder
                        )
                        
                        TSInputTextField(
                            inputText: $viewModel.email,
                            option: .email,
                            title: L10n.TSTextField.emailTitle,
                            content: L10n.TSTextField.emailPlaceholder
                        )
                        
                        TSInputTextField(
                            inputText: $viewModel.password,
                            showSecuredFieldButton: true,
                            option: .password,
                            title: L10n.TSTextField.passwordTitle,
                            content: L10n.TSTextField.passwordPlaceholder
                        )
                    }
                    
                    Spacer()
                    
                    PromptLoginSection {
                        appState.navigate(to: .login)
                    }
//                    .background(.red)
                }
                .padding()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.didSignUpSucceed) { _, succeeded in
            if succeeded {
                appState.navigate(to: .login)
            }
        }
        .showToast(toastOption: $viewModel.toastOption, text: viewModel.errorMessage)
    }
    
    private func onSignUpButtonPressed() {
        Task {
            await viewModel.signup()
        }
    }
}

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
        HStack(spacing: 10) {
            Text(L10n.TSSignUpView.loginDescription)
                .foregroundStyle(.secondaryText.opacity(0.6))
                
            TSTextButton(title: L10n.TSSignUpView.login) {
                action()
            }
            .frame(width: 80, alignment: .leading)
        }
        .padding()
        .font(.system(.subheadline))
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview("SignUpView") {
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

#Preview("TSSignUpView") {
    TSSignUpView(
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
