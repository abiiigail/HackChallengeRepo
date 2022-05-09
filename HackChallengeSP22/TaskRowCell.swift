//
//  TaskRowCell.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/30/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct TaskRowCell: View {
    @Binding var task: Task
    @Binding var userData: LoginResponse
    @Binding var tasks: Tasks
    @Binding var shownTasks: [Task]
    static let id = "TaskRowCellId"
    
    private var emptyCircle: some View {
        Circle()
            .strokeBorder(task.colorUI, lineWidth: 2)
            .background(Circle().fill(.clear))
            .frame(width: 30, height: 30)
            .padding(.trailing, 5)
    }
    
    private var filledCircle: some View {
        ZStack{
        Circle()
            .foregroundColor(task.colorUI)
            .frame(width: 30, height: 30)
            .padding(.trailing, 5)
            
        Image(systemName: "checkmark")
                .resizable()
                .frame(width: 14, height: 14, alignment: .center)
                .foregroundColor(.white)
                .padding(.leading, -3)
        }
    }
    
    
    var body: some View {
        HStack{
            Button {
                NetworkManager.completeTask(sessionToken: userData.session_token, id: task.task_id!, completed: !task.completed) { update in
                    task = update
                    self.refreshTasks()
                }
                
            } label: {
                if task.completed {
                    filledCircle
                } else {
                    emptyCircle
                }

            }

            VStack(alignment: .leading){
            Text(task.task_name)
            .font(.system(size: 16, weight: .medium, design: .default))
            .foregroundColor(.black)
            .padding(.leading, -1)
            
            Text(Date(timeIntervalSince1970: TimeInterval(task.due_date)).formatted(date: .abbreviated, time: .omitted))
                .font(.system(size: 14, weight: .regular, design: .default))
                .foregroundColor(.gray)
                .padding(.leading, -1)
            }
        Spacer()
        }
    }
    func refreshTasks(){
        NetworkManager.getTasks(sessionToken: userData.session_token) { tasks in
            self.tasks = tasks
            self.shownTasks = self.tasks.tasks.reversed()
        }
}
}
