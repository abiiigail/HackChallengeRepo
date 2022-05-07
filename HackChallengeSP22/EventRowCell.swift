//
//  EventRowCell.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/30/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct EventRowCell: View {
    @Binding var event: Event
    @Binding var userData: LoginResponse
    static let id = "EventRowCellId"
    
    private var EventRectangle: some View {
       RoundedRectangle(cornerRadius: 25)
            .foregroundColor(event.colorUI)
            .frame(height: 50)
            .padding(.trailing, 10)
    }
    
    
    var body: some View {
        HStack{
            Button {
                
                
            } label: {
                ZStack{
                EventRectangle
                HStack{
                Text("\(Date(timeIntervalSince1970: TimeInterval(event.start_time)).formatted(date: .omitted, time: .shortened))")
                        .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(.black)
                    .padding(.trailing, 2)
                    .padding(.leading, 25 )
                Text(event.event_name)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.black)
                Spacer()
                    }
                }
                }

            }

        }
}
    



