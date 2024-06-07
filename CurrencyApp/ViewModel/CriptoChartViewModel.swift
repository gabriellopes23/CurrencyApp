

import Foundation

class CriptoChartViewModel: ObservableObject {
    @Published var chartModels: [CriptoChartModel] = []
    @Published var currentPrice: Double = 0.0
    @Published var closePrice: Double = 0.0
    @Published var highPrice: Double = 0.0
    @Published var lowPrice: Double = 0.0
    
    var minPrice: Double {
        chartModels.map { $0.Low }.min() ?? 0
    }
    
    var maxPrice: Double {
        chartModels.map { $0.High }.max() ?? 1
    }
    
    func getOHLC(idName: String, days: Int) {
        let apiKey = ""
        let urlString = "https://api.coingecko.com/api/v3/coins/\(idName)/ohlc?vs_currency=usd&days=\(days)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(apiKey, forHTTPHeaderField: "x-cg-demo-api-key")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[Double]] {
                    var newChartModels: [CriptoChartModel] = []
                    for array in jsonArray {
                        if array.count == 5 {
                            let chartModel = CriptoChartModel(time: array[0], Open: array[1], High: array[2], Low: array[3], Close: array[4])
                            newChartModels.append(chartModel)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.chartModels = newChartModels
                        self.currentPrice = newChartModels.last?.Open ?? 0.0
                        self.closePrice = newChartModels.last?.Close ?? 0.0
                        self.highPrice = newChartModels.last?.High ?? 0.0
                        self.lowPrice = newChartModels.last?.Low ?? 0.0
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
