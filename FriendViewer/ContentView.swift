//
//  ContentView.swift
//  FriendViewer
//
//  Created by Anthony Candelino on 2024-09-07.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @State private var isLoading = false
    @State private var showingOnlineOnly = false
    @State private var sortOrder = [SortDescriptor(\User.name)]
    
    var body: some View {
        NavigationStack {
            if (!isLoading) {
                UserListView(showingOnlineOnly: showingOnlineOnly, sortOrder: sortOrder)
                .navigationTitle("FriendViewer")
                .toolbar {
                    ToolbarItem {
                        Menu("Show", systemImage: "line.3.horizontal.decrease.circle") {
                            Picker("Sort", selection: $showingOnlineOnly) {
                                Text("Show All")
                                    .tag(false)
                                Text("Online Only")
                                    .tag(true)
                            }
                        }
                    }
                }
                .onAppear(perform: loadUsers)
            }
            if (isLoading) {
                ProgressView() {
                    Text("Loading...")
                        .foregroundStyle(.blue)
                }
                .tint(.blue)
            }
            
        }
    }
    
    func loadUsers() {
        guard users.isEmpty else { return }
            
        Task {
            do {
                isLoading = true
                let fetchedUsers = try await fetchUsers()
                for user in fetchedUsers {
                    modelContext.insert(user)
                }
                isLoading = false

            } catch {
                print("Failed to fetch and save users: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                throw URLError(.badURL)
            }
                
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
                
        return try decoder.decode([User].self, from: data)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    return ContentView().modelContainer(container)
}
