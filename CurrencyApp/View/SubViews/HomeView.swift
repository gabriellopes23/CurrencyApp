
import SwiftUI

struct HomeView: View {
    @StateObject var chartVM: CriptoChartViewModel = CriptoChartViewModel()
    @StateObject var currencyVM: CriptoViewModel = CriptoViewModel()
    @Binding var name: String
    @Binding var nickname: String
    @Binding var selectedImage: String
    @Binding var customImage: UIImage?
    @Binding var showPhotoPicker: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                bgColor.ignoresSafeArea() 
                
                VStack(alignment: .leading, spacing: 5) {
                    TopMainView(name: $name, nickname: $nickname, selectedImage: $selectedImage, customImage: $customImage, showPhotoPicker: $showPhotoPicker)
                    
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
    HomeView(name: .constant(""), nickname: .constant(""), selectedImage: .constant("image01"), customImage: .constant(UIImage()), showPhotoPicker: .constant(false))
}
