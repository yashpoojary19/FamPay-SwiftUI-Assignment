//
//  LoadingView.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 30/06/22.
//

import SwiftUI

struct LoadingView: View {
    let height = UIScreen.main.bounds.height
    
    
    var body: some View {
        VStack {
            
            if #available(iOS 14.0, *) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                // Fallback for (iOS 13, *)
                ActivityIndicator(isAnimating: true)
                
            }
            
            Text("Loading your data...")
                .font(Font.custom("Roboto-Medium", size: 30))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            
            
        }
        .padding(.top, height/3)
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
