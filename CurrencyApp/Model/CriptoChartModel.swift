
import Foundation

struct CriptoChartModel: Identifiable {
    var id = UUID()
    let time: Double
    let Open: Double
    let High: Double
    let Low: Double
    let Close: Double
    
    enum CodingKeys: String, CodingKey {
        case time, open = "Open", high = "High", low = "Low", close = "Close"
    }
}
