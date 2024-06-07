
import SwiftUI

struct ButtonCriptoDayView: View {
    @Binding var days: Int
    
    var body: some View {
        HStack {
            OneButtonView(action: {
                days = 1
            }, title: "1 DAY")
            OneButtonView(action: {
                days = 7
            }, title: "7 DAY")
            OneButtonView(action: {
                days = 30
            }, title: "30 DAY")
        }
    }
}

struct OneButtonView: View {
    var action: () -> Void
    let title: String
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .fontWeight(.semibold)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [.indigo, .purple], startPoint: .bottomLeading, endPoint: .topTrailing)))
                .shadow(color: .white.opacity(0.5), radius: 7)
        })
    }
}

#Preview {
    ButtonCriptoDayView(days: .constant(1))
}
