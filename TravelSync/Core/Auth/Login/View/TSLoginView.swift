//
//  TSLoginView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct TSLoginView: View {
    @Environment(TSAppState.self) private var appState
    @State private var viewModel: TSLoginViewModel
    
    init(viewModel: TSLoginViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
            
            GroupCard {
                VStack(alignment: .leading, spacing: 20) {
                    LoginTitleSection()
                    
                    TSInputTextField(
                        inputText: $viewModel.username,
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
                    
                    TSTextButton(title: "Forgot Password?", fontStyle: .footnote) {
                        // TODO: Insert the forgot password feature
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    TSFillButton(title: "Login", isLoading: appState.isLoading) {
                        viewModel.login()
                    }
                    
                    Spacer()
                    
                    PromptSignUpSection {
                        appState.navigate(to: .signUp)
                    }
                }
                .padding()
            }
            .padding()
        }
        .onChange(of: viewModel.didLoginSucceed) { _, succeeded in
            withAnimation {
                if succeeded {
                    appState.navigate(to: .home)
                }
            }
        }
    }
}

private struct LoginTitleSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: TSSystemImageName.safari)
                .bold()
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.accentPrimary)
                        .frame(width: 50, height: 50)
                )
                .padding()
                .padding(.top, 20)
            
            Text(L10n.TSLoginView.title1)
                .font(.system(.title, weight: .semibold))
            
            Text(L10n.TSLoginView.title2)
                .font(.system(.title, weight: .semibold))
                .foregroundStyle(.accentPrimary)
            
            Text(L10n.TSLoginView.subtitle)
                .font(.system(.subheadline))
                .foregroundStyle(.secondaryText.opacity(0.6))
        }
    }
}

private struct PromptSignUpSection: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(L10n.TSLoginView.signUpDescription)
                .foregroundStyle(.secondaryText.opacity(0.6))
                    
            TSTextButton(title: L10n.TSLoginView.signUp) {
                action()
            }
        }
        .padding()
        .font(.system(.subheadline))
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview("TSLoginView") {
    let appState: TSAppState = TSAppState()
    let viewModelFactory: TSViewModelFactory = TSViewModelFactory(appState: appState)
    
    TSLoginView(viewModel: viewModelFactory.makeLoginViewModel())
        .environment(appState)
        .environment(viewModelFactory)
}
