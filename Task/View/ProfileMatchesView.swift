//
//  ProfileMatchesView.swift
//  Task
//
//  Created by Sahitya on 11/08/24.
//

import SwiftUI

struct ProfileMatchesView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                let profiles = viewModel.profiles ?? []
                ForEach(profiles.indices, id: \.self) { index in
                    ProfileCardView(viewModel: viewModel, profile: profiles[index], index: index)
                }
            }
            .refreshable {
                viewModel.fetchProfilesFromAPI()
            }
            .navigationTitle("Profile Matches")
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchProfilesFromAPI()
            }
        }
    }
}

#Preview {
    ProfileMatchesView()
}

