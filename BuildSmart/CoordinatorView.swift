//
//  CoordinatorView.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .login)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {

        }
    }
}

struct CustomNavigationHeader: View {
    var body: some View {
        HStack {
            Image("nav_logo")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 8)
            Spacer()
        }
        .padding()
    }
}

