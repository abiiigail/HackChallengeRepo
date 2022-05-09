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
    @Binding var events: Events
    @Binding var shownEvents: [Event]
    @State var newTaskPresent = false
    @State var newEventPresent = false
    @Binding var userData: LoginResponse
    @Binding var tasksToShow: [Task]
    @Binding var eventsToShow: [Event]
    @Binding var currentDate: Date

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
                        .onDisappear{self.refreshTasks(); self.refreshCalendarTasks()}
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
                        .onDisappear{self.refreshEvents(); self.refreshCalendarEvents()}
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

func refreshEvents(){
    NetworkManager.getEvents(sessionToken: userData.session_token) { events in
        self.events = events
        shownEvents = []
        for event in events.events{
            if Date(timeIntervalSince1970: TimeInterval(event.start_time)).formatted(date: .complete, time: .omitted) == Date().formatted(date: .complete, time: .omitted){
                shownEvents.append(event)
    }
        }
    }
}
    
    func refreshCalendarTasks(){
        tasksToShow = []
        for task in tasks.tasks {
            if Date(timeIntervalSince1970: TimeInterval(task.due_date)).formatted(date: .complete, time: .omitted) == currentDate.formatted(date: .complete, time: .omitted) && task.completed == false {
                tasksToShow.append(task)
            }
        }
    }
    
    func refreshCalendarEvents(){
        tasksToShow = []
        for task in tasks.tasks {
            if Date(timeIntervalSince1970: TimeInterval(task.due_date)).formatted(date: .complete, time: .omitted) == currentDate.formatted(date: .complete, time: .omitted) && task.completed == false {
                tasksToShow.append(task)
            }
        }
    }

}
