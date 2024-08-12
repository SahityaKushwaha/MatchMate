//
//  AcceptRejectView.swift
//  Task
//
//  Created by Sahitya on 12/08/24.
//

import SwiftUI

struct AcceptRejectView: View {
    let index: Int
    let onSelect: ((Int) -> Void)?
    let onReject: ((Int) -> Void)?
    
    var body: some View {
        HStack {
            Button(action: {
                // Handle the reject action
                print("reject clicked")
                onReject?(index)
            }) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .font(.largeTitle)
                    .foregroundColor(Color(hex: "#D3D3D3"))
            }
            .frame(width: 60, height: 60)
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Button(action: {
                // Handle the accept action
                print("select clicked")
                onSelect?(index)
            }) {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .font(.largeTitle)
                    .foregroundColor(Color.themeColor)
            }
            .frame(width: 60, height: 60)
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 50)
        .padding([.bottom, .top], 10)
    }
}

#Preview {
    AcceptRejectView(index: 0, onSelect: nil, onReject: nil)
        .previewLayout(.sizeThatFits)
        .padding()
}
