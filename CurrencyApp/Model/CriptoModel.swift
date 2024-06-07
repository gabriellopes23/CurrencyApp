
import Foundation

struct CriptoModel: Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice, marketCap, fullyDilutedValuation: Double?
    let marketCapRank: Int?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
//    let roi: String?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
//        case roi
        case lastUpdated = "last_updated"
    }
    
    static func defaultCurrencyModel() -> CriptoModel {
        return CriptoModel(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            currentPrice: 70187,
            marketCap: 1381651251183,
            fullyDilutedValuation: 1474623675796,
            marketCapRank: 1,
            totalVolume: 20154184933,
            high24H: 70215,
            low24H: 68060,
            priceChange24H: 2126.88,
            priceChangePercentage24H: 3.12502,
            marketCapChange24H: 44287678051,
            marketCapChangePercentage24H: 3.31157,
            circulatingSupply: 19675987,
            totalSupply: 21000000,
            maxSupply: 21000000,
            ath: 73738,
            athChangePercentage: -4.7706,
            athDate: "2024-03-14T07:10:36.635Z",
            atl: 67,
            atlChangePercentage: 103455.83335,
            atlDate: "2013-07-06T00:00:00.000Z",
//            roi: nil,
            lastUpdated: "2024-04-07T16:49:31.736Z")
    }
}
