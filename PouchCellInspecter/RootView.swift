import SwiftUI

struct RootView: View {

        @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false

        @AppStorage("appAppearance") private var appearance: AppAppearance = .system

    var body: some View {
        Group {
            if hasSeenOnboarding {
                HomeScreen()
            } else {
                OnboardingView()
            }
        }
                .preferredColorScheme(appearance.colorScheme)
    }
}

