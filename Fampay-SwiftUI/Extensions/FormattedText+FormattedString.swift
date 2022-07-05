//
//  FormattedText+FormattedString.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 30/06/22.
//

import Foundation
import SwiftUI

// Returns a formatted string from entity
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
    
    @available(iOS 15, *)
    func getAttributedString() -> AttributedString {
        if entities.isEmpty {
            return AttributedString(text)
        } else {
            
            var finalString = AttributedString(text)
            var entityIndex = 0
            while finalString.range(of: "{}") != nil {
                let rangeReplace = finalString.range(of: "{}")!
                
                let currentEntity = entities[entityIndex]
                
                
                var attributes = AttributeContainer()
                attributes.foregroundColor =  Color(hex: currentEntity.color)
        
              
                finalString.mergeAttributes(attributes)
                finalString.replaceSubrange(rangeReplace, with: AttributedString(currentEntity.text))
            
                                
                entityIndex += 1
            }
            
            return finalString
        }
    }
    
    
    //text: "text": "Your {} looks {}!"
    
    func getString() {
        var textString = "Your {} looks {}!"
        
        
        
    }
    
    
    
}
