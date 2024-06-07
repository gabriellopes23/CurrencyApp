import SwiftUI

struct HomeView: View {
    @StateObject var chartVM: CriptoChartViewModel = CriptoChartViewModel()
    @StateObject var currencyVM: CriptoViewModel = CriptoViewModel()
    @ObservedObject var settingsManager: SettingsManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                bgColor.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 5) {
                    TopMainView(settingsManager: settingsManager)
                    
                    VStack(alignment: .leading) {
                        Text("Criptomoedas")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                        ListCriptoView(currencyVM: currencyVM, chartVM: chartVM)
                    }
                    .onAppear {
                        currencyVM.startAutoRefrashCripto()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    
                    Text("Moedas")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    ListCoinView()
                    Spacer()
                    
                }
            }
        }
    }
}

#Preview {
    HomeView(settingsManager: SettingsManager())
}
