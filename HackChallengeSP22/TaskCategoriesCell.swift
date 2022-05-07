//
//  TaskCategoriesCell.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/5/22.
//

import SwiftUI

struct TaskCategoriesCell: View {
    @Binding var filterIsSelected: Bool
    static let id = "TaskCategoriesCellId"
    let category: taskCategory
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(filterIsSelected ? Color(.sRGB, red: 1.0, green: 0.88, blue: 0.77, opacity: 1) : .white)
                .frame(height: 25).frame(maxWidth: .infinity).foregroundColor(.yellow)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.sRGB, red: 1.0, green: 0.73, blue: 0.59, opacity: 1), lineWidth: 2)
                .frame(height: 25).frame(maxWidth: .infinity).foregroundColor(.yellow)
            
            Text(category.description)
                .font(.body)
                .foregroundColor(.black)
                .frame(height: 25)
        }
    }
}
