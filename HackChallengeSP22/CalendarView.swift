//
//  CalendarView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/5/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct CalendarView: View {
    @State var currentDate: Date = Date()
    @Binding var tasks: Tasks
    @Binding var shownTasks: [Task]
    @Binding var events: Events
    @Binding var userData: LoginResponse
    @Binding var showFAB: Bool
    
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                WeekDayPicker(currentDate: $currentDate, tasks: $tasks, events: $events, userData: $userData)
                .onAppear{refreshTasks()}
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
                ExpandableButton(showFAB: $showFAB, userData: $userData)}
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
