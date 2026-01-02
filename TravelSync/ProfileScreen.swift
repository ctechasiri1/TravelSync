//
//  ProfileScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/1/26.
//

import SwiftUI

struct ProfileScreen: View {
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
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.backgroundColor.primaryBackground)
            .toolbar(content: {
                CircleButton(imageName: "pencil", action: {})
                CircleButton(imageName: "gear", action: {} )
            })
            .navigationTitle("Profile")
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
                HStack(spacing: 20) {
                    ForEach(0..<6) { _ in
                        VStack(spacing: 25) {
                            CircleIcon(iconName: "airplane")
                            
                            Text("Frequent Flyer")
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100, height: 150)
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.backgroundColor.secondaryBackground)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5)
        .padding()

    }
}

#Preview {
    ProfileScreen()
}
