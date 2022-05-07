//
//  StartView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/6/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct StartView: View {
    @State var firstName = ""
    @State var username = ""
    @State var password = ""
    @State var tryingLogin = false
    @State var tryingSignUp = false
    @State var successSignUp = false
    @State var successLogin = false
    @State var userData: LoginResponse = LoginResponse(session_token: "", session_expiration: "", update_token: "")
    var body: some View {
        return Group{
            if tryingLogin {
                LoginView(username: $username, password: $password, userData: $userData, tryingLogin: $tryingLogin, tryingSignUp: $tryingSignUp, successLogin: $successLogin)
            }
            if tryingSignUp {
                SignUpView(firstName: $firstName, username: $username, password: $password, tryingLogin: $tryingLogin, tryingSignUp: $tryingSignUp,userData: $userData, successSignUp: $successSignUp, successLogin: $successLogin)
            }
            if successSignUp || successLogin {
                ContentView(userData: $userData)
            }
            else if !tryingLogin && !tryingSignUp{
                
        ZStack{
            Rectangle()
                .foregroundColor(Color(.sRGB, red:  0.93, green: 0.96, blue: 0.99, opacity: 1.0))
                .ignoresSafeArea()
        VStack{
            Image("Logo")
                .resizable()
                .frame(width: 155, height: 148)
            Text("PlanMate")
                .font(.system(size: 55, weight: .bold, design: .default))
                .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
            Button {
                tryingSignUp.toggle()
            } label: {
                ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0))
                    .frame(height: 55)
                    .padding(.horizontal, 55)
                    .shadow(color: .gray, radius: 1, x: 0, y: 1.5)
                Text("Get Started")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(.white)
                }
            }
            .padding(.bottom, 15)
           
          
            Button {
                tryingLogin.toggle()
                }label: {
                Text("Login")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
                }
    }
    }
            }
                
}
    }}

@available(iOS 15.0, *)
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
