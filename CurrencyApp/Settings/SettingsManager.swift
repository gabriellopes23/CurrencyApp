import SwiftUI

class SettingsManager: ObservableObject {
    @Published var name: String
    @Published var nickname: String
    @Published var selectedImage: String
    @Published var customImage: UIImage?

    private var userSettings = UserSettings.shared

    init() {
        self.name = userSettings.name
        self.nickname = userSettings.nickname
        self.selectedImage = userSettings.selectedImage
        self.customImage = userSettings.customImageData.flatMap { UIImage(data: $0) }
        
        // Observa alterações nas configurações do usuário e atualiza as propriedades
        NotificationCenter.default.addObserver(self, selector: #selector(userSettingsDidChange), name: UserDefaults.didChangeNotification, object: nil)
    }

    @objc func userSettingsDidChange() {
        DispatchQueue.main.async {
            self.name = self.userSettings.name
            self.nickname = self.userSettings.nickname
            self.selectedImage = self.userSettings.selectedImage
            self.customImage = self.userSettings.customImageData.flatMap { UIImage(data: $0) }
        }
    }

    func saveSettings() {
        userSettings.name = name
        userSettings.nickname = nickname
        userSettings.selectedImage = selectedImage
        if let customImage = customImage {
            userSettings.customImageData = customImage.jpegData(compressionQuality: 1.0)
        } else {
            userSettings.customImageData = nil
        }
    }
}
