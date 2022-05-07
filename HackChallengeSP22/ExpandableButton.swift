//
//  ExpandableButton.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/3/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct ExpandableButton: View {
    @Binding var showFAB: Bool
    @Binding var tasks: Tasks
    @Binding var shownTasks: [Task]
    @State var newTaskPresent = false
    @State var newEventPresent = false
    @Binding var userData: LoginResponse

    var body: some View {
        
        VStack(alignment: .trailing) {
            if showFAB {
                Button {
                    newTaskPresent.toggle()
                } label: {
                    HStack{
                    Spacer()
                    Text("New Task")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    Image("CreateTaskIcon")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(15)
                    }.padding(.trailing, 10)
                }.sheet(isPresented: $newTaskPresent) {
                    NewTask(userData: $userData, newTaskPresent: $newTaskPresent)
                    .onDisappear{self.refreshTasks()}
                }
                
                Button {
                    newEventPresent.toggle()
                    

                } label: {
                    HStack{
                    Spacer()
                    Text("New Event")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    Image("CreateEventIcon")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(15)
                    }.padding(.trailing, 10)
                }.sheet(isPresented: $newEventPresent) {
                    NewEvent(userData: $userData, newEventPresent: $newEventPresent)
                }
            }
    
            
            Button {
                showFAB.toggle()
            } label: {
                ZStack{
                Circle()
                        .frame(width: 64, height: 64)
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0), Color(.sRGB, red:  0.65, green: 0.74, blue: 0.89, opacity: 1.0)]), startPoint: .center, endPoint: .trailing)).frame(width: 64, height: 64).clipShape(Circle())
                        .padding(20)
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(20)
                    .foregroundColor(.white)
                    
                }.rotationEffect(.init(degrees: showFAB ? 45 : 0))
            
            }
            
        }
    }
    
    func refreshTasks(){
        NetworkManager.getTasks(sessionToken: userData.session_token) { tasks in
            self.tasks = tasks
            self.shownTasks = self.tasks.tasks
        }
    }
    
}

