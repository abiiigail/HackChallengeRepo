//
//  NewEvent.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/4/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct NewEvent: View {
    
    @Binding var userData: LoginResponse
    @Binding var newEventPresent: Bool
    @State var newEvent = Event(event_name: "", description: "", start_time: Int(Date().timeIntervalSince1970), end_time: Int(Date().timeIntervalSince1970 + 1), color: "Red", location: "")
    @State var tempDate = Date()
    @State var selectedDate = Date()
    @State var selectedStart = Date()
    @State var selectedEnd = Date()
    
    private var eventView: some View {
        
        
        VStack(alignment: .leading){
            
            HStack{
            Button {
                newEventPresent.toggle()
            } label: {
                Image(systemName: "plus").resizable().frame(width: 20, height: 20).rotationEffect(.init(degrees: 45)).foregroundColor(.black)
            }.padding(.trailing, 15)
            
            Text("New Event").font(.title.bold())
            
            }.padding(.top, 50).padding(.bottom, 15)
        
        
            
        VStack{
            TextField(text: $newEvent.event_name, prompt: Text("Event Name").font(.system(size: 20, weight: .medium, design: .default)).foregroundColor(.gray)) {
            Text("Event Name")
        }
        Rectangle().frame(height: 1).foregroundColor(.black)
                .padding(.bottom, 15)
        }.padding(.bottom, 15).padding(.trailing, 25)
                
            
            DatePicker("Event date", selection: $selectedDate, displayedComponents: .date)
                .padding(.trailing, 25)
            
            DatePicker("Start", selection: $selectedStart, displayedComponents: .hourAndMinute)
                .padding(.trailing, 25)
            
            DatePicker("End", selection: $selectedEnd, displayedComponents: .hourAndMinute)
                .padding(.trailing, 25)
            
            HStack{
                Image("LocationIcon")
                    .resizable()
                    .frame(width: 18, height: 24)
                
                TextField(text: $newEvent.location, prompt: Text("Location").font(.system(size: 20, weight: .medium, design: .default)).foregroundColor(.gray)) {
                Text("Location")
            }
                   
            }.padding(.bottom, 15)
            
            Text("Color")
            
           
            
            Spacer()
        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
        VStack{
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 0) {
                eventView
                HStack(alignment: .top){
                    Image("DescriptionIcon")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    TextEditor(text: $newEvent.description).background(Color.black)
                        .frame(height:geometry.size.height / 4, alignment: .center)
                        .cornerRadius(25)
                        .lineSpacing(10)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                        .padding([.leading, .trailing], 10)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color(.systemGray5), lineWidth: 2.0)
                                )
                }.padding(.trailing, 25)
            }.padding(.leading, 25)
        }
        .navigationBarBackButtonHidden(false)
        
            Button {
                if selectedStart != Date() {newEvent.start_time = Int(selectedStart.timeIntervalSince1970)}
                if selectedEnd != Date() {newEvent.end_time = Int(selectedEnd.timeIntervalSince1970)}
                if newEvent.event_name != "" && newEvent.location != "" {
                createEvent(newEvent: newEvent)
                newEventPresent.toggle()
                }
            } label: {
                ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 48)
                    .foregroundColor(newEvent.event_name != "" && newEvent.location != "" ? Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0) : .gray)
                Text("Create Event")
                        .font(.body)
                    .foregroundColor(.white)
                }
            }.padding(.horizontal, 25).padding(.bottom, 15)

        }
        }
    }
    
    func createEvent(newEvent: Event){
        NetworkManager.createEvent(sessionToken: userData.session_token, eventName: newEvent.event_name, description: newEvent.description, startTime: newEvent.start_time, endTime: newEvent.end_time, color: newEvent.color, location: newEvent.location) { event in
        }
    }
        
}
