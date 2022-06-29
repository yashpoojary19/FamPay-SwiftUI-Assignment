//
//  DataModel.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 28/06/22.
//

import Foundation



//MARK: - CardData
struct CardData: Codable {
    let cardGroups: [CardGroup]
    
    enum CodingKeys: String, CodingKey {
            case cardGroups = "card_groups"
        }
}

//MARK: - CardGroup
struct CardGroup: Codable, Identifiable {
    let uniqueId = UUID()
    let id: Int
    let name: String
    let designType: DesignType
    let cards: [Card]
    let isScrollable: Bool
    let height: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case designType = "design_type"
        case cards
        case isScrollable = "is_scrollable"
        case height
    }
}

//MARK: - Card
struct Card: Codable, Identifiable {
    let id = UUID()
    let name: String?
    let title: String?
    let formattedTitle: FormattedTitle?
    let cardDescription: String?
    let formattedDescription: FormattedDescription?
    let icon: BgImage?
    let url: String?
    let bgImage: BgImage?
    let bgColor: String?
    let cta: [CTA]?
    
    enum CodingKeys: String, CodingKey {
          case name, title
          case formattedTitle = "formatted_title"
          case cardDescription = "description"
          case formattedDescription = "formatted_description"
          case icon, url
          case bgImage = "bg_image"
          case bgColor = "bg_color"
          case cta
      }
}

//MARK: - CTA
struct CTA: Codable, Identifiable {
    let id = UUID()
    let text, bgColor, textColor: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case text
        case bgColor = "bg_color"
        case textColor = "text_color"
        case url
    }
}

//MARK: - BgImage
struct BgImage: Codable {
    let imageType: ImageType
    let imageURL: String?
    let aspectRatio: Double?

    enum CodingKeys: String, CodingKey {
        case imageType = "image_type"
        case imageURL = "image_url"
        case aspectRatio = "aspect_ratio"
    }
}

//MARK: - ImageType
enum ImageType: String, Codable {
    case ext = "ext"
    case asset = "asset"
}

//MARK: - Entity
struct Entity: Codable {
    let text, color: String
}

//MARK: - FormattedDescription
struct FormattedDescription: Codable {
    let text: String
    let entities: [Entity]
}

//MARK: - FormattedTitle
struct FormattedTitle: Codable {
    let text: String
    let entities: [Entity]
}

//MARK: - DesignType
enum DesignType: String, Codable {
    case smallDisplayCard = "HC1"
    case bigDisplayCard = "HC3"
    case imageCard = "HC5"
    case smallCardWithArrow = "HC6"
    case dynamicWidthCard = "HC9"
            
}

//MARK: - Card Option States
enum CardOptionState: String {
    case none = "none"
    case remindLater = "remindLater"
    case dismissNow = "dismissNow"
   
}
