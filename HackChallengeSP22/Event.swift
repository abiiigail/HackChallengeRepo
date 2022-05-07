//
//  Event.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/30/22.
//

import SwiftUI

struct Event: Codable, Hashable {
    var id: Int? = nil
    var event_name: String
    var description: String
    var start_time: Int
    var end_time: Int
    var color: String
    var location: String
   
}

struct Events: Codable, Hashable{
    var events: [Event]
}

extension Event {
    var colorUI: Color {
        switch self.color{
        case "Blue": return .blue
        case "Orange": return Color(.init(red: 1.0, green: 0.92, blue: 0.49, alpha: 1))
        case "Red": return Color(.init(red: 0.98, green: 0.72, blue: 0.72, alpha: 1))
        case "Purple": return .purple
        default: return .red
        }
    }
}

//Hardcoded data examples
extension Event {
    static let data: [Event] = [
    dinner,
    lunch,
    CS3110,
    paint
    ]
    
    private static let dinner = Event(
        id: 001,
        event_name: "Dinner with Anna",
        description: "Don't forget to bring the drinks!",
        start_time: 1651448682,
        end_time: 1651448683,
        color: "Blue",
        location: "anna's house"
        )
    
    private static let lunch = Event(
        id: 002,
        event_name: "Lunch Meeting",
        description: "Meet at CTB",
        start_time: 1651448682,
        end_time: 1651448683,
        color: "Red",
        location: "collegetown"
        )
    
    private static let CS3110 = Event(
        id: 003,
        event_name: "CS3110 Lecture",
        description: "Lecture 13",
        start_time: 1651448682,
        end_time: 1651448683,
        color: "Orange",
        location: "statler"
        )
    
    private static let paint = Event(
        id: 004,
        event_name: "Painting Session",
        description: "Time to get our Bob Ross on :)",
        start_time: 1651448682,
        end_time: 1651448683,
        color: "Orange",
        location: "park"
        )
}

