//
//  LoginView.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var isSecure: Bool = true
    @StateObject private var viewModel = LoginViewModel()

    @State private var isKeepMeLoggedIn: Bool = false

    @Binding var isLoggedIn: Bool
    
    @AppStorage("username") private var storedUsername: String = ""
    @AppStorage("keepMeLoggedIn") private var keepMeLoggedIn: Bool = false

    var body: some View {
        NavigationView {
//            ScrollView(showsIndicators: false) {
                VStack {
                    HStack(spacing: 12) {
                        Image("logo")
                            .resizable()
                            .frame(width: 200, height: 150)
                        Spacer()
                    }
                    .padding(.bottom, 20)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Log In")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)

                        Text("Enter your existing username and password to login")
                            .font(.subheadline)
                            .padding(.bottom, 5)
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Username")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        TextField("Enter name", text: $viewModel.username)
                            .padding()
                            .background(.white)
                            .frame(height: 40)
                            .overlay(
                                   RoundedRectangle(cornerRadius: 5)
                                       .stroke(Color.gray, lineWidth: 1)
                               )
                            .cornerRadius(5)
                            .padding(.bottom, 10)

                        Text("Password")
                            .font(.headline)
                        
                        HStack {
                            if isSecure {
                                SecureField("Enter password", text: $viewModel.password)
                            } else {
                                TextField("Enter password", text: $viewModel.password)
                            }
                            Button(action: {
                                isSecure.toggle()
                            }) {
                                Image(systemName: isSecure ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(.white)
                        .frame(height: 40)
                        .overlay(
                               RoundedRectangle(cornerRadius: 5)
                                   .stroke(Color.gray, lineWidth: 1)
                           )
                        .cornerRadius(5)
                        .padding(.bottom, 10)
                    }
                    .padding()
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }

                    Button(action: {
                        if viewModel.validateAndLogin() {
                            storedUsername = viewModel.username
                            keepMeLoggedIn = isKeepMeLoggedIn
                            isLoggedIn = true
                            KeychainHelper.save(key: "userPassword", value: viewModel.password)
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("navyBlue"))
                            .cornerRadius(10)
                            .padding(.horizontal, 6)
                    }
                    .padding()

                    HStack(spacing: 12) {
                        Toggle(isOn: $isKeepMeLoggedIn) {
                            Text("Keep me logged in")
                                .foregroundColor(.black)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        Spacer()
                        
                        Button(action: {
                            print("Tapped Forgot Button action requires")
                        }) {
                            Text("Forgot Password?")
                                .foregroundColor(.black)
                                .underline()
                        }
                        .padding(.bottom, 10)
                    }
                    .padding()
                    
                    HStack(spacing: 12) {
                        
                        CommonButton {
                            print("Tapped contact button action requires")
                        } content: {
                            Text("Contact")
                        }
                        
                        Spacer()

                        CommonButton {
                            print("Tapped privacy button action requires")
                        } content: {
                            Text("Privacy Policy")
                        }

                        CommonButton {
                            print("Tapped about button action requires")
                        } content: {
                            Text("About")
                        }
                    }
                    .padding()
//                }
            }
            .navigationBarHidden(true)
        }
    }
    
}

struct CommonButton<Content: View>: View {
    let action: () -> Void
    let content: () -> Content

    var body: some View {
        Button(action: action) {
            content()
                .padding()
                .foregroundColor(.black)
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
