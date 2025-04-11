//
//  MainTabView.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import SwiftUI

// MARK: - Main Tab View
struct MainTabView: View {
    var body: some View {
        TabView {
            ChatView()
                .tabItem {
                    Label("AI Chat", systemImage: "message")
                }
            DocumentUploadView()
                .tabItem {
                    Label("My Manuals", systemImage: "doc")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
