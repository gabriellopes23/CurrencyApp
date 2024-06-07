
import SwiftUI

struct SearchCriptoView: View {
    @StateObject var currencyVM: CriptoViewModel = CriptoViewModel()
    @StateObject var chartVM: CriptoChartViewModel = CriptoChartViewModel()
    @State var searchCripto: String = ""
    @State var showTexField: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                bgColor.ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Criptomoedas")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                showTexField.toggle()
                            }
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .padding(12)
                                .foregroundStyle(.white)
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(.white.opacity(0.3)))
                                .padding(.horizontal)
                        })
                    }
                    
                    if showTexField {
                        TextField(text: $searchCripto, label: {
                            HStack {
                                Text("Search Cripto")
                                    .foregroundStyle(.white)
                                    .fontWeight(.thin)
                            }
                        })
                        .padding()
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(.white.opacity(0.3)))
                        .padding(.vertical)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                    
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(currencyVM.currecyModels.filter { searchCripto.isEmpty ? true : $0.name.lowercased().contains(searchCripto.lowercased())}, id: \.id) { currency in
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 400))], alignment: .leading) {
                                NavigationLink(destination: {
                                    ChartCriptoView(chartVM: chartVM, idName: currency.id, name: currency.name, priceClose: chartVM.closePrice, priceHigh: chartVM.highPrice, priceLow: chartVM.lowPrice, changePercentage: currency.priceChangePercentage24H ?? 0.0, changePrice: currency.priceChange24H ?? 0.0)
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
                                })
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(rowList))
                        }
                    }
                    .onAppear {
                        currencyVM.startAutoRefrashCripto()
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        bgColor.ignoresSafeArea()
        
        SearchCriptoView()
    }
}
