import SwiftUI

struct OnboardingView: View {

    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false

    var body: some View {
        VStack(spacing: 24) {

            Text("Welcome to Pouch Cell Inspector")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Use the camera to identify if your lithium ion battery is normal.")
                .multilineTextAlignment(.center)

            Text("Simply take a picture and it will give you information about your lithium ion battery. Tap continue to get started.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button {
                hasSeenOnboarding = true
            } label: {
                Text("Continue")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
        .padding()
    }
}

