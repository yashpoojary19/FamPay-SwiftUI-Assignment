//
//  DismissButton.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 30/06/22.
//

import SwiftUI


struct DismissButton: View {
    
    let imageName: String
    let iconText: String
    let action: () -> Void
    
    var body: some View {
        
        VStack {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                
                action()
            }
        }) {
            
            Image(imageName)
        }
        Text(iconText)
            .font(Font.custom("Roboto-Regular", size: 10))
            .lineLimit(1)
            .minimumScaleFactor(0.7)
    }
    .padding()
    .background(Color("iconBackgroundColor"))
    .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}

//
//struct DismissButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DismissButton()
//    }
//}
