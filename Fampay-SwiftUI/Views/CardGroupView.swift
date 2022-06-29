//
//  CardGroupView.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 28/06/22.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI



struct CardGroupView: View {
    
    @StateObject var viewModel = DataViewModel()
    
    let width: CGFloat = UIScreen.main.bounds.width
    
    
    
    var body: some View {
        VStack(spacing: 15) {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                                    viewModel.getCards()
                               
                                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                                         HStack(spacing: 15) {
                                             ForEach(mergeArray(cardGroup: viewModel.cards, designType: "HC3")) { card in
                                                 HC3(card: card)
                                             }
             
             
                                         }
             
                                     }
                
            
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(mergeArray(cardGroup: viewModel.cards, designType: "HC6")) { card in
                            HC6(card: card)
                        }
                        
                        
                    }
                    
                }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(mergeArray(cardGroup: viewModel.cards, designType: "HC5")) { card in
                            HC5(card: card)
                        }
                        
                        
                    }
                    
                }
                
                HStack(spacing: 15) {
                    ForEach(mergeArray(cardGroup: viewModel.cards, designType: "HC9")) { card in
                        HC9(card: card)
                    }
                    
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(mergeArray(cardGroup: viewModel.cards, designType: "HC1")) { card in
                            HC1(card: card)
                        }
                        
                        
                    }
                }
                
                
            }
            }
//            .frame(maxWidth: .infinity)
            .padding(.horizontal, 15)
            .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
        }
        
        
        
        
        func HC3(card: Card) -> some View {
            return ZStack(alignment: .bottom) {
                WebImage(url: URL(string: card.bgImage?.imageURL ?? ""))
                    .resizable()
                    .placeholder {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(hex: card.bgColor ?? "#FFF00"))
                        
                    }
                    .indicator(.activity)
                   
                VStack(alignment: .leading, spacing: 30) {
                    //
                    Text((card.formattedTitle?.text) ?? "")
                        .font(Font.custom("Roboto-Medium", size: 30))
                        .lineLimit(2)

                    Text((card.formattedDescription?.text) ?? "")
                        .font(Font.custom("Roboto-Regular", size: 12))
                        .lineLimit(2)



                    Button(action: {
                        //
                    }) {
                        Text("Add")
                            .font(Font.custom("Roboto-Medium", size: 14))
                            .foregroundColor(Color.white)
                            .padding()
                            .padding(.horizontal)
                    }
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
               
                
                .padding(.bottom, 20)
                
//                .padding(.horizontal)
                

               
                
                
                
            }
    
            .frame(height: 350)
            .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 1), contentMode: .fit)
            
         
    
           
            
        }
        
        func HC5(card: Card) -> some View {
            return WebImage(url: URL(string: card.bgImage?.imageURL ?? ""))
                .resizable()
                .placeholder {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(hex: card.bgColor ?? "#FFF00"))
                    
                }
                .frame(height: 129)
                .frame(maxWidth: .infinity)
                .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 1), contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        
        
        func HC6(card: Card) -> some View {
            return ZStack {
                
                Color.white.clipShape(RoundedRectangle(cornerRadius: 12))
                
                HStack {
                    WebImage(url: URL(string: card.icon?.imageURL ?? ""))
                        .resizable()
                        .placeholder {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
                        }
                        .indicator(.activity)
                        .frame(width: 30, height: 30)
                    //                                                            .frame(maxWidth: .infinity)
                        .scaledToFit()
                    
                    Text(card.formattedDescription?.text ?? "")
                        .font(Font.custom("Roboto-Medium", size: 14))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                
            }
        }
        
        func HC9(card: Card) -> some View {
            
            return  HStack(spacing: 15) {
                //                ForEach(cardGroup.cards) { card in
                
                WebImage(url: URL(string: card.bgImage?.imageURL ?? ""))
                    .resizable()
                    .placeholder {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(hex: card.bgColor ?? "#FFF00"))
                        
                    }
                //                                    .frame(height: CGFloat(card.height ?? 78))
                    .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 1), contentMode: .fit)
                
                //                                    .frame(height: CGFloat(cardGroup?.height ?? 78))
                ////
                
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                //                }
                
            }
        }
        
        
        func HC1(card: Card) -> some View {
            
            return  HStack(spacing: 15) {
                //                            ForEach(cardGroup.cards) { card in
                
                ZStack {
                    
                    Color(hex: card.bgColor ?? "F7F6F3").clipShape(RoundedRectangle(cornerRadius: 12))

                    HStack {
                        WebImage(url: URL(string: card.icon?.imageURL ?? ""))
                            .resizable()
                            .placeholder {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color(hex: card.bgColor ?? "#FFF00"))
                                
                            }
                            .frame(height: 36)
                            .frame(maxWidth: .infinity)
                            .aspectRatio(CGFloat(card.icon?.aspectRatio ?? 1), contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Text((card.formattedTitle?.text) ?? "")
                            .font(Font.custom("Roboto-Medium", size: 14))
                    }
                    .padding()
                }
                
                
                
                
                
                
            }
            
        }
    
    
    func mergeArray(cardGroup: [CardGroup], designType: String) -> [Card] {
        var cards: [Card] = []
        
        for cardGroup in cardGroup {
            if cardGroup.designType == designType {
                cards.append(contentsOf: cardGroup.cards)
            }
        }
        
        return cards
        
    }
    
    
    
}

struct CardGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CardGroupView()
    }
}


struct ConditionalScrollView<Content: View>: View {
    @Binding private var isVisible: Bool
    private var builtContent: Content

    init(isVisible: Binding<Bool>, content: () -> Content) {
        self._isVisible = isVisible
        builtContent = content()
    }

    var body: some View {
        if isVisible {
            ScrollView(.horizontal, showsIndicators: false) { builtContent }
        } else {
            builtContent
        }
    }
}
