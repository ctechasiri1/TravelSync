//
//  LoginView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct LoginView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
            
            GroupCard {
                VStack(alignment: .leading) {
                    LoginTitleSection()
                    
                    AuthFieldsSection(username: $viewModel.username, password: $viewModel.password)
                    
                    TSTextButton(text: "Forgot Password?", fontStyle: .footnote) {
                        // TODO: Insert the forgot password feature
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                            
                    TSFillButton(title: "Login", isLoading: viewModel.isLoading) {
                        Task {
                            await viewModel.login()
                        }
                    }
                            
                    Spacer()
                    
                    PromptSignUpSection {
                        appState.navigate(to: .signUp)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding()
            .padding(.vertical, 10)
        }
        .onChange(of: viewModel.didLoginSucceed) { _, succeeded in
            withAnimation {
                if succeeded {
                    appState.navigate(to: .home)
                }
            }
        }
        .showToast(toastOption: $viewModel.toastOption, text: viewModel.errorMessage)
        .ignoresSafeArea(edges: .bottom)
    }
}

private struct LoginTitleSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "safari")
                .bold()
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.accentPrimary)
                        .frame(width: 50, height: 50)
                )
                .padding()
                .padding(.top, 20)
            
            Text("Welcome Back,")
                .font(.system(.title, weight: .semibold))
            
            Text("Explorer!")
                .font(.system(.title, weight: .semibold))
                .foregroundStyle(.accentPrimary)
            
            Text("Continue to your adventure where you left off.")
                .font(.system(.subheadline))
                .foregroundStyle(.secondaryText.opacity(0.6))
        }
    }
}

private struct AuthFieldsSection: View {
    
    @Binding var username: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 15) {
            InputTextField(
                text: $username,
                fieldTitle: "Email",
                fieldImage: "envelope",
                fieldContent: "hello@example.com",
                iconColor: .gray
            )
            .padding(.top)
            .textInputAutocapitalization(.never)
            
            InputTextField(
                text: $password,
                isSecureField: true,
                toggleSecurityButton: true,
                fieldTitle: "Password",
                fieldImage: "lock",
                fieldContent: "••••••••••",
                iconColor: .gray
            )
            .textInputAutocapitalization(.never)
        }
    }
}

private struct PromptSignUpSection: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text("Don't have an account?")
                .foregroundStyle(.secondaryText.opacity(0.6))
                    
            TSTextButton(text: "Sign Up") {
                action()
            }
        }
        .padding()
        .font(.system(.subheadline))
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    LoginView(
        viewModel: LoginViewModel(
            userAuthService: UserAuthService(
                networkService: NetworkRequestService(),
                keychainService: KeychainService()
            )
        )
    )
    .environment(AppState())
}
