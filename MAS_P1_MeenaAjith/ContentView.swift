//
//  ContentView.swift
//  MAS_P1_MeenaAjith
//
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userLoggedIn = false
    @State private var authErr = ""
    
    var body: some View {
        if userLoggedIn {
            WeatherView(userLoggedIn: $userLoggedIn, weatherModel: WeatherModel(weatherManager: WeatherManager()))
        } else {
            content
        }
    }
    var content: some View {
        ZStack {
            Color.blue
            
            VStack(spacing: 20) {
                Text("Welcome to the Weather Center!")
                    .foregroundColor(.white)
                    .font(.system(size:40, weight: .bold, design: .rounded))
                    .offset(x:0, y:-150)
                
                TextField("Email", text:$email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)

                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)

                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button {
                    register()
                } label: {
                    Text("Sign up")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                    )
                    .foregroundColor(.black)
                }
                .padding(.top)
                .offset(y: 100)
                
                Button {
                    login()
                } label: {
                    Text("Already have an account? Login!")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 110)
                
                if authErr.count > 0 {
                    Text(authErr)
                        .padding()
                        .border(.red, width: 4)
                        .foregroundColor(.white)
                        .offset(y: 140)
                }
            }
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userLoggedIn = true
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                authErr = error!.localizedDescription
            }
        }
    }
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                authErr = error!.localizedDescription
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
