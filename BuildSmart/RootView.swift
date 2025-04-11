//
//  RootView.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import SwiftUI

struct RootView: View {
    @State private var isLoggedIn = false
    @AppStorage("keepMeLoggedIn") private var keepMeLoggedIn: Bool = false
    var body: some View {
        if keepMeLoggedIn || isLoggedIn {
            MainTabView()
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}


#Preview {
    RootView()
}
