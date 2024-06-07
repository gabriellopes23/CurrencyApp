
import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var favoriteCoins: [String] {
        didSet {
            UserDefaults.standard.set(favoriteCoins, forKey: "FavoriteCoins")
        }
    }
    
    init() {
        self.favoriteCoins = UserDefaults.standard.object(forKey: "FavoriteCoins") as? [String] ?? []
    }
    
    func addFavorite(coin: String) {
        if !favoriteCoins.contains(coin) {
            favoriteCoins.append(coin)
        }
    }
    
    func removeFavorite(coin: String) {
        if let index = favoriteCoins.firstIndex(of: coin) {
            favoriteCoins.remove(at: index)
        }
    }
    
    func isFavorite(coin: String) -> Bool {
        return favoriteCoins.contains(coin)
    }
}
