import SwiftUI

struct AddCardView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: CardViewModel
    @Binding var path: [ViewType]
    
    @State private var emoji = "❓"
    @State private var showEmojiPicker = false
    @State private var showToast: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        ZStack {
            // main stack
            VStack {
                Button {
                    showEmojiPicker.toggle()
                } label: {
                    Text(emoji)
                        .font(.system(size: 50))
                        .frame(width: 80, height: 80)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding()
                
                // MARK: (CHECK) When the keyboard and emojiPicker are opened at the same time, what happens?
                TextField("Enter the sentence", text: $viewModel.currentSentence)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                    .focused($isTextFieldFocused)
                    .padding(20)
                
                Spacer()
            }
            
            // emojiPicker stack
            VStack {
                Spacer()
                
                if showEmojiPicker {
                    EmojiPickerView(selectedEmoji: $emoji, showEmojiPicker: $showEmojiPicker)
                }
            }
            
            // toast stack
            if showToast {
                VStack {
                    Spacer()
                    Text("Please enter a non-empty sentence!")
                        .padding()
                        .background(Color.gray.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding()

                }
            }
        }
        .navigationBarTitle("Add New Card", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // MARK: before removing, check if sentence is empty, do addCard(), and finally path.removeAll()
                    if !viewModel.currentSentence.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        viewModel.addCard(sentence: viewModel.currentSentence, emoji: emoji)
                        path.removeAll()
                    } else {
                        showToast = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            showToast = false
                        }
                    }
                    print(viewModel.cards)
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
            }
        }
    }
    
}
