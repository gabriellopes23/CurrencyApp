
import Foundation

struct CoinModel: Codable {
    let code, codein, name, high: String
    let low, varBid, pctChange, bid: String
    let ask, timestamp, createDate: String

    enum CodingKeys: String, CodingKey {
        case code, codein, name, high, low, varBid, pctChange, bid, ask, timestamp
        case createDate = "create_date"
    }
}
