import SwiftUI

struct VoiceCardView: View {
    let id: UUID
    @EnvironmentObject var viewModel: CardViewModel
    var body: some View {
        if let card = viewModel.cards[id] {
            Button {
                viewModel.speak(card.sentence)
            } label : {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 2, y: 2)
                        .frame(width: (UIScreen.main.bounds.width - 60) / 2, height: 150)
                    
                    Text(card.emoji)
                        .font(.system(size: 80))
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .opacity(0.4)
                    
                    VStack(alignment: .leading) {
                        Text(card.sentence)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .lineLimit(4)
                            .truncationMode(.tail)
                            .allowsTightening(true)
                            .padding()
                    }
                    .padding()
                    
                }
            }
        }
    }
}
