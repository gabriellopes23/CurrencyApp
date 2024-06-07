
import SwiftUI

struct TabMainView: View {
    @ObservedObject var settingsManager: SettingsManager
    @StateObject var favoriteVM: FavoriteViewModel = FavoriteViewModel()
    @State var selectedTab = 0
    
    var body: some View {
        ZStack {
                switch selectedTab {
                case 0:
                    HomeView(settingsManager: settingsManager)
                case 1:
                    SearchCriptoView()
                case 2:
                    ListAllCoinView()
                case 3:
                    FavoriteView(favoriteVM: favoriteVM)
                default:
                    HomeView(settingsManager: settingsManager)
                }
                
                Spacer()
                
                ButtonsTabView(selectedTab: $selectedTab)
                    .padding(.bottom, 16)
        }
        .onChange(of: selectedTab) {
            if selectedTab == 3 {
                favoriteVM.objectWillChange.send()
            }
        }
    }
}

#Preview {
    TabMainView(settingsManager: SettingsManager())
}
