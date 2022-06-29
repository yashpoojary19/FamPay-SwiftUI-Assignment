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
    @State private var showCardOptions = false
    
    @ObservedObject var userSettings = UserSettings()
    
    let width: CGFloat = UIScreen.main.bounds.width
    
    let tapOnLinkAction: (String) -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            
            ScrollView(.vertical, showsIndicators: false) {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    viewModel.getCards()
                    
                }
                
                ForEach(viewModel.cards, id: \.uniqueId) { cardGroup in
                    
                    
                    
                    if cardGroup.designType == DesignType.bigDisplayCard {
                        if userSettings.cardOptionState == CardOptionState.none.rawValue  {
                            ConditionalScrollView(isVisible: cardGroup.isScrollable, cardGroup: cardGroup) {
                                
                                
                                ForEach(cardGroup.cards) { card in
                                    
                                    HC3(card: card)
                                       
                                }
                                
                                
                                
                                
                            }
                        }
                        
                    } else if cardGroup.designType == DesignType.smallCardWithArrow {
                        
                        
                        ConditionalScrollView(isVisible: cardGroup.isScrollable, cardGroup: cardGroup) {
                            ForEach(cardGroup.cards) { card in
                                HC6(card: card)
                            }
                        }
                        
                        
                    } else if cardGroup.designType == DesignType.imageCard {
                        
                        ConditionalScrollView(isVisible: cardGroup.isScrollable, cardGroup: cardGroup) {
                            ForEach(cardGroup.cards) { card in
                                HC5(card: card)
                            }
                        }
                        
                    } else if cardGroup.designType == DesignType.dynamicWidthCard {
                        
                        HStack {
                            ForEach(cardGroup.cards) { card in
                                HC9(card: card)
                            }
                            .frame(height: CGFloat(cardGroup.height ?? 78))
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.trailing, 15)
                        
                    } else if cardGroup.designType == DesignType.smallDisplayCard {
                        
                        ConditionalScrollView(isVisible: cardGroup.isScrollable, cardGroup: cardGroup) {
                            ForEach(cardGroup.cards) { card in
                                HC1(card: card)
                            }
                        }
                        
                    }
                    
                }
            }
            
        }
        .onDisappear {
            if userSettings.cardOptionState == CardOptionState.remindLater.rawValue {
                userSettings.cardOptionState = CardOptionState.none.rawValue
            }
        }
        //            .frame(maxWidth: .infinity)
        .padding(.leading, 15)
        .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
    }
    
    
    
    
    func HC3(card: Card) -> some View {
        
        ZStack {
            
            Color.white.clipShape(RoundedRectangle(cornerRadius: 12))
            
            ZStack(alignment: .leading) {
                
                cardOptionsView()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.5)) {
                            showCardOptions = false
                        }
                        
                    }
                
                
                
                //
                
                ZStack(alignment: .bottom) {
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
                            
                        }) {
                            Text(card.cta?.first?.text ?? "Action")
                                .font(Font.custom("Roboto-Medium", size: 14))
                                .foregroundColor(Color(hex: card.cta?.first?.textColor ?? "#FFFFFF"))
                                .padding()
                                .padding(.horizontal)
                        }
                        .background(Color(hex: card.cta?.first?.bgColor ?? "#000000"))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .offset(x: showCardOptions ? (width / 3) : 0, y: 0)
            }
            
        }
        .clipped()
        .onTapGesture() {
            
            if showCardOptions {
                withAnimation(.easeIn(duration: 0.5)) {
                    showCardOptions = false
                }
            } else {
                tapOnLinkAction(card.url ?? "https://fampay.in/")
            }

        }
        
        .onLongPressGesture {
            withAnimation {
                showCardOptions = true
            }
            
        }
        .frame(width: width - 20)
        .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 1), contentMode: .fill)
        .contentShape(Rectangle())
       
        
    }
    
    func HC5(card: Card) -> some View {
        return WebImage(url: URL(string: card.bgImage?.imageURL ?? ""))
            .resizable()
            .placeholder {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(hex: card.bgColor ?? "#FFF00"))
                
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 1), contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture() {
                tapOnLinkAction(card.url ?? "https://fampay.in/")
            }
            .frame(width: width - 20)
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
                            .foregroundColor(.white)
                    }
                    .indicator(.activity)
                    .frame(width: 30, height: 30)
                    .scaledToFit()
                
                Text(card.formattedDescription?.text ?? "")
                    .font(Font.custom("Roboto-Medium", size: 14))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .contentShape( Rectangle() )
            .onTapGesture() {
                tapOnLinkAction(card.url ?? "https://fampay.in/")
                
            }
            
        }
    }
    
    func HC9(card: Card) -> some View {
        
        return  HStack(spacing: 15) {
            WebImage(url: URL(string: card.bgImage?.imageURL ?? ""))
                .resizable()
                .placeholder {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(hex: "#FFFFFF"))
                    
                }
                .onTapGesture {
                    tapOnLinkAction(card.url ?? "https://fampay.in/")
                }
                .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 1), contentMode: .fit)
      
            
        }
    }
    
    
    func HC1(card: Card) -> some View {
        
        return  HStack(spacing: 15) {
            
            ZStack {
                
                Color(hex: card.bgColor ?? "#FFFFFF").clipShape(RoundedRectangle(cornerRadius: 12))
                
                
                HStack {
                    WebImage(url: URL(string: card.icon?.imageURL ?? ""))
                        .resizable()
                        .placeholder {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color(hex: card.bgColor ?? "#FFFFFF"))
                            
                        }
                        .frame(height: 36)
                        .aspectRatio(CGFloat(card.icon?.aspectRatio ?? 1), contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Text((card.formattedTitle?.text) ?? "")
                        .font(Font.custom("Roboto-Medium", size: 14))
                }
                .padding()
            }
            .onTapGesture {
                tapOnLinkAction(card.url ?? "https://fampay.in/")
            }
            .frame(width: width * 0.45)
            
            
        }
        
        
    }
    
    func cardOptionsView() -> some View {
        return ZStack {
            
            
            VStack {
                
                VStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            
                            userSettings.cardOptionState = CardOptionState.remindLater.rawValue
                        }
                        print(userSettings.cardOptionState)
                    }) {
                        
                        Image("bellIcon")
                    }
                    Text("remind later")
                        .font(Font.custom("Roboto-Regular", size: 10))
                }
                .padding()
                .background(Color("iconBackgroundColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 37)
                
                VStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            userSettings.cardOptionState = CardOptionState.dismissNow.rawValue
                        }
                        
                        print(userSettings.cardOptionState)
                    }) {
                        Image("dismissIcon")
                        
                    }
                    Text("dismiss now")
                        .font(Font.custom("Roboto-Regular", size: 10))
                }
                .padding()
                .background(Color("iconBackgroundColor"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            }
        
        }
        .frame(width: width / 3)
        
        
    }
    
}

//struct CardGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardGroupView()
//    }
//}




