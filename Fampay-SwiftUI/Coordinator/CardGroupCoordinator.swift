//
//  CardGroupCoordinator.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 29/06/22.
//

import SwiftUI

struct CardGroupCoordinator: View {
    
    var body: some View {
        
        
        CardGroupView { url in
            UIApplication.shared.open(URL(string: url)!)
        }
    }
}

struct CardGroupCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CardGroupCoordinator()
    }
}

