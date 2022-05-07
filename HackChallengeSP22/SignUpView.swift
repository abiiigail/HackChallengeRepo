//
//  SignUpView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/6/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct SignUpView: View {
    
    @Binding var firstName: String
    @Binding var username: String
    @Binding var password: String
    @Binding var tryingLogin: Bool
    @Binding var tryingSignUp: Bool
    @Binding var userData: LoginResponse
    @Binding var successSignUp: Bool
    @Binding var successLogin: Bool
    
    var body: some View {
        
        return Group{
            if !tryingLogin && !successSignUp {
            ZStack{
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 0.7), Color(.sRGB, red:  0.93, green: 0.96, blue: 0.99, opacity: 1.0)]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
            
                    
            VStack(alignment: .leading){
            Text("Sign Up")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
                    .padding(.bottom, 25)
            
            Text("FIRST NAME").font(.subheadline)
            TextField(text: $firstName, prompt: Text("Required")) {
                Text("First Name")
            }
            Rectangle().frame(height: 1).foregroundColor(.black)
                    .padding(.bottom, 15)
          
            Text("USERNAME").font(.subheadline)
            TextField(text: $username, prompt: Text("Required")) {
                    Text("First Name")
                }
            Rectangle().frame(height: 1).foregroundColor(.black)
                    .padding(.bottom, 15)
              
            VStack(alignment: .leading){
            Text("PASSWORD").font(.subheadline)
            SecureField(text: $password, prompt: Text("Required")) {
                    Text("Password")
                }
            Rectangle().frame(height: 1).foregroundColor(.black)
            }.padding(.bottom, 50)
            
            Button {
                signUp(firstName: firstName, username: username, password: password)
//                NetworkManager.postRegister(first_name: $firstName, username: $username, password: $password) { register in
//                    NetworkManager.postLogin(username: $username, password: $password) { login in
//                        userData = login
//                        successSignUp.toggle()
//                    }
//                }
            } label: {
                ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0))
                    .frame(height: 55)
                    .shadow(color: .gray, radius: 1, x: 0, y: 1.5)
                Text("Sign Up")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(.white)
                }
            }.padding(.bottom, 15)
            
                HStack(alignment: .bottom){
                    Spacer()
                Text("Already have an account?")
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
                Button {
                    tryingLogin.toggle()
                    tryingSignUp.toggle()
                    }label: {
                    Text("Login")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
                    }
                    Spacer()
            }
        
            }.padding(.horizontal, 25)
            }
                
            }
            else{StartView()}
        }

    }
    
    func signUp(firstName: String, username: String, password: String){
        NetworkManager.postRegister(first_name: firstName, username: username, password: password) { register in
            NetworkManager.postLogin(username: username, password: password) { login in
                userData = login
                successSignUp.toggle()
                successLogin.toggle()
                tryingSignUp.toggle()
            }
    }
}
}
