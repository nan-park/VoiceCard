import SwiftUI

struct EditCardView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: CardViewModel
    @Binding var path: [ViewType]
    
    @State private var showEmojiPicker: Bool = false
    @State private var showToast: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        if let card = viewModel.selectedCardId.flatMap({ viewModel.cards[$0] }) {
            ZStack {
                // area outside the emojiPicker
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if showEmojiPicker {
                            showEmojiPicker = false
                        }
                    }
                
                // main stack
                VStack {
                    Button {
                        showEmojiPicker.toggle()
                        isTextFieldFocused = false
                    } label: {
                        // MARK: need to manage the flexible size later(+AddCardView)
                        Text(viewModel.currentEmoji)
                            .font(.system(size: 50))
                            .frame(width: 80, height: 80)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    TextField("Enter the sentence", text: $viewModel.currentSentence)
                        .padding()
                        .background(.gray.opacity(0.1))
                        .cornerRadius(8)
                        .focused($isTextFieldFocused)
                        .padding(20)
                        .onTapGesture {
                            showEmojiPicker = false
                        }
                    
                    Spacer()
                }
                
                // emojiPicker stack
                VStack {
                    Spacer()
                    
                    if showEmojiPicker {
                        EmojiPickerView(selectedEmoji: $viewModel.currentEmoji, showEmojiPicker: $showEmojiPicker)
                    }
                }
                
                // toast stack
                if showToast {
                    VStack {
                        Spacer()
                        
                        Text("Please enter a non-empty sentence!")
                            .padding()
                            .background(Color(red: 26/255, green: 26/255, blue: 46/255))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .padding()
                        
                    }
                }
            }
            .navigationBarTitle("Edit the Card", displayMode: .inline)
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
                        viewModel.deleteCard(id: card.id)
                        path.removeAll()
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                // MARK: (DESIGN CHECK) icon button size too big
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if !viewModel.currentSentence.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            viewModel.updateCard(id: card.id, sentence: viewModel.currentSentence, emoji: viewModel.currentEmoji)
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
}
