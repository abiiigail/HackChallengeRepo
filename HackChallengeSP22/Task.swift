//
//  Task.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 4/30/22.
//

import SwiftUI

struct Task: Codable, Hashable {
    var task_id: Int? = nil
    var task_name: String
    var due_date: Int
    var completed: Bool
    var priority: Int
    
//    enum CodingKeys : String, CodingKey {
//        case taskId = "task_id"
//        case taskName = "task_name"
//        case dueDate = "due_date"
//        case completed
//        case priority
//    }
}

struct Tasks: Codable, Hashable{
    var tasks: [Task]
}

enum taskCategory : CustomStringConvertible, CaseIterable {
    case today
    case upcoming
    case complete
    
    var description: String {
        switch self {
        case .today: return "Today"
        case .upcoming: return "Upcoming"
        case .complete: return "Completed"
        }
    }
}

extension Task {
    var colorUI: Color {
        switch self.priority{
        case 0: return Color(.init(red: 0.68, green: 0.92, blue: 0.62, alpha: 1))
        case 1: return Color(.init(red: 1.0, green: 0.92, blue: 0.49, alpha: 1))
        case 2: return Color(.init(red: 0.98, green: 0.72, blue: 0.72, alpha: 1))
        default: return .white
        }
    }
    
    var realTime: Date {
        let epochTime = TimeInterval(self.due_date)
        let convertedDate = Date(timeIntervalSince1970: epochTime)
        return convertedDate
    }

}



//Hardcoded data examples
//extension Task {
//    static let data: [Task] = [
//    laundry,
//    bathroom,
//    kitchen,
//    homework,
//    relax
//    ]
//    
//    private static let laundry = Task(
//        taskName: "Do the laundry",
//        dueDate: 1651448682,
//        completed: false,
//        priority: 0
//    )
//    
//    private static let bathroom = Task(
//        taskName: "Clean the bathroom",
//        dueDate: 1651448682,
//        completed: true,
//        priority: 1
//    )
//    
//    private static let kitchen = Task(
//        taskName: "Wipe the kitchen",
//        dueDate: 1651448682,
//        completed: false,
//        priority: 2
//    )
//    
//    private static let homework = Task(
//        taskName: "Submit Midpoint sumbission",
//        dueDate: 1651448682,
//        completed: false,
//        priority: 0
//    )
//    
//    private static let relax = Task(
//        taskName: "Take a nap",
//        dueDate: 1651448682,
//        completed: true,
//        priority: 2
//    )
//    
//}
