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
                    
                    AuthDivider(text: "Or continue with")
                        .padding()
                            
                    HStack(spacing: 20) {
                        SocialLoginButton(iconImage: "google_icon",text: "Google") {
                                    
                        }
                            
                        SocialLoginButton(iconImage: "apple_icon", text: "Apple") {
                                    
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

#Preview {
    LoginScreen()
        .environment(AppState())
}
