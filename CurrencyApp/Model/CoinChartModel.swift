
import Foundation

struct CoinChartModel: Codable {
    let code, codein, name: String?
    let high, low, varBid, pctChange: String
    let bid, ask, timestamp: String
    let createDate: String?

    enum CodingKeys: String, CodingKey {
        case code, codein, name, high, low, varBid, pctChange, bid, ask, timestamp
        case createDate = "create_date"
    }
}
