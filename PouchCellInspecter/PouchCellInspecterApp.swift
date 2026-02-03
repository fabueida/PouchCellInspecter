import SwiftUI

/*
 NOTE:
 Changed this to just the home screen for the sake of the demo.
 */

@main
struct PouchCellInspecterApp: App {
//    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some Scene {
        WindowGroup {
            HomeScreen()
            
            /*
            if hasSeenOnboarding {
                HomeScreen()
            } else {
                Intro()
            }
            */
        }
    }
}
