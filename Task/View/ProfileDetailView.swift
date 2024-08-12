//
//  ProfileDetailView.swift
//  Task
//
//  Created by Sahitya on 12/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileDetailView: View {
    let profile: ProfileEntry

    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 12) {
                // Display full profile information here
                WebImage(url: URL(string: profile.imageName ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding()
                } placeholder: {
                    Image("thumbnail")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                }
                Text(profile.name ?? "Unknown Name")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Text(profile.location ?? "Unknown Location")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                if let status = profile.status {
                    let statusStr = ProfileStatus(from: status)?.string ?? ""
                    Text(statusStr)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(statusStr == "Accepted" ? .green : .red)
                }
            }
        }
        .navigationTitle("Profile Details")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
        .background(Color("backgroundwhite"))
    }
}

#Preview {
    ProfileDetailView(profile: ProfileEntry())
}
