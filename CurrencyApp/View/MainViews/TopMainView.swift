import SwiftUI

struct TopMainView: View {
    @ObservedObject var settingsManager: SettingsManager

    var body: some View {
        HStack(spacing: 5) {
            if let customImage = settingsManager.customImage {
                Image(uiImage: customImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            } else {
                Image(settingsManager.selectedImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }

            VStack(alignment: .leading) {
                Text(settingsManager.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(settingsManager.nickname)
                    .foregroundColor(.white)
            }

            Spacer()

            ConfigView(settingsManager: settingsManager)
        }
    }
}
