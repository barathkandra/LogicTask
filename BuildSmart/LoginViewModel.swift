//
//  LoginViewModel.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""

    private var cancellables = Set<AnyCancellable>()

    func validateAndLogin() -> Bool {
        if username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Username can't be empty"
        } else if !isPasswordValid(password) {
            errorMessage = "Password must be at least 8 characters, include uppercase, lowercase, and a number"
        } else {
            errorMessage = ""
            return true
        }
        return false
    }

    private func isPasswordValid(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
}
