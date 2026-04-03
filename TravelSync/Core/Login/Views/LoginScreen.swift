//
//  LoginScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct LoginScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var loginViewModel = appState.login
        
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
                            text: $loginViewModel.email,
                            fieldTitle: "Email",
                            fieldImage: "envelope",
                            fieldContent: "hello@example.com",
                            iconColor: .gray
                        )
                        .padding(.top)
                        
                        InputTextField(
                            text: $loginViewModel.password,
                            isSecureField: true,
                            toggleSecurityButton: true,
                            fieldTitle: "Password",
                            fieldImage: "lock",
                            fieldContent: "••••••••••",
                            iconColor: .gray
                        )
                    }
                            
                    TextNavigationButton(text: "Forgot Password?") {
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    AuthButton(
                        text: "Login",
                        foregroundColor: .white,
                        backgroundColor: .accentPrimary) {
                            Task {
                                await loginViewModel.login()
                            }
                        }
                            
                    LoginDivider()
                        .padding()
                            
                    HStack(spacing: 20) {
                        LoginOptionButton(
                            iconImage: "googleIcon",
                            text: "Google"
                        ) {
                                    
                        }
                            
                        LoginOptionButton(
                            iconImage: "appleIcon",
                            text: "Apple"
                        ) {
                                    
                        }
                    }
                    .frame(maxWidth: .infinity)
                            
                    Spacer()
                            
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.secondaryText.opacity(0.6))
                                
                        TextNavigationButton(text: "Sign Up") {
                            loginViewModel.loginAppState = .signUp
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
        }
//        .showLoading(if: loginViewModel.isNetworkActive)
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

private struct LoginDivider: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 0.5)

            Text("Or continue with")
                .font(.system(size: 15))
                .frame(width: 120)
                
            Rectangle()
                .frame(height: 0.5)
                
        }
        .foregroundStyle(.secondaryText.opacity(0.6))
    }
}

private struct TextNavigationButton: View {
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

private struct LoginOptionButton: View {
    let iconImage: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            OptionsCard(title: "") {
                HStack {
                    Image(iconImage)
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text(text)
                        .font(.caption)
                        .foregroundStyle(.black)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    LoginScreen()
        .environment(AppState())
}
