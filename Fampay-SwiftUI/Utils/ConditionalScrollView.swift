//
//  ConditionalScrollView.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 29/06/22.
//

import SwiftUI


struct ConditionalScrollView<Content: View>: View {
    private var isVisible: Bool
    private var cardGroup: CardGroup
    private var builtContent: Content
    
    let width: CGFloat = UIScreen.main.bounds.width
    init(isVisible: Bool, cardGroup: CardGroup, content: () -> Content) {
        self.isVisible = isVisible
        self.cardGroup = cardGroup
        builtContent = content()
    }
    
    var body: some View {
        
        // check is_scrollable if multiple cards
    
        if cardGroup.cards.count > 1 &&  isVisible {
       
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        builtContent
                            
                    }
                    
                    .padding(.trailing, 15)
                }
               
            }
        
        else {
            HStack(spacing: 15) {
                builtContent
            }
            .padding(.trailing, 15)
        }
    }
}

//struct ConditionalScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConditionalScrollView()
//    }
//}
