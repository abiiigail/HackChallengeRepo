//
//  ContentView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/28/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @Binding var userData: LoginResponse
    @State var showFAB = false
    @State var tasks: Tasks = Tasks(tasks: [])
    @State var shownTasks: [Task] = []
    @State var chosenFilters: [taskCategory] = []
    @State var events: Events = Events(events: [])
    var body: some View {
        TabView {

            NavigationView{
                HomeView(events: $events, tasks: $tasks, shownTasks: $shownTasks, showFAB: $showFAB, userData: $userData)
                    .toolbar {
                    Button {
                        //TODO: Add action
                    } label: {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    }
                    .background(RoundedRectangle(cornerRadius: 40).fill(Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0)).frame(maxHeight: .infinity).padding(.bottom, 480).ignoresSafeArea())
                    
            }.navigationBarHidden(false)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            NavigationView{
                CalendarView(tasks: $tasks, shownTasks: $shownTasks, events: $events, userData: $userData, showFAB: $showFAB)
                    .background(Rectangle().fill(Color(.sRGB, red:  0.93, green: 0.96, blue: 0.99, opacity: 1.0)).frame(maxHeight: .infinity).ignoresSafeArea())
            }.navigationBarHidden(false)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            NavigationView{
                TasksView(tasks: $tasks, shownTasks: $shownTasks, chosenFilters: $chosenFilters, userData: $userData, showFAB: $showFAB)
            }.navigationBarHidden(false)
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tasks")
                }
            }
    }
}

        



