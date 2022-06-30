//
//  DataViewModel.swift
//  Fampay-SwiftUI
//
//  Created by Yash Poojary on 28/06/22.
//

import Foundation
import Combine


class DataViewModel: ObservableObject {
    
    @Published var cards: [CardGroup] = [CardGroup]()
    var cancellables = Set<AnyCancellable>()
    
    
    @Published var showCardOptions = false
    
    init() {
        getCards()
    }
    
    func getCards() {
        guard let url = URL(string: "https://run.mocky.io/v3/fefcfbeb-5c12-4722-94ad-b8f92caad1ad") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: CardData.self, decoder: JSONDecoder())
        
            .sink { (completion) in
                switch completion {
                case .finished:
    
                    print("Finished")
                case .failure(let error):
                    print("There was an error. \(error)")
                    // error handling
                }
            } receiveValue: { [weak self] (returnedCardData) in
                    
                
                self?.cards = returnedCardData.cardGroups
                
            }
            .store(in: &cancellables)
    }

    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
        
    }
    
}

