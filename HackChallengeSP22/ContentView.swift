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
    @Binding var username: String
    @Binding var password: String
    @State var showFAB = false
    @State var tasks: Tasks = Tasks(tasks: [])
    @State var shownTasks: [Task] = []
    @State var chosenFilters: [taskCategory] = []
    @State var events: Events = Events(events: [])
    @State var isTodayOn = false
    @State var currentDate: Date = Date()
    @State var shownEvents = [Event]()
    @State var tasksToShow = [Task]()
    @State var eventsToShow = [Event]()
    @Binding var tryingLogin: Bool
    @Binding var successSignUp: Bool
    @Binding var successLogin: Bool
    
    var body: some View {
        TabView {

            NavigationView{
                HomeView(events: $events, tasks: $tasks, shownTasks: $shownTasks, showFAB: $showFAB, chosenFilters: $chosenFilters, userData: $userData, isTodayOn: $isTodayOn, currentDate: $currentDate, shownEvents: $shownEvents, tasksToShow: $tasksToShow, eventsToShow: $eventsToShow)
                    .onAppear{
                    username = ""
                    password = ""
                    }
                    .toolbar {
                    Button {
                        NetworkManager.postLogout(sessionToken: userData.session_token) { logout in
                        print (logout)
                        NetworkManager.postRefresh(updateToken: userData.update_token) { refresh in
                        userData = refresh
                        
                            }
                            tryingLogin = true
                            successLogin = false
                            successSignUp = false
                        
                        }
                        
                    } label: {
                        Image("LogoutIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
            
                    }
                    }
                    .background(RoundedRectangle(cornerRadius: 40).fill(Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0)).frame(maxHeight: .infinity).padding(.bottom, 480).ignoresSafeArea())
                    
            }.navigationBarHidden(false)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            NavigationView{
                CalendarView(tasks: $tasks, shownTasks: $shownTasks, events: $events, shownEvents: $shownEvents, userData: $userData, showFAB: $showFAB, tasksToShow: $tasksToShow, eventsToShow: $eventsToShow, currentDate: $currentDate)
                    .background(Rectangle().fill(Color(.sRGB, red:  0.93, green: 0.96, blue: 0.99, opacity: 1.0)).frame(maxHeight: .infinity).ignoresSafeArea())
            }
                .navigationBarHidden(false)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            NavigationView{
                TasksView(tasks: $tasks, shownTasks: $shownTasks, events: $events, shownEvents: $shownEvents, chosenFilters: $chosenFilters, userData: $userData, showFAB: $showFAB, isTodayOn: $isTodayOn, currentDate: $currentDate, tasksToShow: $tasksToShow, eventsToShow: $eventsToShow)
            }.navigationBarHidden(false)
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tasks")
                }
            }
    }
    

        



}
