
import SwiftUI
import Charts

struct ListAllCoinView: View {
    @StateObject var coinVM: CoinViewModel = CoinViewModel()
    @State var code: String = "".uppercased()
    @State var codein: String = "".uppercased()
    @State var showChart: Bool = false
    @State var days: Int = 1
    
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("National Currencies")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
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
                
                ButtonCoinView(days: $days, showChart: $showChart)
                
                
                Button(action: {
                    coinVM.getCoinsForTheDay(code: code, codein: codein, days: days)
                    coinVM.startAutoRefreshChartCoin(code: code, codein: codein, days: days)
                    showChart.toggle()
                }, label: {
                    Text("Show Chart")
                        .padding()
                        .foregroundStyle(.white)
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(rowList))
                })
                
                if showChart {
                    withAnimation {
                        ChartCoinView(coinVM: coinVM)
                    }
                }
            Spacer()
                
            }
            .onAppear {
                coinVM.getCoinsForTheDay(code: code, codein: codein, days: days)
            }
        }
    }
}

#Preview {
    ListAllCoinView()
    //    ChartCoinView()
}

