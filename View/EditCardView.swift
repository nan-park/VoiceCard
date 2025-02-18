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
                // main stack
                
            }
        }
    }
}
