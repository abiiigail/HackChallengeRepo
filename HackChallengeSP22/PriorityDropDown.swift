//
//  PriorityDropDown.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/6/22.
//

import SwiftUI

struct PriorityDropDown: View {
    @State var expand = false
    @Binding var isHigh: Bool
    @Binding var isMedium: Bool
    @Binding var isLow: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text(isHigh ? "High" : isMedium ? "Medium" : "Low").fontWeight(.heavy)
                
                Image(systemName: expand ? "chevron.up": "chevron.down").resizable().frame(width: 13, height: 6)
            }.onTapGesture {
                self.expand.toggle()
            }
            
            if expand{
            Button {
                self.isHigh = true
                self.isMedium = false
                self.isLow = false
                self.expand.toggle()
                } label: {
                    Text("High").padding()
                }.foregroundColor(.black)

           
            
            Button {
                self.isHigh = false
                self.isMedium = true
                self.isLow = false
                self.expand.toggle()
            } label: {
                Text("Medium").padding()
            }.foregroundColor(.black)
            
            Button {
                self.isHigh = false
                self.isMedium = false
                self.isLow = true
                self.expand.toggle()
            } label: {
                Text("Low").padding()
            }.foregroundColor(.black)
            }
            
            

        }
            .padding()
            .background(isHigh ? Color(.init(red: 0.98, green: 0.72, blue: 0.72, alpha: 1)) : isMedium ? Color(.init(red: 1.0, green: 0.92, blue: 0.49, alpha: 1)) : Color(.init(red: 0.68, green: 0.92, blue: 0.62, alpha: 1))).cornerRadius(20).animation(.spring())
    }
}

//struct PriorityDropDown_Previews: PreviewProvider {
//    static var previews: some View {
//        PriorityDropDown()
//    }
//}
