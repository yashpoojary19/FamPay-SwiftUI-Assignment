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
            
            ScrollView(.vertical) {
                
                
                ForEach(viewModel.cards, id: \.uniqueId) { cardGroup in
                    
                    
                    ForEach(cardGroup.cards) { card in

                        
                        if cardGroup.designType == "HC3" {
                            ZStack(alignment: .bottom) {
                                WebImage(url: URL(string: card.bgImage?.imageURL ?? ""))
                                    .resizable()
                                    .placeholder {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(maxWidth: .infinity)
                                            .foregroundColor(Color(hex: card.bgColor ?? "#FFF00"))
                                        
                                    }
                                    .indicator(.activity)
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 1), contentMode: .fit)
                                
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
                                .padding(.horizontal)
                                
                                
                                
                            }
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        if cardGroup.designType == "HC6" {
                            
                            ZStack {
                                
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
                                .padding()
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
                        
                        
                        if cardGroup.designType == "HC5" {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                ForEach(cardGroup.cards) { card in
                         
                                    WebImage(url: URL(string: card.bgImage?.imageURL ?? ""))
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
                               
                            }
                                
                            }
                            
                        }
                    
                    
                    if cardGroup.designType == "HC9" {
                  
                            HStack(spacing: 15) {
                            ForEach(cardGroup.cards) { card in
                     
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
                            }
                           
                        }
                        
                        
                    }
                        
                  
                    if cardGroup.designType == "HC1"  {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                            ForEach(cardGroup.cards) { card in
                                
                                
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
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        .padding(.horizontal, 15)
        .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
    }
    
}

struct CardGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CardGroupView()
    }
}
