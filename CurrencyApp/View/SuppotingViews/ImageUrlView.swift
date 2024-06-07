
import SwiftUI

struct ImageUrlView: View {
    let imageUrl: String?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
         if let imageUrlString = imageUrl,
            let imageUrl = URL(string: imageUrlString) {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                        case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: width, height: height)
                            .cornerRadius(20)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: height, height: height)
                            .aspectRatio(contentMode: .fill)
                            .opacity(0)
                    default:
                        EmptyView()
                    }
                }
            }
    }
}

#Preview {
    ImageUrlView(imageUrl: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", width: 50, height: 50)
}
