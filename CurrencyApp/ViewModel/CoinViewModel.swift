
import Foundation

class CoinViewModel: ObservableObject {
    @Published var coinChartModels: [CoinChartModel] = []
    @Published var coinModels: [CoinModel] = []
    
    private var refreshTimer: Timer?
    
    var minPriceCoin: Double {
        coinChartModels.map { Double($0.low) ?? Double.greatestFiniteMagnitude }.min() ?? 0
    }
    
    var maxPriceCoin: Double {
        coinChartModels.map { Double($0.high) ?? -Double.greatestFiniteMagnitude }.max() ?? 1
    }
    
    func getCoinsForTheDay(code: String, codein: String, days: Int) {
        let urlString = "https://economia.awesomeapi.com.br/json/daily/\(code)-\(codein)/\(days)"
        guard let url = URL(string: urlString) else {
            print("Invalid url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            do {
                let newCoinModels = try jsonDecoder.decode([CoinChartModel].self, from: data)
                
                DispatchQueue.main.async {
                    self.coinChartModels = newCoinModels
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getCoinInADay(code: String, codein: String) {
        let urlString = "https://economia.awesomeapi.com.br/json/last/\(code)-\(codein)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            do {
                let newCoinDictionary = try jsonDecoder.decode([String: CoinModel].self, from: data)
                let newCoin = Array(newCoinDictionary.values)
                
                DispatchQueue.main.async {
                    self.coinModels = newCoin
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func startAutoRefreshCoin(code: String, codein: String) {
        stopAutoRefresh()
        refreshTimer?.invalidate()
        getCoinInADay(code: code, codein: codein)
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] _ in
            self?.getCoinInADay(code: code, codein: codein)
        }
    }
    
    func startAutoRefreshChartCoin(code: String, codein: String, days: Int) {
    stopAutoRefresh()
        getCoinsForTheDay(code: code, codein: codein, days: days)
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] _ in
            self?.getCoinsForTheDay(code: code, codein: codein, days: days)
        }
    }
    
    func stopAutoRefresh() {
        refreshTimer?.invalidate()
    }
    
    deinit {
        refreshTimer?.invalidate()
    } 
}
