
import SwiftUI
import Charts

struct ChartCoinView: View {
    @ObservedObject var coinVM: CoinViewModel
    @State private var currentPrice: Double? = nil
    @State private var dragLocation: CGPoint = .zero
    
    var body: some View {
        VStack {
            Chart {
                ForEach(coinVM.coinChartModels, id: \.code) { coin in
                    LineMark(x: .value("Day", Date(timeIntervalSince1970: Double(coin.timestamp) ?? 0)), y: .value("Price", Double(coin.ask) ?? 0))
                }
                
                if let lastedCoin = coinVM.coinChartModels.first {
                    PointMark(
                        x: .value("Day", Date(timeIntervalSince1970: Double(lastedCoin.timestamp) ?? 0.0)),
                        y: .value("Price", Double(lastedCoin.ask) ?? 0.0))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 350)
            .chartYScale(domain: coinVM.minPriceCoin...coinVM.maxPriceCoin)
            .chartXAxis {
                AxisMarks() { value in
                    AxisGridLine()
                        .foregroundStyle(Color.gray)
                    AxisTick()
                        .foregroundStyle(Color.gray)
                    AxisValueLabel()
                        .foregroundStyle(Color.gray)
                }
            }
            .chartYAxis {
                AxisMarks() { value in
                    AxisGridLine()
                        .foregroundStyle(Color.gray)
                    AxisTick()
                        .foregroundStyle(Color.gray)
                    AxisValueLabel()
                        .foregroundStyle(Color.gray)
                }
            }
            .overlay(
                GeometryReader { geo in
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .gesture(
                        DragGesture()
                            .onChanged { value in
                                let location = value.location
                                let x = location.x / geo.size.width
                                let y = location.y / geo.size.height
                                
                                let dateRange = coinVM.coinChartModels.compactMap {
                                    Date(timeIntervalSince1970: Double($0.timestamp) ?? 0)
                                }
                                
                                let priceRange = coinVM.coinChartModels.compactMap {
                                    Double($0.ask)
                                }
                                
                                if let minDate = dateRange.min(),
                                   let maxDate = dateRange.max(),
                                   let minPrice = priceRange.min(),
                                   let maxPrice = priceRange.max() {
                                    
                                    _  = minDate.addingTimeInterval((maxDate.timeIntervalSince(minDate)) * x)
                                    let price = minPrice + ((maxPrice - minPrice) * (1 - y))
                                    
                                    self.currentPrice = price
                                    self.dragLocation = location
                                }
                            }
                            .onEnded { _ in
                                self.currentPrice = nil
                            })
                })
            if let currentPrice = currentPrice {
                Text(String(format: "%.2f", currentPrice))
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .position(x: dragLocation.x, y: dragLocation.y - 250)
            }
        }
    }
}

//#Preview {
//    ChartCoinView(coinVM: <#CoinViewModel#>)
//}
