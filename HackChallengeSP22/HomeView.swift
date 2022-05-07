//
//  HomeView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/30/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct HomeView: View {
    @State var showEvent = false
    @Binding var events: Events
    @Binding var showFAB: Bool
    @Binding var userData: LoginResponse
    
    
    
    
    private var title: some View {
        Text("Hi Matilda,")
            .font(.system(size: 40, weight: .semibold, design: .default))
            .foregroundColor(Color(.sRGB, red: 0.10, green: 0.13, blue: 0.24, opacity: 1))
            .padding(.leading, 25)
            
    }
    
    private var subtitle: some View {
        Text("Today is Monday, April 22")
            .font(.system(size: 25, weight: .semibold, design: .default))
            .foregroundColor(.black)
            .padding(.leading, 25)
    }
    
    private var pendingTasks: some View {
        Button {
            // TODO: add action here
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(color: .gray, radius: 1, x: 0, y: 1.5)
                    .frame(height: 120)
                    .padding(.horizontal, 25)
                HStack{
                    Image("PendingIcon3")
                        .resizable()
                        .frame(width: 71, height: 71)
                        .aspectRatio(contentMode: .fill)
                        .padding(.trailing, 25)
                        .padding(.leading, 50)
                    VStack(alignment: .leading, spacing: 0){
                        Text("You have")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.bottom, 2)
                        HStack{
                        Text("8 Tasks")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .aspectRatio(contentMode: .fill)
                            .padding(.trailing, 40)
                            .foregroundColor(.black)
                        }
                    }
                    Spacer()
                    }
                }
            }
        }
    
    private var completedTasks: some View {
        Button {

        } label: {
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(color: .gray, radius: 1, x: 0, y: 1.5)
                    .frame(width: 150, height: 150)
                    .padding(.trailing, 15)
                    .padding(.leading, 25)
                VStack(alignment: .leading, spacing: 0){
                    Image("CompletedIcon")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading, 80)
                        .padding(.top, 10)
                    Spacer()
                    Text("Completed")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.leading, 15)
                        .padding(.bottom, 2)
                    HStack{
                        Text("3 Tasks")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 18, height: 15)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)

                    }
                    .frame(alignment: .bottom)
                    .padding(.bottom, 10).padding(.horizontal, 15)
                }
                .frame(width: 140, height: 140)
                .padding(.leading, 25)
            }
        }
    }
    
    private var upcomingTasks: some View {
        Button {
            // TODO: add action here
        } label: {
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(color: .gray, radius: 1, x: 0, y: 1.5)
                    .frame(height: 150)
                VStack(alignment: .leading, spacing: 0){
                    Image("UpcomingIcon")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading, 150)
                        .padding(.top, 10)
                        .padding(.trailing, 25)
                    Spacer()
                    Text("Upcoming")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.bottom, 2)
                    HStack{
                        Text("2 Tasks")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.leading, -25)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 18, height: 15)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)

                    }
                    .frame(alignment: .bottom)
                    .padding(.bottom, 10).padding(.horizontal, 25)
                }
                .frame(height: 140)
                .padding(.leading, 25)

            }.padding(.trailing, 25)
        }
    }
    
    private var eventList: some View {
        
        VStack(alignment: .leading, spacing: 0) {
        Text("Today's Events")
                .font(.system(size: 25, weight: .bold, design: .default))
                .foregroundColor(.black)
                .padding(.leading, 25)
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach($events.events, id: \.self) { event in
                NavigationLink {
                    EventDataView(event: event)
                } label: {
                        EventSquareCell(event: event)
                }
                .padding(.leading, 2)
                

            }
        }
            .frame(height: 185)
            .padding(.horizontal,25)
        }
    }
    }
    var body: some View {
        ZStack{
           
        VStack(alignment: .leading, spacing: 0) {
            title
            subtitle
                .padding(.top, 5)
            pendingTasks
                .padding(.vertical, 15)
            HStack{
                completedTasks
                    .padding(.leading, 15)
                    .padding(.trailing, -15)
                upcomingTasks
                    .padding(.trailing)
            }.padding(.bottom, 15).padding(.horizontal, -15)
            Spacer()
            eventList
                .padding(.bottom, 15)
                .onAppear{self.refreshEvents()}
            Spacer()
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
            }.padding(.horizontal, 15).padding(.bottom, 15)
        }
    }
    
    func refreshEvents(){
        NetworkManager.getEvents(sessionToken: userData.session_token) { events in
            self.events = events
        }
    }
}
