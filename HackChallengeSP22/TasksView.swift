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
                    if chosenFilters.contains(filter){
                        chosenFilters.remove(at: chosenFilters.firstIndex(of: filter)!)}
                    else{chosenFilters.append(filter)}
                    filterTasks()
                    print(chosenFilters.count)
                }label: {
                    TaskCategoriesCell(category: filter).padding(.trailing, 15).padding(.bottom, 25)}
            }
                
            }
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach($shownTasks, id: \.self) { task in
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
    
    func filterTodayTasks(){
        var todaysTasks = [Task]()
        
        for task in tasks.tasks {
            if task.due_date == Int(Date().timeIntervalSince1970) {
                todaysTasks.append(task)
            }
        }
        
//        ForEach(tasks.tasks, id: \.self) {task in
//            if task.due_date == Int(Date().timeIntervalSince1970) {
//                todaysTasks.append(task)
//            }
//        }
        shownTasks = todaysTasks
        }
    
    func filterTasks(){
        var filteredTasks = [Task]()
        
        if chosenFilters.count == 0 {refreshTasks()}
        else{
        
        for filter in chosenFilters{
            
            if filter.description == "Today" {
            for task in tasks.tasks{
                if Date(timeIntervalSince1970: TimeInterval(task.due_date)).formatted(date: .complete, time: .omitted) == Date().formatted(date: .complete, time: .omitted) {
                    filteredTasks.append(task)
            }
            }
            }
            
            if filter.description == "Completed" {
            for task in tasks.tasks{
                if task.completed == true {
                    if !filteredTasks.contains(task){
                        filteredTasks.append(task)
                    }
            }
            }
            }
            
            if filter.description == "Upcoming" {
                for task in tasks.tasks{
                    var dayComponent = DateComponents()
                    dayComponent.day = 1
                    let calendar = Calendar.current
                    let nextDate: Date = calendar.date(byAdding: dayComponent, to: Date())!
                    if (Date(timeIntervalSince1970: TimeInterval(task.due_date)) + 1).formatted(date: .complete, time: .omitted) == (nextDate).formatted(date: .complete, time: .omitted) {
                        if !filteredTasks.contains(task){
                        filteredTasks.append(task)
                        }
                    }
                }
                
            }
            
            
    }
        shownTasks = filteredTasks
        }}
}
    


