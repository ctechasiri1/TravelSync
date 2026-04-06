//
//  ProfileScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/1/26.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(AppState.self) private var appState
    @State private var isShowingSettings: Bool = false
    @State private var isShowingPersonalInfo: Bool = false
    
    var body: some View {
        let profileViewModel = appState.profile
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        ProfileImage(canEditPhoto: false)
                            .frame(width: 60, height: 60)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Group {
                                if let name = profileViewModel.currentUser?.firstName {
                                    Text("Hi, \(name)!")
                                } else {
                                    Text("N/A")
                                }
                            }
                            .font(.system(.title, weight: .semibold))
                            
                            Group {
                                if let name = profileViewModel.currentUser?.username {
                                    Text("@\(name.lowercased())")
                                        .font(.system(.subheadline))
                                } else {
                                    Text("N/A")
                                }
                            }
                            .foregroundStyle(Color.textColor.secondaryText)
                            .font(.system(.subheadline, weight: .regular))
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Group {
                        TravelBadges()
                        
                        FuturePlansOptions()
                        
                        AuthButton(
                            text: "Log Out",
                            foregroundColor: .accentPrimary,
                            backgroundColor: .white) {
                                
                            }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .task {
                await profileViewModel.getUser()
            }
            .setScrollViewBackground()
            .toolbar(content: {
                ToolbarButton(imageName: "pencil", foregroundColor: .accentPrimary, backgroundColor: .white) {
                    isShowingPersonalInfo = true
                }
                ToolbarButton(imageName: "gear", foregroundColor: .accentPrimary, backgroundColor: .white) {
                    isShowingSettings = true
                }
            })
            .navigationDestination(isPresented: $isShowingSettings, destination: {
                SettingsScreen()
            })
            .navigationDestination(isPresented: $isShowingPersonalInfo, destination: {
                PersonalInfoScreen()
            })
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

private struct TravelBadges: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "medal.fill")
                    .foregroundStyle(.accentBlue)
                
                Text("Travel Badges")
                    .font(.system(.headline, weight: .bold))
            }
            .padding(.leading, 40)
            .padding(.top, 25)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<6) { _ in
                        VStack(spacing: 25) {
                            CircleIcon(iconName: "airplane", iconColor: .accentBlue, width: 50, height: 50)
                            
                            Text("Frequent Flyer")
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100, height: 150)
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
        .createCardBackgroud()
        .padding(.top)
    }
}

private struct FuturePlansOptions: View {
    var body: some View {
        OptionsCard(title: "") {
            NavigationOptionRow(title: "Favorite Places", iconName: "heart.fill", iconColor: Color.accentBlue, destination: EmptyView(), useCircleIcon: true)
                .padding(.top, 15)
                .padding(.bottom, 7)
            
            Divider()
            
            NavigationOptionRow(title: "My Map", iconName: "map.fill", iconColor: Color.accentConfirmation, destination: EmptyView(), useCircleIcon: true)
                .padding(.vertical, 5)
            
            Divider()
            
            NavigationOptionRow(title: "Reviews", iconName: "star.bubble.fill", iconColor: Color.green, destination: EmptyView(), useCircleIcon: true)
                .padding(.top, 7)
                .padding(.bottom, 15)
        }
    }
}

#Preview {
    ProfileScreen()
        .environment(AppState())
}
