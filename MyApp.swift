import SwiftUI

@main
struct MyApp: App {
    @StateObject var viewModel = CardViewModel()    // public var viewModel -> manage by @EnvironmentObject
    var body: some Scene {
        WindowGroup {
            CardListView()
                .environmentObject(viewModel)
        }
    }
}
