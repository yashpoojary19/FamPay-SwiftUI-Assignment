//
//  CardGroupCoordinator.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 29/06/22.
//

import SwiftUI

struct CardGroupCoordinator: View {
    @StateObject var viewModel = DataViewModel()
    
    var body: some View {
        
        CardGroupView(viewModel: viewModel) { url in
            UIApplication.shared.open(URL(string: url)!)
        }
        .alert(isPresented: $viewModel.shouldShowAlert ) {
            
            Alert(title: Text("Something went wrong"), message: Text(viewModel.alertMessage), primaryButton: .default(Text("Try Again"), action: { viewModel.getCards()}), secondaryButton: .cancel())
        }
    }
}

struct CardGroupCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CardGroupCoordinator()
    }
}


