import SwiftUI

struct OptionButtonsView: View {
    @EnvironmentObject var viewModel: CardViewModel
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            SortButton(option: .latest, title: "Latest")
            SortButton(option: .oldest, title: "Oldest")
            SortButton(option: .popular, title: "Popular")
            Spacer()
        }
    }
}

struct SortButton: View {
    @State var option: SortOption
    @State var title: String
    @EnvironmentObject var viewModel: CardViewModel
    var body: some View {
        Button {
            viewModel.sortOption = option
        } label: {
            Text(title)
                .font(.title2)
                .foregroundColor(viewModel.sortOption == option ? Color.white : Color.black)
                .padding(10)
                .background(viewModel.sortOption == option ? Color.black : Color.gray.opacity(0.1))
                .cornerRadius(10)
        }
        .padding(.top, 10)
    }
}
