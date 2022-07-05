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
    @Published var userSettings = UserSettings()
    var cancellables = Set<AnyCancellable>()
    
    
    // Alert settings
    @Published var shouldShowAlert = false
    @Published var alertMessage = ""
    
    
    // To show card dismiss options for HC3
    @Published var showCardOptions = false
    
    init() {
        getCards()
    }
    
    func getCards() {
        guard let url = URL(string: "https://run.mocky.io/v3/04a04703-5557-4c84-a127-8c55335bb3b4") else {
            return
        }
        
        // automatcally on background thread
        
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
                    self.shouldShowAlert = true
                    self.alertMessage = error.localizedDescription
                    
                }
            } receiveValue: { [weak self] (returnedCardData) in
                // we don't want to keep it in memory
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


