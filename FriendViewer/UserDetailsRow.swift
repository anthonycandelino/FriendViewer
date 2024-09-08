//
//  UserDetailsRow.swift
//  FriendViewer
//
//  Created by Anthony Candelino on 2024-09-08.
//

import SwiftUI

struct UserDetailsRow: View {
    var icon: String
    var iconColor: Color = .blue
    var label: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
            Text(label)
                .padding(.leading)
        }
    }
}

#Preview {
    UserDetailsRow(icon: "info.circle", iconColor: .red, label: "Information")
}
