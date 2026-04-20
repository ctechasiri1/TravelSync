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
    
    @State private var viewModel: UserSessionViewModel
    
    init(viewModel: UserSessionViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Profile")
                        .font(.system(.largeTitle, weight: .bold))
                        .padding()
                            
                    Spacer()
                }
                
                ScrollView {
                    VStack(spacing: 30) {
                        VStack {
                            ProfileImage(
                                imageURL: viewModel.currentUser.profileImage,
                                selectedImage: viewModel.selectedProfileImage,
                            )
                            .frame(width: 80, height: 80)
                            
                            Text("Hi, \(viewModel.currentUser.firstName)!")
                                .font(.system(.title, weight: .semibold))
                            
                            Text(
                                "@\(viewModel.currentUser.username.lowercased())"
                            )
                            .font(.system(.subheadline))
                            
                            StatisticsSection(trips: 10)
                                .padding()
                        }
                        .foregroundStyle(.primaryText)
                        .font(.system(.subheadline, weight: .regular))
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Group {
                        FuturePlansOptions()
                        
                        PreferencesOptions(viewModel: viewModel)
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
            .setScrollViewBackground()
            .task {
                await viewModel.getUser()
            }
            .navigationDestination(isPresented: $isShowingSettings, destination: {
                SettingsScreen(user: viewModel.currentUser, viewModel: viewModel)
            })
            .navigationDestination(isPresented: $isShowingPersonalInfo, destination: {
                PersonalInfoScreen(user: viewModel.currentUser, viewModel: viewModel)
            })
        }
    }
}

private struct StatisticsSection: View {
    let trips: Int
    
    var body: some View {
        HStack {
            Group {
                VStack {
                    Text("\(trips)")
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

private struct FuturePlansOptions: View {
    var body: some View {
        VStack(spacing: 15) {
            NavigationLink {

            } label: {
                HStack {
                    SquareIcon(
                        iconName: "gear",
                        iconColor: .gray,
                        width: 50,
                        height: 50
                    )
                    .padding()
                
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Settings")
                            .font(.system(size: 17, weight: .semibold))
                        
                        Text("Customize your account")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondaryText)
                        
                    }
                    .foregroundColor(.primaryText)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .padding()
                .createCardBackgroud()
            }
            
            HStack(spacing: 15) {
                SquareCard(title: "My Map", value: "Tracked journeys", iconName: "map.fill", iconColor: .purple, arrowColor: .purple) {
                    
                }
                
                SquareCard(title: "Favorite Places", value: "28 Contributions", iconName: "star.fill", iconColor: .red, arrowColor: .red) {
                    
                }
            }
        }
    }
}

#Preview {
    ProfileScreen(viewModel: UserSessionViewModel(userService: UserService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
