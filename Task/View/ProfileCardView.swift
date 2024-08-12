//
//  ProfileCardView.swift
//  Task
//
//  Created by Sahitya on 11/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCardView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var hasShownAlert = false
    @State private var showAlert = false
    let profile: ProfileEntry
    let index: Int
    
    var body: some View {
        NavigationLink(destination: ProfileDetailView(profile: profile)) {
            VStack(alignment: .center) {
                WebImage(url: URL(string: profile.imageName ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding(.top, 12)
                } placeholder: {
                    Image("thumbnail")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                }
                
                let fullName = profile.name ?? ""
                Text(fullName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 5)
                    .foregroundStyle(Color.themeColor)
                Text(profile.location ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.top, 0)
                
                
                if let status = ProfileStatus(from: profile.status ?? "") {
                    BottomStatusView(profileStatus: status)
                } else {
                    AcceptRejectView(index: index,
                                     onSelect: { index in
                        print("selected\(index)")
                        withAnimation(.bouncy) {
                            toastMessage = "Profile Accepted!"
                            showToast = true
                            viewModel.updateProfileStatus(profile: profile, status: "accepted")
                        }
                    }, onReject: { index in
                        print("rejected\(index)")
                        withAnimation(.easeInOut) {
                            toastMessage = "Profile Rejected!"
                            showToast = true
                            viewModel.updateProfileStatus(profile: profile, status: "rejected")
                        }
                    })
                }
            }
            .background(Color("backgroundwhite"))
            .cornerRadius(10)
            .shadow(radius: 5)
            .toast(message: toastMessage, isShowing: $showToast)
        }
    }
}
