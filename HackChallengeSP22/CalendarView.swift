//
//  CalendarView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/5/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct CalendarView: View {
    @Binding var tasks: Tasks
    @Binding var shownTasks: [Task]
    @Binding var events: Events
    @Binding var shownEvents: [Event]
    @Binding var userData: LoginResponse
    @Binding var showFAB: Bool
    @Binding var tasksToShow: [Task]
    @Binding var eventsToShow: [Event]
    @Binding var currentDate: Date
    
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                WeekDayPicker(currentDate: $currentDate, tasks: $tasks, events: $events, userData: $userData, tasksToShow: $tasksToShow, eventsToShow: $eventsToShow, shownTasks: $shownTasks)
                    .onAppear{
                        refreshTasks();
                        refreshEvents()
                    }
            }.blur(radius: showFAB ? 2 : 0)
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
    
}
