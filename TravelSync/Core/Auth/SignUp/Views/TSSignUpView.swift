//
//  TSSignUpView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct TSSignUpView: View {
    @Environment(TSAppState.self) private var appState
    @State private var viewModel: TSSignUpViewModel
    
    init(viewModel: TSSignUpViewModel) {
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
                        
                        TSFillButton(title: "Sign Up", isLoading: appState.isLoading) {
                            viewModel.signup()
                        }
                        .padding(.vertical, 20)
                    }
                    
                    Spacer()
                    
                    PromptLoginSection {
                        appState.navigate(to: .login)
                    }
                }
                .padding()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
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
            .frame(width: 40, alignment: .leading)
        }
        .padding()
        .font(.system(.subheadline))
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview("TSSignUpView") {
    let appState: TSAppState = TSAppState()
    let viewModelFactory: TSViewModelFactory = TSViewModelFactory(appState: appState)
    
    TSSignUpView(viewModel: viewModelFactory.makeSignUpViewModel())
        .environment(appState)
        .environment(viewModelFactory)
}
