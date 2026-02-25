//
//  PersonalInfoScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct PersonalInfoScreen: View {
    @State private var viewModel: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ProfileImage()
                    .padding(.vertical, 50)
                
                VStack(spacing: 15) {
                    EditCard(field: $viewModel.fullName, cardName: "FULL NAME")
                    
                    EditCard(field: $viewModel.emailAddress, cardName: "EMAIL")
                    
                    EditCard(field: $viewModel.phoneNumber, cardName: "PHONE NUMBER")
                    
                    EditCard(field: $viewModel.location, cardName: "LOCATION")
                }

                PersonalInfoButtonOptions()
                    .padding()
            }
            .setScrollViewBackground()
            .toolbarVisibility(.hidden, for: .bottomBar)
            .navigationTitle("Personal Information")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct EditCard: View {
    @Binding var field: String
    let cardName: String
    
    var body: some View {
        VStack {
            Text(cardName)
                .sectionTitleStyle()
            
            HStack {
                Text("Name")
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "pencil")
                }
            }
            .padding([.horizontal, .bottom], 10)
            .padding(.top, 5)
            .padding(.horizontal, 15)
        }
        .padding(.vertical)
        .createCardBackgroud()
    }
}

private struct PersonalInfoButtonOptions: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .padding()
                    .foregroundStyle(Color.secondaryText)
                    .frame(maxWidth: .infinity)
                    .background(Color.secondaryBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                Color.secondaryText.opacity(0.2)
                            )
                    )
            }
            
            Button {
                
            } label: {
                Text("Save Changes")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .background(
                        LinearGradient(
                            colors: [Color.orange, Color.pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
            }
        }
    }
}

#Preview {
    PersonalInfoScreen()
}
