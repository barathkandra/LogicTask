//
//  Coordinator.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import Foundation
import SwiftUI


class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()

    func push(page: AppPages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .login: RootView()
        case .mainTab: MainTabView()
        }
    }
}
