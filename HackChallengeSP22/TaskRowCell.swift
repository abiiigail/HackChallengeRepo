//
//  TaskRowCell.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/30/22.
//

import SwiftUI

struct TaskRowCell: View {
    @Binding var task: Task
    @Binding var userData: LoginResponse
    static let id = "TaskRowCellId"
    
    private var emptyCircle: some View {
        Circle()
            .strokeBorder(task.colorUI, lineWidth: 2)
            .background(Circle().fill(.clear))
            .frame(width: 20, height: 20)
            .padding(.trailing, 10)
    }
    
    private var filledCircle: some View {
        Circle()
            .foregroundColor(.gray)
            .frame(width: 20, height: 20)
            .padding(.trailing, 10)
    }
    
    
    var body: some View {
        HStack{
            Button {
                NetworkManager.completeTask(sessionToken: userData.session_token, id: task.task_id!, completed: !task.completed) { update in
                    task = update
                }
                
            } label: {
                if task.completed {
                    filledCircle
                } else {
                    emptyCircle
                }

            }

        
        Text(task.task_name)
            .font(.system(size: 15, weight: .medium, design: .default))
            .foregroundColor(.black)
        Spacer()
        }
    }
}
