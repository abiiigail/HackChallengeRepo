//
//  NewTask.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/4/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct NewTask: View {
    @Binding var userData: LoginResponse
    @Binding var newTaskPresent: Bool
    @State var newTask = Task(task_name: "", due_date: 1651448682, completed: false, priority: 2)
    @State var tempDate = Date()
    @State var isHigh = true
    @State var isMedium = false
    @State var isLow = false
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
            Button {
                newTaskPresent.toggle()
            } label: {
                Image(systemName: "plus").resizable().frame(width: 20, height: 20).rotationEffect(.init(degrees: 45)).foregroundColor(.black)
            }.padding(.trailing, 15)
            
            Text("New Task").font(.title.bold())
            
            }.padding(.top, 50).padding(.bottom, 15)
        
        
            
        VStack{
            TextField(text: $newTask.task_name, prompt: Text("Task Name").font(.system(size: 20, weight: .medium, design: .default)).foregroundColor(.gray)) {
            Text("Task Name")
        }
        Rectangle().frame(height: 1).foregroundColor(.black)
                .padding(.bottom, 15)
        }.padding(.bottom, 15)
        
        HStack{
            Image("DateIcon")
                .resizable()
                .frame(width: 24, height: 24)
            
            DatePicker("Due Date", selection: $tempDate, displayedComponents: .date)
               
        }.padding(.bottom, 15)
            
            HStack(alignment: .top){
                Image("PriorityIcon")
                    .resizable()
                    .frame(width: 24, height: 24).padding(.top, 2)
                
            PriorityDropDown(isHigh: $isHigh, isMedium: $isMedium, isLow: $isLow)
                   
        }
        
        Spacer()
            
        Button {
            if tempDate != Date() {newTask.due_date = Int(tempDate.timeIntervalSince1970)}
            if isHigh != true {
                if isMedium {
                  newTask.priority = 1
                } else
                { newTask.priority = 0
                }
            }
            if newTask.task_name != "" {
            createTask(newTask: newTask)
            newTaskPresent.toggle()
            }
        } label: {
            ZStack{
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 48)
                .foregroundColor(newTask.task_name != "" ? Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0) : .gray)
            Text("Create Task")
                    .font(.body)
                .foregroundColor(.white)
            }
        }.padding(.bottom, 25)
        }.padding(.horizontal, 25)
    }
    
    func createTask(newTask: Task){
        NetworkManager.createTask(sessionToken: userData.session_token, taskName: newTask.task_name, dueDate: newTask.due_date, completed: newTask.completed, priority: newTask.priority) { task in
        }
    }
    
}

//struct NewTask_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTask()
//    }
//}
