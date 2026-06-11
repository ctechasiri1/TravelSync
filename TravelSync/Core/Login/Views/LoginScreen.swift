//
//  LoginScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct LoginScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
            OptionsCard(title: "") {
                VStack(alignment: .leading) {
                    LoginIcon()
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
                    
                    VStack(spacing: 15) {
                        InputTextField(
                            text: $viewModel.username,
                            fieldTitle: "Email",
                            fieldImage: "envelope",
                            fieldContent: "hello@example.com",
                            iconColor: .gray
                        )
                        .padding(.top)
                        .textInputAutocapitalization(.never)
                        
                        InputTextField(
                            text: $viewModel.password,
                            isSecureField: true,
                            toggleSecurityButton: true,
                            fieldTitle: "Password",
                            fieldImage: "lock",
                            fieldContent: "••••••••••",
                            iconColor: .gray
                        )
                        .textInputAutocapitalization(.never)
                    }
                            
                    TextNavigationButton(text: "Forgot Password?") {
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                    
                    MultipurposeButton(
                        buttonText: "Login",
                        foregroundColor: .white,
                        backgroundColor: .accentPrimary) {
                            Task {
                                await viewModel.login()
                            }
                        }
                            
                    Spacer()
                            
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.secondaryText.opacity(0.6))
                                
                        TextNavigationButton(text: "Sign Up") {
                            appState.navigate(to: .signUp)
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
        .onChange(of: viewModel.didLoginSucceed) { _, succeeded in
            withAnimation {
                if succeeded {
                    appState.navigate(to: .home)
                }
            }
        }
        .showToast(toastOption: $viewModel.toastOption, text: viewModel.errorMessage)
    }
}

private struct LoginIcon: View {
    var body: some View {
        Image(systemName: "safari")
            .bold()
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.accentPrimary)
                    .frame(width: 50, height: 50)
            )
    }
}

struct TextNavigationButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.system(.subheadline, weight: .semibold))
                .foregroundStyle(.accentPrimary)
        }
    }
}

#Preview {
    LoginScreen(viewModel: LoginViewModel(userAuthService:
                                            UserAuthService(
                                                networkService: NetworkRequestService(),
                                                keychainService: KeychainService()
                                            )))
        .environment(AppState())
}
