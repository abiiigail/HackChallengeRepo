//
//  EventSquareCell.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/30/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct EventSquareCell: View {
    @Binding var event: Event
    static let id = "EventSquareCellId"
    
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 25)
                .strokeBorder(event.colorUI, lineWidth: 2)
                .frame(width: 150, height: 150)
            VStack() {
                Text(event.event_name)
                    .font(.headline)
                    .frame(alignment: .top)
                    .padding(.top, 10)
                Text(event.description)
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .padding(.top, 2)
                Spacer()
                Text("\(Date(timeIntervalSince1970: TimeInterval(event.start_time)).formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 15, weight: .semibold, design: .default))
                    .frame(alignment: .bottom)
                    .padding(.bottom, 10)
            } .frame(width: 130, height: 140)
        
        }
        .foregroundColor(.black)
        
    }
}
