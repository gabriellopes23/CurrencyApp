
import Foundation

extension Double {
    func formattedCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en-US")
        
        return formatter.string(from: NSNumber(value: self))
    }
}
