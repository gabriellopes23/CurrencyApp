
import SwiftUI
import Charts

struct ChartCriptoView: View {
    @StateObject var chartVM: CriptoChartViewModel = CriptoChartViewModel()
    @StateObject var favoriteVM: FavoriteViewModel = FavoriteViewModel()
    @State var days: Int = 1
    
    let idName: String
    let name: String
    let priceClose: Double
    let priceHigh: Double
    let priceLow: Double
    let changePercentage: Double
    let changePrice: Double
    
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            
            VStack {
                VStack(spacing: 30) {
                    HStack {
                        Text(name.uppercased())
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()

                        Button(action: {
                            if favoriteVM.isFavorite(coin: idName) {
                                favoriteVM.removeFavorite(coin: idName)
                            } else {
                                favoriteVM.addFavorite(coin: idName)
                            }
                        }, label: {
                            Image(systemName: favoriteVM.isFavorite(coin: idName) ? "star.fill" : "star")
                        })
                    }
                    
                    HStack {
                        VStack {
                            Text(priceClose.formattedCurrency() ?? "")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            HStack {
                                Text(changePrice >= 0 ? "+\(String(format: "%.2f", changePrice))" : "\(String(format: "%.2f", changePrice))")
                                    .font(.subheadline)
                                    .fontWeight(.thin)
                                Text(changePercentage >= 0 ? "+\(String(format: "%.2f", changePercentage))%" : "\(String(format: "%.2f", changePercentage))%")
                                    .foregroundStyle(changePercentage >= 0 ? .green : .red)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("High")
                                .font(.subheadline)
                                .fontWeight(.thin)
                            Text(priceHigh.formattedCurrency() ?? "")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        VStack(alignment: .trailing) {
                            Text("Low")
                                .font(.subheadline)
                                .fontWeight(.thin)
                            Text(priceLow.formattedCurrency() ?? "")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding()
                .foregroundStyle(.white)
                .background(infoCurrency)
                
                Spacer()
                
                ButtonCriptoDayView(days: $days)
                
                Spacer()
                
                    Chart {
                        ForEach(chartVM.chartModels, id: \.id) { chart in
                            LineMark(
                                x: .value("Time", Date(timeIntervalSince1970: chart.time / 1000)),
                                y: .value("Price", chart.Open)
                            )
                            .foregroundStyle(lineChartCripto)
                            .lineStyle(StrokeStyle(lineWidth: 3))
                            
                        }
                        RuleMark(y: .value("Price", chartVM.currentPrice))
                            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                            .annotation(position: .top, alignment: .leading) {
                                Text(chartVM.currentPrice.formattedCurrency() ?? "")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 6)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 350)
                    .chartYScale(domain: chartVM.minPrice...chartVM.maxPrice)
                    .chartXAxis {
                        AxisMarks() { value in
                            AxisGridLine()
                                .foregroundStyle(textColor)
                            AxisTick()
                                .foregroundStyle(textColor)
                            AxisValueLabel()
                                .foregroundStyle(textColor)
                        }
                    }
                    .chartYAxis {
                        AxisMarks { value in
                            AxisGridLine()
                                .foregroundStyle(textColor)
                            AxisTick()
                                .foregroundStyle(textColor)
                            AxisValueLabel()
                                .foregroundStyle(textColor)
                        }
                    }               
                
                Spacer()
                Spacer()
            }
            .onAppear {
                chartVM.getOHLC(idName: idName, days: days)
                Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
                    chartVM.getOHLC(idName: idName, days: 1)
                }
            }
            .onChange(of: days) {
                chartVM.getOHLC(idName: idName, days: days)
            }
        }
    }
}

#Preview {
    ChartCriptoView(idName: "bitcoin", name: "Bitcoin", priceClose: 70215, priceHigh: 70215, priceLow: 70215, changePercentage: 3.12502, changePrice: 2126.88)
}
