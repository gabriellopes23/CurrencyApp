
import SwiftUI

struct ButtonCoinView: View {
    @Binding var days: Int
    @Binding var showChart: Bool
    
    var body: some View {
        HStack {
            OneButtonView(action: {
                days = 15
                showChart = false
            }, title: "15 Day")
            OneButtonView(action: {
                days = 30
                showChart = false
            }, title: "30 Day")
            OneButtonView(action: {
                days = 90
                showChart = false
            }, title: "90 Day")
        }
    }
}

//struct OneButtonCoinView: View {
//    let action: () -> Void
//    let title: String
//    
//    var body: some View {
//        Button(action: {
//            action()
//        }, label: {
//            Text(title)
//                .padding()
//                .font(.headline)
//                .foregroundStyle(.white)
//                .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(.blue))
//        })
//    }
//}

#Preview {
    ZStack {
        bgColor.ignoresSafeArea()
        ButtonCoinView(days: .constant(15), showChart: .constant(false))
//        OneButtonCoinView(title: "1 Day")
    }
}
