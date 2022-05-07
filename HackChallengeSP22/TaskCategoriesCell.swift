//
//  TaskCategoriesCell.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/5/22.
//

import SwiftUI

struct TaskCategoriesCell: View {
    @State var filterIsSelected = false
    static let id = "TaskCategoriesCellId"
    let category: taskCategory
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .stroke(.red)
                .foregroundColor(.yellow)
                .frame(height: 25).frame(maxWidth: .infinity)
            Text(category.description)
                .font(.body)
                .foregroundColor(.black)
                .frame(height: 25)
        }
    }
}
