//
//  ContentView.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import SwiftUI

// MARK: - Profile View
struct ProfileView: View {

    @State private var isEditable = false
    @State private var name = "Aaron N. Kaiser"
    @State private var userName = ""
    @State private var email = "aaron.n.kaiser@email.com"
    @State private var phone = "aaron.n.kaiser@email.com"
    @State private var address = "70 Washington Square South, New York, NY 10012, US"

    @AppStorage("username") private var storedUsername: String = ""
    @AppStorage("keepMeLoggedIn") private var keepMeLoggedIn: Bool = false
    @AppStorage("name") private var storedName: String = "Aaron N. Kaiser"
    @AppStorage("email") private var emailAddress: String = "aaron.n.kaiser@email.com"
    @AppStorage("phone") private var storedPhone: String = "aaron.n.kaiser@email.com"
    @AppStorage("address") private var storedAddress: String = "70 Washington Square South, New York, NY 10012, US"

    var body: some View {
        NavigationView {
            ZStack {
                Color("gray")
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        Circle()
                            .fill(Color("lightOrange"))
                            .frame(width: 72, height: 72)
                            .overlay(Text("NA").foregroundColor(.white).bold())
                        
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Name", text: $name)
                                    .disabled(!isEditable)
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                                
                                Button {
                                    saveData()
                                    isEditable.toggle()
                                } label: {
                                    Image(systemName: "pencil")
                                }
                                .padding()
                            }
                            
                            TextField("Username", text: $userName)
                                .foregroundColor(.gray)
                                .disabled(!isEditable)
                                .padding(.top, 4)
                        }
                    }

                    EditableView(label: "Email", text: $email, isEditing: isEditable)
                    EditableView(label: "Mobile", text: $phone, isEditing: isEditable)
                    EditableView(label: "Address", text: $address, isEditing: isEditable)

                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Image("profile")
                            .resizable()
                            .cornerRadius(12)

                        Text("The OAKS")
                            .font(.headline)
                        Text("Scarlet 35 Frontage")
                            .font(.title3)
                            .bold()
                    }
                    
                    // Icon rows in two columns
                    HStack(alignment: .top, spacing: 40) {
                        VStack(alignment: .leading, spacing: 24) {
                            PropertyItem(icon: "square.and.pencil", label: "2,397 Sq Ft")
                            PropertyItem(icon: "bathtub.fill", label: "3.5 Bath")
                            PropertyItem(icon: "house.fill", label: "2 Story")
                        }
                        
                        VStack(alignment: .leading, spacing: 24) {
                            PropertyItem(icon: "bed.double.fill", label: "4 Beds")
                            PropertyItem(icon: "caravan.fill", label: "2 Car Garage")
                        }
                    }
                    
                    // Logout Button
                    Button(action: {
                        keepMeLoggedIn = false
                        userName = ""
                        KeychainHelper.delete(key: "userPassword")
                    }) {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.indigo.opacity(0.3))
                            .cornerRadius(20)
                    }
                }
                .padding()

            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Left image
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("nav_logo")
                        .resizable()
                        .frame(width: 80, height: 40)
                        .padding(.trailing, 8)
                }
            }
        }
        .onAppear {
            userName = storedUsername
            phone = storedPhone
            email = emailAddress
            address = storedAddress
            name = storedName
            print("Password: \(KeychainHelper.read(key: "userPassword") ?? "")")
        }
    }
    
    func saveData() {
        storedUsername = userName
        storedPhone = phone
        emailAddress = email
        storedAddress = address
        storedName = name
    }
}


struct EditableView: View {
    let label: String
    @Binding var text: String
    var isEditing: Bool

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .foregroundColor(.gray)
                .frame(width: 80, alignment: .leading)
            if isEditing {
                TextField(label, text: $text)
            } else {
                Text(text)
            }
        }
    }
}


struct PropertyItem: View {
    let icon: String
    let label: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.black)
            Text(label)
                .foregroundColor(.black)
        }
    }
}
