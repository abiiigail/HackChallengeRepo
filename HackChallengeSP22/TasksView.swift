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
    @Binding var events: Events
    @Binding var shownEvents: [Event]
    @Binding var chosenFilters: [taskCategory]
    @Binding var userData: LoginResponse
    @Binding var showFAB: Bool
    @State var taskFilters = taskCategory.allCases
    @Binding var isTodayOn: Bool
    @Binding var currentDate: Date
    @State var filterIsSelected = false
    @Binding var tasksToShow: [Task]
    @Binding var eventsToShow: [Event]

    
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
                    TaskCategoriesCell(filterIsSelected: $filterIsSelected, category: filter).padding(.trailing, 15).padding(.bottom, 25)}
            }
                
            }.onAppear{if chosenFilters.count == 0 && isTodayOn {self.filterTasks()}}
            
            Rectangle().frame(height: 1).foregroundColor(.black)
                    .padding(.bottom, 15)
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    
                    ForEach($shownTasks, id: \.self) { task in
                        TaskRowCell(task: task, userData: $userData, tasks: $tasks, shownTasks: $shownTasks)
                    }

            }
            }
            Spacer()
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 0.686, green: 0.81, blue: 1.0, opacity: 1.0), Color.white]), startPoint: .top, endPoint: .bottom)).frame(maxHeight: .infinity).ignoresSafeArea()
        taskView
            .onAppear{if chosenFilters.count == 0 {self.filterTasks()}}
            .padding(.leading, 25)
            .padding(.trailing, 10)
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
                    ExpandableButton(showFAB: $showFAB, tasks: $tasks, shownTasks: $shownTasks, events: $events, shownEvents: $shownEvents, userData: $userData, tasksToShow: $tasksToShow, eventsToShow: $eventsToShow, currentDate: $currentDate)}
            }
        }
    }
    
    func refreshTasks(){
        NetworkManager.getTasks(sessionToken: userData.session_token) { tasks in
            self.tasks = tasks
            self.shownTasks = self.tasks.tasks.reversed()
        }
        
    }
    
    
    func filterTasks(){
        var filteredTasks = [Task]()
        
        
        if chosenFilters.count == 0 {refreshTasks()}
        else{
        
        for filter in chosenFilters{
            
            if filter.description == "Today" {
            
            for task in tasks.tasks{
                if Date(timeIntervalSince1970: TimeInterval(task.due_date)).formatted(date: .complete, time: .omitted) == Date().formatted(date: .complete, time: .omitted) && task.completed == false {
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
        shownTasks = filteredTasks.reversed()
        }}
}
    


