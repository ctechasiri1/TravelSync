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
                VStack(spacing: 30) {
                    VStack {
                        ProfileImage(canEditPhoto: false)
                            .frame(width: 80, height: 80)
                            .padding()
                        
                        Text("Hi, \(profileViewModel.currentUser.firstName)!")
                            .font(.system(.title, weight: .semibold))
                            
                        Text(
                            "@\(profileViewModel.currentUser.username.lowercased())"
                        )
                        .font(.system(.subheadline))
                        
                        StatisticsSection()
                            .padding()
                    }
                    .foregroundStyle(.primaryText)
                    .font(.system(.subheadline, weight: .regular))
                        
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .center)
                    
                TravelBadges()
                
                Group {
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
        .toolbar {
            ToolbarButton(
                imageName: "pencil",
                foregroundColor: .accentPrimary,
                backgroundColor: .white) {
                    isShowingPersonalInfo = true
                }
            
            ToolbarButton(
                imageName: "gear",
                foregroundColor: .accentPrimary,
                backgroundColor: .white
            ) {
                isShowingSettings = true
            }
        }
        .navigationDestination(isPresented: $isShowingSettings, destination: {
            SettingsScreen(user: profileViewModel.currentUser)
        })
        .navigationDestination(isPresented: $isShowingPersonalInfo, destination: {
            PersonalInfoScreen()
        })
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
            
    }
}

private struct StatisticsSection: View {
    var body: some View {
        HStack {
            Group {
                VStack {
                    Text("TRIPS")
                }
                
                VStack {
                    Text("COUNTRIES")
                }
                
                VStack {
                    Text("PHOTOS")
                }
            }
            .frame(maxWidth: .infinity)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(.secondaryText)
        }
        .padding()
        .createCardBackgroud()
    }
}

private struct TravelBadges: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "medal.fill")
                    .foregroundStyle(.accentPrimary)
                
                Text("Travel Badges")
                    .font(.system(.subheadline, weight: .bold))
                    .foregroundStyle(.secondaryText)
            }
            .padding(.top, 25)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<6) { _ in
                        VStack(spacing: 25) {
                            CircleIcon(iconName: "airplane", iconColor: .accentBlue, width: 50, height: 50)
                            
                            Text("Frequent Flyer")
                                .font(.system(size: 12))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100, height: 150)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .mask {
                HStack(spacing: 0) {
                   LinearGradient(gradient:
                      Gradient(
                          colors: [Color.black.opacity(0), Color.black]),
                          startPoint: .leading, endPoint: .trailing
                      )
                      .frame(width: 50)

                   Rectangle().fill(Color.black)

                   LinearGradient(gradient:
                      Gradient(
                          colors: [Color.black, Color.black.opacity(0)]),
                          startPoint: .leading, endPoint: .trailing
                      )
                      .frame(width: 50)
                   }
            }
            
        }
    }
}

private struct FuturePlansOptions: View {
    var body: some View {
        VStack {
            NavigationLink {
                
            } label: {
                HStack {
                    SquareIcon(
                        iconName: "heart",
                        iconColor: .pink,
                        width: 40,
                        height: 40
                    )
                    .padding()
                
                    VStack(alignment: .leading) {
                        Text("Favorite Places")
                            .font(.system(size: 17, weight: .semibold))
                        
                        Text("12 saved locations")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.primaryText)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .padding()
                .createCardBackgroud()
            }

        }
        HStack {
            SquareCard(title: "My Map", value: "Tracked journeys", iconName: "map", iconColor: .purple, arrowColor: .purple) {
                
            }
            
            SquareCard(title: "Reviews", value: "28 Contributions", iconName: "star", iconColor: .red, arrowColor: .red) {
                
            }
        }

    }
}



#Preview {
    ProfileScreen()
        .environment(AppState())
}
