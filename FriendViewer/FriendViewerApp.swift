//
//  FriendViewerApp.swift
//  FriendViewer
//
//  Created by Anthony Candelino on 2024-09-07.
//

import SwiftData
import SwiftUI

@main
struct FriendViewerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
