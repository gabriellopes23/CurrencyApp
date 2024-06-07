
import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favoriteVM: FavoriteViewModel
    @StateObject var currencyVM: CriptoViewModel = CriptoViewModel()
    @StateObject var chartVM: CriptoChartViewModel = CriptoChartViewModel()
    @State private var showDeleteButton: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                bgColor.ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("Favorites")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(favoriteVM.favoriteCoins.indices, id: \.self) { index in
                            let coin = favoriteVM.favoriteCoins[index]
                            
                            if let currency = currencyVM.currecyModels.first(where: { $0.id == coin }) {
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400))]) {
                                    NavigationLink(destination: {
                                        ChartCriptoView(idName: currency.id, name: currency.name, priceClose: chartVM.closePrice, priceHigh: chartVM.highPrice, priceLow: chartVM.lowPrice, changePercentage: currency.priceChangePercentage24H ?? 0.0, changePrice: currency.priceChange24H ?? 0.0)
                                            .onAppear {
                                                chartVM.getOHLC(idName: currency.id, days: 1)
                                            }
                                    }, label: {
                                        HStack(spacing: 10) {
                                            ImageUrlView(imageUrl: currency.image, width: 40, height: 40)
                                            
                                            VStack(alignment: .leading) {
                                                Text(currency.name)
                                                    .font(.title3)
                                                    .fontWeight(.bold)
                                                Text(currency.symbol.uppercased())
                                                    .font(.subheadline)
                                                    .fontWeight(.thin)
                                            }
                                            Spacer()
                                            VStack {
                                                Text(currency.currentPrice?.formattedCurrency() ?? "")
                                                    .font(.title3)
                                                
                                                HStack {
                                                    Text(currency.priceChange24H ?? 0.0 >= 0 ? "+\(String(format: "%.2f", currency.priceChange24H ?? 0.0))" : "\(String(format: "%.2f", currency.priceChange24H ?? 0.0))")
                                                        .font(.subheadline)
                                                        .fontWeight(.thin)
                                                    Text(currency.priceChangePercentage24H ?? 0.0 >= 0 ? "+\(String(format: "%.2f", currency.priceChangePercentage24H ?? 0.0 ))%" : "\(String(format: "%.2f", currency.priceChangePercentage24H ?? 0.0))%")
                                                        .font(.subheadline)
                                                        .foregroundStyle(currency.priceChangePercentage24H ?? 0.0 >= 0 ? .green : .red)
                                                }
                                            }
                                        }
                                        .foregroundStyle(.white)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    if value.translation.width < 0 && abs(value.translation.width) > 50 {
                                                        withAnimation {
                                                            showDeleteButton = true
                                                        }
                                                    } else {
                                                        withAnimation {
                                                            showDeleteButton = false
                                                        }
                                                    }
                                                }
                                        )
                                        Button(action: {
                                            withAnimation {
                                                favoriteVM.removeFavorite(coin: coin)
                                            }
                                        }, label: {
                                            Image(systemName: "trash.circle.fill")
                                                .font(.title)
                                                .foregroundStyle(.red)
                                                .padding()
                                        })
                                        .opacity(showDeleteButton ? 1 : 0)
                                        .offset(x: showDeleteButton ? 0 : 80)
                                        .frame(width: showDeleteButton ? 10 : 0)
                                    })
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 20).fill(rowList).opacity(0.7))
                            }
                        }
                    }
                }
            }
            .onAppear {
                currencyVM.startAutoRefrashCripto()
                favoriteVM.objectWillChange.send()
            }
        }
    }
}

#Preview {
    FavoriteView(favoriteVM: FavoriteViewModel())
}
