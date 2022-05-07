//
//  TasksView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/1/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct TasksView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var tasks: Tasks
    @Binding var shownTasks: [Task]
    @Binding var chosenFilters: [taskCategory]
    @Binding var userData: LoginResponse
    @Binding var showFAB: Bool
    @State var taskFilters = taskCategory.allCases
    
    private var taskView: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("My Tasks")
                .font(.title.bold())
                .foregroundColor(.black)
                .padding(.bottom, 15)
            
            HStack{
            ForEach(taskFilters, id: \.self){ filter in
                Button{
                    
                    //Action: change shown task to filter button
                }label: {
                    TaskCategoriesCell(category: filter).padding(.trailing, 15).padding(.bottom, 25)}
            }
                
            }
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach($tasks.tasks, id: \.self) { task in
                    TaskRowCell(task: task, userData: $userData)
                    }

            }
            }
            Spacer()
        }
    }
    
    var body: some View {
        ZStack{
        taskView
            .padding(.leading, 25)
            .padding(.trailing, 10)
            .onAppear{self.refreshTasks()}
            .blur(radius: showFAB ? 2 : 0)
                if showFAB {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.black.opacity(0.6))
                        .ignoresSafeArea()
                }
            
        HStack {
                Spacer()
                VStack(alignment: .leading){
                Spacer()
                    ExpandableButton(showFAB: $showFAB, tasks: $tasks, shownTasks: $shownTasks,  userData: $userData)}
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

