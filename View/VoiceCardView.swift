import SwiftUI

struct VoiceCardView: View {
    let id: UUID
    let width = (UIScreen.main.bounds.width - 60) / 2
    @EnvironmentObject var viewModel: CardViewModel
    var body: some View {
        if let card = viewModel.cards[id] {
            Button {
                viewModel.incrementUsageCount(id)
                viewModel.speak(card.sentence)
            } label : {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 2, y: 2)
                        .frame(width: width, height: width * 0.8)
                    
                    Text(card.emoji)
                        .font(.system(size: 80))
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .opacity(0.4)
                    
                    Text(card.sentence)
                        .font(.callout)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                        .truncationMode(.tail)
                        .allowsTightening(true)
                        .padding()
                    
                }
            }
        }
    }
}
