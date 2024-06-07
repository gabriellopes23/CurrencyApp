
import SwiftUI

struct TabMainView: View {
    @StateObject var favoriteVM: FavoriteViewModel = FavoriteViewModel()
    @Binding var name: String
    @Binding var nickname: String
    @Binding var selectedImage: String
    @State var selectedTab = 0
    @Binding var customImage: UIImage?
    @Binding var showPhotoPicker: Bool
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case 0:
                HomeView(name: $name, nickname: $nickname, selectedImage: $selectedImage, customImage: $customImage, showPhotoPicker: $showPhotoPicker)
            case 1:
                SearchCriptoView()
            case 2:
                ListAllCoinView()
            case 3:
                FavoriteView(favoriteVM: favoriteVM)
            default:
                HomeView(name: $name, nickname: $nickname, selectedImage: $selectedImage, customImage: $customImage, showPhotoPicker: $showPhotoPicker)
            }
            
            ButtonsTabView(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    TabMainView(name: .constant(""), nickname: .constant(""), selectedImage: .constant("image01"), customImage: .constant(UIImage()), showPhotoPicker: .constant(false))
}
