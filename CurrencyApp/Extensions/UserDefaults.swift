import Foundation
import UIKit

class UserSettings {
    static let shared = UserSettings()

    private let isFirstLaunchKey = "isFirstLaunch"
    private let nameKey = "name"
    private let nicknameKey = "nickname"
    private let selectedImageKey = "selectedImage"
    private let customImageDataKey = "customImageData"

    private init() {
        // Defina o valor inicial de isFirstLaunch se ainda não foi definido
        if UserDefaults.standard.object(forKey: isFirstLaunchKey) == nil {
            UserDefaults.standard.set(true, forKey: isFirstLaunchKey)
        }
    }

    var isFirstLaunch: Bool {
        get { UserDefaults.standard.bool(forKey: isFirstLaunchKey) }
        set { UserDefaults.standard.set(newValue, forKey: isFirstLaunchKey) }
    }

    var name: String {
        get { UserDefaults.standard.string(forKey: nameKey) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: nameKey) }
    }

    var nickname: String {
        get { UserDefaults.standard.string(forKey: nicknameKey) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: nicknameKey) }
    }

    var selectedImage: String {
        get { UserDefaults.standard.string(forKey: selectedImageKey) ?? "defaultImage" }
        set { UserDefaults.standard.set(newValue, forKey: selectedImageKey) }
    }

    var customImageData: Data? {
        get { UserDefaults.standard.data(forKey: customImageDataKey) }
        set { UserDefaults.standard.set(newValue, forKey: customImageDataKey) }
    }
}
