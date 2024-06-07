
import Foundation

func formatToTwoDecimalPlaces(_ numberString: String) -> String {
    guard let number = Double(numberString) else {
        return numberString
    }
    return String(format: "%.2f", number)
}
