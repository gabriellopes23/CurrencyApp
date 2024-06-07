
import SwiftUI

struct ButtonsTabView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    withAnimation {
                        selectedTab = 0
                    }
                }, label: {
                    ImageMenuView(imageName: "house", title: "Home", isSelected: selectedTab == 0)
                })
                
                Button(action: {
                    withAnimation {
                        selectedTab = 1
                    }
                }, label: {
                    ImageMenuView(imageName: "bitcoinsign.square", title: "Cripto", isSelected: selectedTab == 1)
                })
                
                Button(action: {
                    withAnimation {
                        selectedTab = 2
                    }
                }, label: {
                    ImageMenuView(imageName: "dollarsign.circle", title: "Coin", isSelected: selectedTab == 2)
                })
                
                Button(action: {
                    withAnimation {
                        selectedTab = 3
                    }
                }, label: {
                    ImageMenuView(imageName: "star", title: "Favorite", isSelected: selectedTab == 3)
                })
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 17)
            .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.opacity(0.3)))
        }
    }
}

struct ImageMenuView: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        if isSelected {
            VStack {
                Image(systemName: imageName)
                    .imageScale(.large)
            }
            .padding(10)
            .foregroundStyle(textColor)
            .font(.headline)
            .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(rowList).opacity(isSelected ? 1.0 : 0.0))
        } else {
            VStack {
                Image(systemName: imageName)
                Text(title)
                    .font(.caption)
            }
            .padding(9)
            .foregroundStyle(textColor)
            .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(rowList).opacity(isSelected ? 1.0 : 0.0))
        }
    }
}

#Preview {
    ZStack {
        bgColor.ignoresSafeArea()
        
//                ButtonsTabView(selectedTab: .constant(0))
        HStack {
            ImageMenuView(imageName: "house", title: "Home", isSelected: false)
            ImageMenuView(imageName: "house", title: "Home", isSelected: true)
        }
    }
}
