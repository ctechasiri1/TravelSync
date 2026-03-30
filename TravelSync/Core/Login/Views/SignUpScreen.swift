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
            Spacer()
            OptionsCard(title: "") {
                Spacer()
                    
                VStack(alignment: .center) {
                    Text("Create Your Account")
                        .font(.system(.title, weight: .semibold))
                        .padding(.top)
                        
                    Text("Start your next adventure today.")
                        .font(.system(.subheadline))
                        .foregroundStyle(.secondaryText.opacity(0.6))
                        .padding(.bottom)
                    
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
                        
                    SignUpButton {
                        Task {
                            await loginViewModel.signup()
                        }
                    }
                        
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
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct SignUpDivider: View {
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

private struct SignUpButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Sign Up")
                .font(.system(.subheadline, weight: .semibold))
                .padding()
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .background(.accentPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
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
