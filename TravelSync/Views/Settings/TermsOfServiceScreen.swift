//
//  TermsOfServiceScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/25/26.
//

import SwiftUI

struct TermsOfServiceScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                TermsOfServiceSection(title: "acceptance_of_terms_title", content: "acceptance_of_terms_content")
                
                TermsOfServiceSection(title: "user_accounts_title", content: "user_accounts_content")
                
                TermsOfServiceSection(title: "content_title", content: "content_content")
                
                TermsOfServiceSection(title: "intellectual_property_title", content: "intellectual_property_content")
                
                TermsOfServiceSection(title: "termination_title", content: "termination_content")
                
                TermsOfServiceSection(title: "changes_title", content: "changes_content")
                
                Divider()
                
                Text("questions_content")
                    .foregroundStyle(Color.secondaryText)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationTitle("Terms of Service")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct TermsOfServiceSection: View {
    let title: LocalizedStringKey
    let content: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 10)
            
            Text(content)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.secondaryText)
                .font(.system(.subheadline))
        }
        .padding(12)
    }
}

#Preview {
    TermsOfServiceScreen()
}
