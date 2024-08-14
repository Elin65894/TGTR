//
//  LoginView.swift
//  TGTR
//
//  Created by Elin.Andersson on 2024-08-14.

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isAuthenticated = false
    @State private var isRegistering = false

    var body: some View {
        NavigationStack {
            VStack {
                Text(isRegistering ? "Register" : "Login")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button(action: {
                    isRegistering ? register() : login()
                }) {
                    Text(isRegistering ? "Register" : "Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }

                // NavigationLink that triggers navigation to ContentView
                NavigationLink(destination: ContentView(), isActive: $isAuthenticated) {
                    EmptyView()
                }
                
                Button(action: {
                    isRegistering.toggle()
                }) {
                    Text(isRegistering ? "Already have an account? Log In" : "Don't have an account? Register")
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                }
            }
            .padding()
        }
    }
    
    func login() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please enter both email and password."
            showAlert = true
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    alertMessage = error.localizedDescription
                    showAlert = true
                } else {
                    alertMessage = "Login successful!"
                    showAlert = true
                    isAuthenticated = true // Trigga navigation till ContentView
                }
            }
        }
    }
    
    func register() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please enter both email and password."
            showAlert = true
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    alertMessage = error.localizedDescription
                    showAlert = true
                } else {
                    alertMessage = "Registration successful! You can now log in."
                    showAlert = true
                    isRegistering = false
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


/*
import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Button(action: {
                login()
            }) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
    
    func login() {
        // Kontrollera om e-post eller lösenord är tomma
        if email.isEmpty || password.isEmpty {
            // Om någon av dem är tom, visa ett felmeddelande
            alertMessage = "Please enter both email and password."
            showAlert = true
        } else {
            // Anropa Firebase Authentication för att logga in med e-post och lösenord
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                // Om det uppstår ett fel, hantera det här
                if let error = error {
                    // Sätt felmeddelandet till alerten och visa det för användaren
                    alertMessage = error.localizedDescription
                    showAlert = true
                } else {
                    // Om inloggningen lyckades, visa ett framgångsmeddelande
                    alertMessage = "Login successful!"
                    showAlert = true
                    // Du kan navigera till en ny vy här efter en lyckad inloggning
                    // Exempelvis genom att uppdatera en state-variabel eller använda en NavigationLink
                }
            }
        }
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}*/
