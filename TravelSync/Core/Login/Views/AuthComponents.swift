//
//  AuthComponents.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/10/26.
//

import SwiftUI

struct AuthDivider: View {
    let text: String
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 0.5)

            Text(text)
                .font(.system(size: 15))
                .frame(width: 120)
                
            Rectangle()
                .frame(height: 0.5)
                
        }
        .foregroundStyle(.secondaryText.opacity(0.6))
    }
}

#Preview {
    AuthDivider(text: "Or continue with")
}

struct SocialLoginButton: View {
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
    SocialLoginButton(iconImage: "google_icon", text: "Google") { }
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
    TextNavigationButton(text: "Login") { }
}

