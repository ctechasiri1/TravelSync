//
//  PrivacyPolicyScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/28/26.
//

import SwiftUI

struct PrivacyPolicyScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading) {
                    Spacer()
                    
                    PrivacyPolicySection(title: "introduction_title", content: "introduction_content")
                    
                    PrivacyPolicySection(title: "data_we_collect_title", content: "data_we_collect_content")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        PrivacyPolicyBulletPoint(bulletPointTitle: "data_we_collect_bullet_one_title", bulletPointContent: "data_we_collect_bullet_one_content")
                        
                        PrivacyPolicyBulletPoint(bulletPointTitle: "data_we_collect_bullet_two_title", bulletPointContent: "data_we_collect_bullet_two_content")
                        
                        PrivacyPolicyBulletPoint(bulletPointTitle: "data_we_collect_bullet_three_title", bulletPointContent: "data_we_collect_bullet_three_content")
                        
                        PrivacyPolicyBulletPoint(bulletPointTitle: "data_we_collect_bullet_four_title", bulletPointContent: "data_we_collect_bullet_four_content")
                    }
                    .padding(.bottom, 20)
                    
                    PrivacyPolicySection(title: "how_we_use_your_data_title", content: "how_we_use_your_data_content")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        PrivacyPolicyBulletPoint(bulletPointTitle: "how_we_use_your_data_bullet_one_title", bulletPointContent: "how_we_use_your_data_bullet_one_content")
                        
                        PrivacyPolicyBulletPoint(bulletPointTitle: "how_we_use_your_data_bullet_two_title", bulletPointContent: "how_we_use_your_data_bullet_two_content")
                    }
                    .padding(.bottom, 20)
                    
                    PrivacyPolicySection(title: "data_security_title", content: "data_security_content")
                    
                    PrivacyPolicySection(title: "contact_us_title", content: "contact_us_content")
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundStyle(Color.accentBlue)
                        
                        Text("privacy@travelsync.com")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
        }
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct PrivacyPolicySection: View {
    let title: LocalizedStringKey
    let content: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 10)
            
            Text(content)
                .foregroundStyle(Color.secondaryText)
                .multilineTextAlignment(.leading)
                .font(.system(.subheadline))
        }
        .padding(15)
    }
}

private struct PrivacyPolicyBulletPoint: View {
    let bulletPointTitle: LocalizedStringKey
    let bulletPointContent: LocalizedStringKey
    
    var body: some View {
        HStack(alignment: .top) {
            Text("•")
            
            (
            Text(bulletPointTitle)
            
            +
            
            Text(" ")
            
            +
            
            Text(bulletPointContent)
                .foregroundStyle(Color.secondaryText)
            )
        }
        .font(.system(.subheadline))
        .padding(.horizontal)
    }
}

#Preview {
    PrivacyPolicyScreen()
}
