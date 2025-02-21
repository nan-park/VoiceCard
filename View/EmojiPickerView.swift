import SwiftUI

struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    @Binding var showEmojiPicker: Bool

    let emojis: [String] = {
        let ranges: [ClosedRange<Int>] = [
            0x1F600...0x1F64F,
            0x1F300...0x1F5FF,
            0x1F680...0x1F6FF,
            0x1F900...0x1F9FF,
        ]
        return ranges.flatMap { range in
            range.compactMap { UnicodeScalar($0).map { String($0) } }
        }
    }()

    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 8)

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 30))], spacing: 6) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.system(size: 30))
                            .frame(width: 45, height: 45)
                            .background(selectedEmoji == emoji ? Color.blue.opacity(0.3) : Color.clear)
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedEmoji = emoji
                                showEmojiPicker = false
                            }
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height * 0.4)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        .edgesIgnoringSafeArea(.bottom)
        .transition(.move(edge: .bottom))
        .shadow(radius: 10)
    }
}
