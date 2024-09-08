//
//  UserDetails.swift
//  FriendViewer
//
//  Created by Anthony Candelino on 2024-09-08.
//

import SwiftUI

struct UserDetails: View {
    var user: User
    
    var body: some View {
        VStack {
            List {
                Section("Status") {
                    UserDetailsRow(
                        icon: user.isActive ? "wifi" : "wifi.slash",
                        iconColor: user.isActive ? .blue : .gray,
                        label: user.isActive ? "Online" : "Offline"
                    )
                }
                Section("User Details") {
                    UserDetailsRow(icon: "birthday.cake", label: "Age: \(user.age)")
                    UserDetailsRow(icon: "briefcase", label: "Company: \(user.company)")
                    UserDetailsRow(icon: "envelope", label: "Email: \(user.email)")
                    UserDetailsRow(icon: "house", label: "Address: \(user.address)")
                    UserDetailsRow(icon: "info.bubble", label: "About: \(user.about)")
                    UserDetailsRow(icon: "calendar.badge.clock", label: "Joined \(getJoinDate(date: user.registered))")
                }
                
                Section(header: Text("Tags")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(user.tags, id: \.self) { tag in
                                HStack {
                                    Image(systemName: "number")
                                    Text(tag)
                                }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                
                Section(header: Text("Friends")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(user.friends) { friend in
                                HStack {
                                    Image(systemName: "person.circle")
                                    Text(friend.name)
                                }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                
            }
            .navigationTitle(user.name)
        }
    }
    
    func getJoinDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationView {
        UserDetails(
            user: User(
                id: "123",
                isActive: true,
                name: "John Smith",
                age: 23,
                company: "Workplace",
                email: "johnsmith@gmail.com",
                address: "123 Main St",
                about: "Loves programming and the outdoors",
                registered: .now,
                tags: [
                    "Fisherman",
                    "Programmer",
                    "Hiker"
                ],
                friends: [Friend(
                    id: "12345",
                    name: "Joey Apple"
                )]
            )
        )
    }
}
