//
//  ContentView.swift
//  FriendViewer
//
//  Created by Anthony Candelino on 2024-09-07.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(destination:  UserDetails(user: user)) {
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
            .navigationTitle("FriendViewer")
            .onAppear(perform: loadUsers)
        }
    }
    
    func loadUsers() {
        guard users.isEmpty else { return }
            
        Task {
            do {
                guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                        throw URLError(.badURL)
                    }
                        
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                        
                users = try decoder.decode([User].self, from: data)

            } catch {
                print("Error retrieving users")
            }
        }
    }
}

#Preview {
    ContentView()
}
