//
//  BottomStatusView.swift
//  Task
//
//  Created by Sahitya on 12/08/24.
//

import SwiftUI

struct BottomStatusView: View {
    var profileStatus: ProfileStatus = .rejected
    var body: some View {
        ZStack {
            Color.themeColor
            Text(profileStatus.string)
                .foregroundStyle(Color.white)
        }
        .frame(height: 60)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    BottomStatusView()
}
