
import Foundation

class CriptoViewModel: ObservableObject {
    @Published var currecyModels: [CriptoModel] = []
    private var refrashTimer: Timer?
    
    func getCurrencies() {
        let apiKey = ""
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(apiKey, forHTTPHeaderField: "x-cg-demo-api-key")
        
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
                let newCurrencies = try jsonDecoder.decode([CriptoModel].self, from: data)
                
                DispatchQueue.main.async {
                    self.currecyModels = newCurrencies
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func startAutoRefrashCripto() {
        getCurrencies()
        refrashTimer?.invalidate()
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            self.getCurrencies()
        }
    }
    
    deinit {
        refrashTimer?.invalidate()
    }
}
