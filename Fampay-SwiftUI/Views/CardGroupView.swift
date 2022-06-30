//
//  CardGroupView.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 28/06/22.
//

import SwiftUI
import SDWebImageSwiftUI



struct CardGroupView: View {
    
    @ObservedObject var viewModel: DataViewModel
    
    
    @ObservedObject var userSettings = UserSettings()
    
    let width: CGFloat = UIScreen.main.bounds.width
    
    let tapOnLinkAction: (String) -> Void
    
    let heightPadding: CGFloat = UIScreen.main.bounds.height > 670 ? 0 : 10
    
    var body: some View {
        VStack(spacing: 15) {
            
            
            
            ScrollView(.vertical, showsIndicators: false) {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    viewModel.getCards()
                    
                }
                
                if !viewModel.cards.isEmpty {
                    
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
                            
                            ConditionalScrollView(isVisible: cardGroup.isScrollable, cardGroup: cardGroup) {
                                ForEach(cardGroup.cards) { card in
                                    HC9(card: card)
                                    
                                }
                            }
                            
                        } else if cardGroup.designType == DesignType.smallDisplayCard {
                            
                            ConditionalScrollView(isVisible: cardGroup.isScrollable, cardGroup: cardGroup) {
                                ForEach(cardGroup.cards) { card in
                                    HC1(card: card)
                                }
                            }
                            
                        }
                        
                    }
                    .padding(.bottom, heightPadding)    // For smaller screen sizes
                }
                else {
                    
                    LoadingView()
                    
                }
            }
            
            
            
        }
        .padding(.leading, 15)
        .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
    }
    
    //    }
    
    
    
    // BIG_DISPLAY_CARD("HC3")
    func HC3(card: Card) -> some View {
        
        ZStack {
            
            Color.white.clipShape(RoundedRectangle(cornerRadius: 12))
            
            ZStack(alignment: .leading) {
                
                cardOptionsView()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.5)) {
                            viewModel.showCardOptions = false
                        }
                        
                    }
                
                
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
                        //                        Text((card.formattedTitle?.text ?? card.title) ?? "")
                        
                        
                        Text(card.formattedTitle?.getFormattedString() ?? "")
                            .foregroundColor(.white)
                            .font(Font.custom("Roboto-Medium", size: 30))
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                        //
                        //                        Text((replaceFormattedString(text:card.formattedTitle?.text, entities: card.formattedTitle?.entities) ?? card.title) ?? "")
                        //                            .foregroundColor(.white)
                        //                            .font(Font.custom("Roboto-Medium", size: 30))
                        //                            .lineLimit(2)
                        //                            .minimumScaleFactor(0.7)
                        
                        
                        //
                        
                        
                        //                        Text((card.formattedDescription?.text ?? card.title) ?? "")
                        
                        Text(card.formattedDescription?.getFormattedString() ?? "")
                            .foregroundColor(.white)
                            .font(Font.custom("Roboto-Regular", size: 12))
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                        
                        Button(action: {
                            
                            tapOnLinkAction(card.cta?.first?.url ?? "https://fampay.in/")
                            
                            
                        }) {
                            Text(card.cta?.first?.text ?? "Action")
                                .font(Font.custom("Roboto-Medium", size: 14))
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
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
                .offset(x: viewModel.showCardOptions ? (width / 3) : 0, y: 0)
            }
            
        }
        .clipped()
        .onTapGesture() {
            
            if viewModel.showCardOptions {
                withAnimation(.easeIn(duration: 0.5)) {
                    viewModel.showCardOptions = false
                }
            } else {
                tapOnLinkAction(card.url ?? "https://fampay.in/")
            }
            
        }
        
        .onLongPressGesture {
            withAnimation {
                viewModel.showCardOptions = true
            }
            
        }
        .frame(width: width - 20)
        .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 1), contentMode: .fill)
        
        
    }
    
    // IMAGE_CARD("HC5")
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
    
    //SMALL_CARD_WITH_ARROW("HC6")
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
                
                
                VStack(alignment: .leading) {
                    
                    
                    Text(card.formattedTitle?.getFormattedString() ?? "")
                        .font(Font.custom("Roboto-Medium", size: 14))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    Text(card.formattedDescription?.getFormattedString() ?? "")
                        .font(Font.custom("Roboto-Regular", size: 14))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                }
                
                
                
                
                
                Spacer()
                
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .contentShape( Rectangle() )
            .onTapGesture() {
                tapOnLinkAction(card.url ?? "https://fampay.in/")
                
            }
            
        }
    }
    
    // DYNAMIC_WIDTH_CARD("HC9")
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
                .aspectRatio(contentMode: .fit)
            
            
            
        }
    }
    
    // SMALL_DISPLAY_CARD("HC1")
    func HC1(card: Card) -> some View {
        
        return  HStack(spacing: 15) {
            
            ZStack(alignment: .center) {
                
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
                    
                    
                    Text(card.formattedTitle?.getFormattedString() ?? "")
                        .font(Font.custom("Roboto-Medium", size: 14))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    
                }
                .padding()
            }
            .onTapGesture {
                tapOnLinkAction(card.url ?? "https://fampay.in/")
            }
            // This sets the component to take the full available size
            //            .frame(width: width * 0.45)
            
            
        }
        
        
    }
    
    
    // Options view for BIG_DISPLAY_CARD("HC3")
    func cardOptionsView() -> some View {
        return ZStack {
            
            
            VStack {
                
                DismissButton(imageName: "bellIcon", iconText: "remind later") {
                    userSettings.cardOptionState = CardOptionState.remindLater.rawValue
                }
                .padding(.bottom, 37)
                
                DismissButton(imageName: "dismissIcon", iconText: "dismiss now") {
                    userSettings.cardOptionState = CardOptionState.dismissNow.rawValue
                }
                
            }
            
        }
        .frame(width: width / 3)
        
    }
}



