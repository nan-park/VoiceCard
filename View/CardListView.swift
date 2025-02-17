import SwiftUI

struct CardListView: View {
    @EnvironmentObject var viewModel: CardViewModel
    @State var path: [ViewType] = []  // navigation path manager
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                OptionButtonsView()
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible())], spacing: 16) {
                        ForEach(Array(viewModel.sortedCards)) {card in
                            VoiceCardView(id: card.id)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                }
            }
            .navigationDestination(for: ViewType.self) { type in
                switch type {
                case .speakView:
                    SpeakView(path: $path)
                        .onAppear() {
                            viewModel.currentSentence = ""
                        }
                case .addCardView:
                    AddCardView(path: $path)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("VoiceCard")
                        .font(.system(size: 24, weight: .bold))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        path.append(.speakView)
                        print(path)
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
