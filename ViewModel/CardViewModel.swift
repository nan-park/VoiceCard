import SwiftUI
import Foundation
import AVFoundation

class CardViewModel: ObservableObject {
    @Published var cards: [UUID: Card] = [:]
    @Published var currentSentence: String = ""
    @Published var selectedCardId: UUID?
    @Published var currentEmoji: String = ""
    @Published var sortOption: SortOption = .latest
    
    private let key = "savedCards"
    
    private var synthesizer = AVSpeechSynthesizer()
    
    var sortedCards: [Card] {
        switch sortOption {
        case .latest:
            return cards.values.sorted { $0.createdAt > $1.createdAt }
        case .oldest:
            return cards.values.sorted { $0.createdAt < $1.createdAt }
        case .popular:
            return cards.values.sorted { $0.usageCount > $1.usageCount }
        }
    }
    
    init() {
        loadCards()
    }
    
    private func loadCards() {
        
    }
    
    private func saveCards() {
        
    }
    
    func addCard(sentence: String, emoji: String) {
        let newCard: Card = Card(id: UUID(), emoji: emoji, sentence: sentence, createdAt: Date(), usageCount: 0)
        cards[newCard.id] = newCard
        print("new card: \(newCard)")
        saveCards()
    }
    
    func updateCard(id: UUID, sentence: String, emoji: String) {
        
    }
    
    func deleteCard(id: UUID) {
        
    }
    
    func incrementUsageCount(_ id: UUID) {
        if var card = cards[id] {
            card.usageCount += 1
            cards[id] = card
            saveCards()
        } else {
            print("There is no card of this id: \(id)")
        }
    }
    
    // voice card
    func speak(_ id: UUID) {
        guard let card = cards[id] else {
            print("There is no card of this id: \(id)")
            return
        }
        speak(card.sentence)
    }
    
    // just sentence
    func speak(_ sentence: String) {
        print("speak sentence in English: \(sentence)")
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5    // reading speed
        synthesizer.speak(utterance)
    }
}

