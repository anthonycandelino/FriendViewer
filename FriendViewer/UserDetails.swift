//
//  UserDetails.swift
//  FriendViewer
//
//  Created by Anthony Candelino on 2024-09-08.
//

import SwiftData
import SwiftUI

struct UserDetails: View {
    var user: User
    var allUsers: [User]
    
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
                                .padding(10)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .clipShape(Capsule())
                            }
                        }
                    }
                }
                
                Section(header: Text("Friends")) {
                    ForEach(user.friends) { friend in
                        if let friendUser = getFriendUser(allUsers: allUsers, friendId: friend.id) {
                            NavigationLink(destination: UserDetails(user: friendUser, allUsers: allUsers)) {
                                HStack {
                                    Image(systemName: "person.circle")
                                    Text(friendUser.name)
                                        .font(.title3)
                                        .padding(.leading, 5)
                                        .padding(.vertical, 8)
                                }
                                .foregroundColor(.blue)
                            }
                        } else {
                            HStack {
                                Image(systemName: "person.circle")
                                Text(friend.name)
                                    .font(.title3)
                                    .padding(.leading, 5)
                                    .padding(.vertical, 8)
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
    
    func getFriendUser(allUsers: [User], friendId: UUID) -> User? {
        allUsers.first(where: {$0.id == friendId})
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    return UserDetails(
        user: User(
            id: UUID(),
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
            friends: []
        ),
        allUsers: []
    ).modelContainer(container)
}
