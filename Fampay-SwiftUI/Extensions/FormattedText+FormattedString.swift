//
//  FormattedText+FormattedString.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 30/06/22.
//

import Foundation


extension FormattedText {
    func getFormattedString() -> String {
        if entities.isEmpty {
            return text
        } else {
            
            var finalString = text
            var entityIndex = 0
            while finalString.range(of: "{}") != nil {
                let rangeReplace = finalString.range(of: "{}")!
                
                let currentEntity = entities[entityIndex]
                
                finalString.replaceSubrange(rangeReplace, with: currentEntity.text)
                
                entityIndex += 1
            }
            
            return finalString
        }
    }
}
