import SwiftUI


struct SpeakView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: CardViewModel
    @Binding var path: [ViewType]
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            TextField("Enter a sentence to be spoken", text: $viewModel.currentSentence)
                .font(.title3)
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
                        .foregroundColor(.white)
                    Image(systemName: "speaker.wave.2")
                        .font(.system(.title3))
                        .foregroundColor(.white)
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(Color(red: 26/255, green: 26/255, blue: 46/255))
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
                        .font(.system(size: 25, weight: .bold))
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
                            .font(.title3)
                            .foregroundStyle(.black)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 25, weight: .bold))
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

