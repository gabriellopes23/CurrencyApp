

import SwiftUI

struct ListCoinView: View {
    @StateObject var coinVM: CoinViewModel = CoinViewModel()
    @State var code: String = "".uppercased()
    @State var codein: String = "".uppercased()
    @State var showRowCoin: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Code", text: $code)
                    .padding()
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.5)))
                    .padding(.horizontal)
                TextField("Codein", text: $codein)
                    .padding()
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.5)))
                    .padding(.horizontal)
            }
            
            Button(action: {
                coinVM.getCoinInADay(code: code, codein: codein)
                coinVM.startAutoRefreshCoin(code: code, codein: codein)
                showRowCoin = true
            }, label: {
                Text("Show Coin")
                    .padding()
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(rowList))
            })
            
            ForEach(coinVM.coinModels, id: \.code) { coin in
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400))]) {
                    HStack(spacing: 15) {
                        Text(coin.name)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        VStack {
                            Text(Double(coin.pctChange) ?? 0.0 >= 0 ? "+\(coin.pctChange)%" : "\(coin.pctChange)%")
                                .foregroundStyle(Double(coin.pctChange) ?? 0.0 >= 0 ? .green : .red)
                            Text(formatToTwoDecimalPlaces(coin.high))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(rowList))
            }
        }
    }
}


//struct RowCoinView: View {
//    @StateObject var coinVM: CoinViewModel = CoinViewModel()
//    @StateObject var countryFlagsVM: CountryFlagsViewModel = CountryFlagsViewModel()
//
//    let code: String
//    let codein: String
//
//    var body: some View {
//        VStack {
//
//        }
//        .onAppear {
//            coinVM.getCoinInADay(code: code, codein: codein)
//            countryFlagsVM.getContryFlags(codein: codein)
//        }
//    }
//}

#Preview {
    ZStack {
        bgColor.ignoresSafeArea()
        ListCoinView()
        //        RowCoinView(codein: "BRL", code: "USD")
    }
}
