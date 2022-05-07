//
//  EventDataView.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/30/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct EventDataView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selectedDate = Date()
    @Binding var event: Event
    
    
    private var eventView: some View {
        HStack{
        VStack(alignment: .leading){
            Text(event.event_name)
                .font(.title.bold())
                .foregroundColor(.black)
                
            Spacer()
            
            HStack{
            Image("DateIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text("\(Date(timeIntervalSince1970: TimeInterval(event.start_time)).formatted(date: .complete, time: .omitted))")
                    .font(.title.weight(.medium))
                .foregroundColor(.black)
            }.padding(.bottom, 10)
            
            HStack{
                Text("Start Time").font(.subheadline)
                
                Text("\(Date(timeIntervalSince1970: TimeInterval(event.start_time)).formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 18, weight: .medium, design: .default))
                .foregroundColor(.black)
            }.padding(.bottom, 10).padding(.leading, 24)
            
            HStack{
                Text("End Time").font(.subheadline)
                
                Text("\(Date(timeIntervalSince1970: TimeInterval(event.end_time)).formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 18, weight: .medium, design: .default))
                .foregroundColor(.black)
            }.padding(.bottom, 25).padding(.leading, 24)
            
            Spacer()
            
            HStack{
                Image("LocationIcon")
                    .resizable()
                    .frame(width: 18, height: 24)
                
                Text(event.location)
            }.padding(.bottom, 25)
            
            Spacer()
            
            
            Text("Color")
                .padding(.bottom, 25)
            
            HStack{
                Image("DescriptionIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text(event.description)
            }
            
            
            
            
        }.padding(.horizontal, 25)
            Spacer()
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                eventView
            }
        }
        .navigationBarBackButtonHidden(false)


        }.padding(.horizontal, 15)
    }
}

