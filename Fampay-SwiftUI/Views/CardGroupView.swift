//
//  CardGroupView.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 28/06/22.
//

import SwiftUI

struct CardGroupView: View {
    
    @StateObject var viewModel = DataViewModel()
    
    var body: some View {
        List {
            
            ForEach(viewModel.cards) { cardGroup in
                
                VStack {
                    ForEach(cardGroup.cards) { card in
                        Text(card.formattedTitle?.text ?? "")
                        Text(cardGroup.designType)
                }
           
                    
                    
                }
              
                    
                }
            }
            
            

    }
}

struct CardGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CardGroupView()
    }
}
