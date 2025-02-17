import SwiftUI

struct Card: Identifiable, Codable {
    let id: UUID
    var emoji: String
    var sentence: String
    let createdAt: Date
    var usageCount: Int
}
