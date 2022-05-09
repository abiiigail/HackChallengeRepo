//
//  LoginView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/4/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct LoginView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var userData: LoginResponse
    @Binding var tryingLogin: Bool
    @Binding var tryingSignUp: Bool
    @Binding var successLogin: Bool
    @State var logoutMessage: String = ""
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 0.7), Color(.sRGB, red:  0.93, green: 0.96, blue: 0.99, opacity: 1.0)]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
            Text("Login")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
                    .padding(.bottom, 25)
            
            Text("USERNAME").font(.subheadline)
            TextField(text: $username, prompt: Text("Required")) {
                Text("Username")
            }
            Rectangle().frame(height: 1).foregroundColor(.black)
                    .padding(.bottom, 15)
            
            VStack(alignment: .leading){
            Text("PASSWORD").font(.subheadline)
            SecureField(text: $password, prompt: Text("Required")) {
                    Text("Password")
                }
            Rectangle().frame(height: 1).foregroundColor(.black)
            }.padding(.bottom, 15)
                
            HStack(alignment: .bottom){
                    Spacer()
                Text("Need an account?")
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
                Button {
                    tryingLogin.toggle()
                    tryingSignUp.toggle()
                    }label: {
                    Text("Sign Up")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
                    }
            }.padding(.bottom, 100)
            
            Button {
                
                if username != "" && password != ""{
                    print(username, password)
                    NetworkManager.postLogin(username: username, password: password) { login in
                        userData = login
                        tryingLogin.toggle()
                        successLogin.toggle()
                        print(userData)
                    }
            }
                   
                } label: {
                    ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0))
                        .frame(height: 55)
                        .shadow(color: .gray, radius: 1, x: 0, y: 1.5)
                    Text("Login")
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    }
                }


            }.padding(.horizontal, 25)
        }
        }
    }

