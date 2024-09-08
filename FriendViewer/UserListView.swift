//
//  UserListView.swift
//  FriendViewer
//
//  Created by Anthony Candelino on 2024-09-08.
//

import SwiftData
import SwiftUI

struct UserListView: View {
    @Environment(\.modelContext) var modelContext
    var showingOnlineOnly: Bool
    @Query var allUsers: [User]
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            NavigationLink(destination: UserDetails(user: user, allUsers: allUsers)) {
                HStack {
                    Image(systemName: user.isActive ? "wifi" : "wifi.slash")
                        .foregroundColor(user.isActive ? .blue : .gray)
                    Text(user.name)
                        .font(.title3)
                        .padding(.leading, 5)
                        .padding(.vertical, 8)
                }
            }
        }
    }
    
    init(showingOnlineOnly: Bool, sortOrder: [SortDescriptor<User>]) {
        self.showingOnlineOnly = showingOnlineOnly
        _users = Query(filter: #Predicate<User> { user in
            showingOnlineOnly == false || user.isActive == showingOnlineOnly 
        }, sort: sortOrder)
    }

}

