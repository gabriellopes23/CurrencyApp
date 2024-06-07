
import SwiftUI

struct TopMainView: View {
    @Binding var name: String
    @Binding var nickname: String
    @Binding var selectedImage: String
    @Binding var customImage: UIImage?
    @Binding var showPhotoPicker: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            if let customImage = customImage {
                Image(uiImage: customImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            } else {
                Image(selectedImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text(nickname)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            ConfigView(name: $name, nickname: $nickname, selectedImage: $selectedImage, showPhotoPicker: $showPhotoPicker, customImage: $customImage)
        }
    }
}

#Preview {
    TopMainView(name: .constant("Gabriel"), nickname: .constant("Biel"), selectedImage: .constant("image01"), customImage: .constant(UIImage()), showPhotoPicker: .constant(false))
}
