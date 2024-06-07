import SwiftUI

struct MainAppView: View {
    @State private var isFirstLaunch = UserSettings.shared.isFirstLaunch
    let settingsManager = SettingsManager()

    var body: some View {
        if isFirstLaunch {
            WelcomeView(settingsManager: settingsManager)
                .onDisappear {
                    UserSettings.shared.isFirstLaunch = false
                }
        } else {
            TabMainView(settingsManager: settingsManager)
        }
    }
}

#Preview {
    MainAppView()
}
