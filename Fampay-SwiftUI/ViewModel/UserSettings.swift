//
//  UserSettings.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 29/06/22.
//

import Foundation
import Combine




class UserSettings: ObservableObject {
    @Published var cardOptionState: String {
        didSet {
            UserDefaults.standard.set(cardOptionState, forKey: "cardOptionSettings")
        }
    }
    
    
    init() {
        self.cardOptionState = UserDefaults.standard.object(forKey: "cardOptionSettings") as? String ?? "none"
        
        // Setting state to none for the card should be shown on the next app start
        if cardOptionState == CardOptionState.remindLater.rawValue {
            cardOptionState = CardOptionState.none.rawValue
        }
        
        print("This is the state", cardOptionState)
    }
}
