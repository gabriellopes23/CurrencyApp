import SwiftUI

struct MainAppView: View {
    @State private var isFirstLaunch = UserDefaults.standard.isFirstLaunch

    var body: some View {
        if isFirstLaunch {
            WelcomeView()
        } else {
            TabMainView(name: .constant(UserDefaults.standard.name), nickname: .constant(UserDefaults.standard.nickname), selectedImage: .constant(UserDefaults.standard.selectedImage), customImage: .constant(UserDefaults.standard.customImageData.flatMap { UIImage(data: $0) }), showPhotoPicker: .constant(false))
        }
    }
}

#Preview {
    MainAppView()
}
