//
//  ProfileScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/1/26.
//

import SwiftUI

struct ProfileScreen: View {
    
    @State private var isShowingSettings: Bool = false
    @State private var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    ProfileImage()
                    
                    VStack {
                        Text("Sarah Jenkins")
                            .font(.system(.title3, weight: .bold))
                        
                        Text("@sarhj_travels")
                            .foregroundStyle(Color.textColor.secondaryText)
                            .font(.system(.subheadline, weight: .regular))
                    }
                    
                    ProfileInformation()
                    
                    TravelBadges()
                    
                    FuturePlansOptions()
                    
                    LogOutButton()
                }
            }
            .setScrollViewBackground()
            .toolbar(content: {
                CircleButton(imageName: "pencil", action: {})
                CircleButton(imageName: "gear", action: {
                    isShowingSettings = true
                } )
            })
            .navigationDestination(isPresented: $isShowingSettings, destination: {
                SettingsScreen()
            })
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct ProfileImage: View {
    var body: some View {
        Circle()
            .strokeBorder(LinearGradient(colors: [Color.accentBlue, Color.accentConfirmation], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 5)
            .frame(width: 100, height: 100)
            .foregroundStyle(Color.backgroundColor.tertiaryBackground)
        
            .overlay {
                Image(systemName: "camera.fill")
                    .foregroundStyle(Color.white)
                    .background(
                        Circle()
                            .fill(Color.accentBlue)
                            .strokeBorder(Color.white, lineWidth: 2)
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.accentBlue)
                    )
                    .frame(width: 30, height: 30)
                    .offset(x: 30, y: 40)
            }
    }
}

private struct ProfileInformation: View {
    var body: some View {
        HStack(spacing: 40) {
            VStack {
                Text("24")
                Text("Posts")
            }
            
            Divider()
            
            VStack {
                Text("24")
                Text("Posts")
            }
            
            Divider()
            
            VStack {
                Text("24")
                Text("Posts")
            }
            
        }
    }
}

private struct TravelBadges: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "medal.fill")
                    .foregroundStyle(Color.accentBlue)
                
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
                            CircleIcon(iconName: "airplane", iconColor: Color.accentBlue, width: 50, height: 50)
                            
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
}
