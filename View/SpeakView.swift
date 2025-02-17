import SwiftUI


struct SpeakView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: CardViewModel
    @Binding var path: [ViewType]
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            TextField("Enter a sentence", text: $viewModel.currentSentence)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(8)
                .focused($isTextFieldFocused)
                .padding(.top, 20)
                .padding(.trailing, 10)
                .padding(.leading, 20)
            
            Button {
                viewModel.speak(viewModel.currentSentence)
                
                print("\(path)")
            } label: {
                HStack {
                    Text("Speak")
                        .foregroundStyle(.black)
                    Image(systemName: "speaker.wave.2")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding()
            }
            
            Spacer()
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    path.append(.addCardView)
                    print(path)
                } label: {
                    HStack {
                        Text("Register")
                            .foregroundStyle(.black)
                        Image(systemName: "chevron.right")
                            .font(.system(size:20, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isTextFieldFocused = true
            }
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}

