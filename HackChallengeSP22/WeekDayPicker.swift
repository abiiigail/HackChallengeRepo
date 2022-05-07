//
//  WeekDayPicker.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/5/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct WeekDayPicker: View {
    @Binding var currentDate: Date
    @Binding var tasks: Tasks
    @Binding var events: Events
    @Binding var userData: LoginResponse
    @Binding var tasksToShow: [Task]
    @Binding var eventsToShow: [Event]
    
    @State var currentMonth: Int = 0
    var body: some View {
        VStack(spacing: 35){
            
            let days: [String] =
            ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing:20){
                Text("\(extraData()[0]) \(extraData()[1])")
                    .font(.title.bold())
                    .padding(.trailing, 1)
                    
            Spacer()
            
            Button {
                withAnimation {
                    currentMonth -= 1
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            
            Button {
                withAnimation {
                    currentMonth += 1
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
            }
            
            HStack(spacing:0){
                ForEach(days, id: \.self) {day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(extractDate()){ value in
                    CardView(value: value)
                        .background(
                            RoundedRectangle(cornerRadius: 15).fill(Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0)).padding(.horizontal,6).opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0))
                        .onTapGesture {
                            currentDate = value.date
                            tasksToShow = []
                            for task in tasks.tasks {
                                let epochTime = TimeInterval(task.due_date)
                                let convertedDate = Date(timeIntervalSince1970: epochTime)
                                if isSameDay(date1: convertedDate, date2: currentDate) && task.completed == false{
                                    tasksToShow.append(task)
                                }
                            }
                            eventsToShow = []
                            for event in events.events {
                                let epochTime = TimeInterval(event.start_time)
                                let convertedDate = Date(timeIntervalSince1970: epochTime)
                                if isSameDay(date1: convertedDate, date2: currentDate){
                                    eventsToShow.append(event)
                                }
                            }
                        }
                }
            }.padding(.top, -5).padding(.bottom, -25)
            
            ZStack{
                RoundedRectangle(cornerRadius: 40).fill(.white).frame(maxHeight: .infinity).ignoresSafeArea().padding(.horizontal, -25)
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading){
                    HStack{
                    Text("Events")
                    .font(.title2.bold())
                            .padding(.bottom, 15)
                    Spacer()}
                    
                    if events.events.first(where: { event in
                        let epochTime = TimeInterval(event.start_time)
                        let convertedDate = Date(timeIntervalSince1970: epochTime)
                        return isSameDay(date1: convertedDate, date2: currentDate)
                    }) != nil{
                        
                        VStack {
                            ForEach($eventsToShow, id: \.self) { event in
                            NavigationLink {
                                EventDataView(event: event)
                            } label: {
                                EventRowCell(event: event, userData: $userData)
                            }
                        }
                    }
                        
                    } else{
                        
                        
                        Text("No Events Today :)").font(.system(size: 18, weight: .medium, design: .default))
                        
                    }
                    
                    Spacer()
                
                       
                        Text("Tasks")
                    .font(.title2.bold())
                    .padding(.top, 25).padding(.bottom, 15)
                        
                
                if tasks.tasks.first(where: { task in
                    let epochTime = TimeInterval(task.due_date)
                    let convertedDate = Date(timeIntervalSince1970: epochTime)
                    return isSameDay(date1: convertedDate, date2: currentDate)
                }) != nil{
                    VStack {
                        
                    
                    ForEach($tasksToShow, id: \.self) { task in
                                TaskRowCell(task: task, userData: $userData)}
                       
                    }} else {
                    
                        Text("No Tasks Today :)").font(.system(size: 18, weight: .medium, design: .default))
                }
                    
                }
                
            }.padding(.top, 25).padding(.bottom,20)
        }
            
        }.padding(.horizontal, 25).onChange(of: currentMonth) { newValue in
            //updating month
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder func CardView(value: DateValue) -> some View {
        VStack(alignment: .leading){
            if value.day != -1 {
                
                if let task = tasks.tasks.first(where: { task in
                    let epochTime = TimeInterval(task.due_date)
                    let convertedDate = Date(timeIntervalSince1970: epochTime)
                    return isSameDay(date1: convertedDate, date2: value.date)
                }){
                    let epochTime = TimeInterval(task.due_date)
                    let convertedDate = Date(timeIntervalSince1970: epochTime)
                    Text("\(value.day)")
                        .font(.title3.weight(.medium))
                        .foregroundColor(isSameDay(date1: convertedDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 2)
                    
                    
                    Circle().fill(isSameDay(date1: convertedDate, date2: currentDate) ? .white : Color(.sRGB, red: 0.44, green: 0.6, blue: 0.92, opacity: 1.0)).frame(width: 8, height: 8).padding(.leading, 20)
                } else{
                    
                Text("\(value.day)")
                    .font(.title3.weight(.medium))
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                    .frame(maxWidth: .infinity)
    
                    
                    
                    
                Spacer()
            }
            }}.padding(.vertical,2).frame(height: 50, alignment: .top)
    }
    
    //Checking Dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    //get year and month
    func extraData() -> [String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        //get current month data
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    func extractDate () -> [DateValue]{
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            //get day
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

extension Date{
    
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // get start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
                
        // get date
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: (day-1), to: startDate)!
        }
    }
}
