//
//  SignUpScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var loginViewModel = appState.login
        
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
                            text: $loginViewModel.fullName,
                            fieldTitle: "Full Name",
                            fieldImage: "pencil",
                            fieldContent: "Enter your name",
                            iconColor: .gray
                        )
                        
                        InputTextField(
                            text: $loginViewModel.username,
                            fieldTitle: "Username",
                            fieldImage: "person.fill",
                            fieldContent: "Enter your username",
                            iconColor: .gray
                        )
                        
                        InputTextField(
                            text: $loginViewModel.email,
                            fieldTitle: "Email",
                            fieldImage: "envelope",
                            fieldContent: "hello@example.com",
                            iconColor: .gray
                        )
                        
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
                        
                    AuthButton(
                        text: "Sign Up",
                        foregroundColor: .white,
                        backgroundColor: .accentPrimary) {
                            Task {
                                await loginViewModel.signup()
                            }
                        }
                        .padding(.top)
                        
                    SignUpDivider()
                        .padding()
                        
                    HStack(spacing: 20) {
                        SignUpOptionButton(
                            iconImage: "googleIcon",
                            text: "Google"
                        ) {
 
                        }
                        SignUpOptionButton(iconImage: "appleIcon",text: "Apple") {
 
                        }
                    }
                    .frame(maxWidth: .infinity)
                        
                    Spacer()
                        
                    HStack {
                        Text("Already have an account?")
                            .foregroundStyle(.secondaryText.opacity(0.6))
                            
                        TextNavigationButton(text: "Sign In") {
                            loginViewModel.loginAppState = .login
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
    }
}

private struct SignUpDivider: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 0.5)

            Text("Or sign up with")
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

private struct SignUpOptionButton: View {
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
    SignUpScreen()
        .environment(AppState())
}
