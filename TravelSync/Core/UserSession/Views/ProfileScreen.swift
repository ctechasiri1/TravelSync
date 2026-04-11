//
//  ProfileScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/1/26.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(AppState.self) private var appState
    @State var profileUIImage: UIImage? = nil
    @State private var isShowingSettings: Bool = false
    @State private var isShowingPersonalInfo: Bool = false
    
    var body: some View {
        let userSessionViewModel = appState.userSession
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    VStack {
                        ProfileImage(profileUIImage: $profileUIImage, canEditPhoto: false)
                            .frame(width: 80, height: 80)
                            .padding()
                        
                        Text("Hi, \(userSessionViewModel.currentUser.firstName)!")
                            .font(.system(.title, weight: .semibold))
                            
                        Text(
                            "@\(userSessionViewModel.currentUser.username.lowercased())"
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
                    
                    PreferencesOptions(viewModel: userSessionViewModel)
                        .padding(.vertical, 25)
                        
                    AuthButton(
                        text: "Log Out",
                        foregroundColor: .accentPrimary,
                        backgroundColor: .white) {
                                
                        }
                        .padding(.vertical)
                }
                .padding(.horizontal)
                
                    
                Spacer()
            }
        }
        .task {
            await userSessionViewModel.getUser()
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
            SettingsScreen(user: userSessionViewModel.currentUser)
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
                    Text("42")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primaryText)
                    
                    Text("TRIPS")
                }
                
                VStack {
                    Text("18")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primaryText)
                    
                    Text("COUNTRIES")
                }
                
                VStack {
                    Text("1.2k")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primaryText)
                    
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
            Text("TRAVEL BADGES")
                .sectionTitleStyle()
                .padding(.leading)
                .padding(.top, 25)
    
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<6) { _ in
                        VStack(spacing: 25) {
                            SquareIcon(iconName: "airplane", iconColor: .accentBlue, width: 80, height: 60)
                            
                            Text("Frequent Flyer")
                                .font(.system(size: 12))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100, height: 140)
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
        VStack(spacing: 20) {
            NavigationLink {
                
            } label: {
                HStack {
                    SquareIcon(
                        iconName: "heart.fill",
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
            
            HStack(spacing: 25) {
                SquareCard(title: "My Map", value: "Tracked journeys", iconName: "map.fill", iconColor: .purple, arrowColor: .purple) {
                    
                }
                
                SquareCard(title: "Reviews", value: "28 Contributions", iconName: "star.fill", iconColor: .red, arrowColor: .red) {
                    
                }
            }
        }
    }
}



#Preview {
    ProfileScreen()
        .environment(AppState())
}
