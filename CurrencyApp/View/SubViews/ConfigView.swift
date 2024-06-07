import SwiftUI

struct ConfigView: View {
    @Binding var name: String
    @Binding var nickname: String
    @Binding var selectedImage: String
    @Binding var showPhotoPicker: Bool
    @Binding var customImage: UIImage?
    
    var body: some View {
        NavigationLink(destination: {
            ConfigDestinationView(name: $name, nickname: $nickname, selectedImage: $selectedImage, showPhotoPicker: $showPhotoPicker, customImage: $customImage)
        }, label: {
            Image(systemName: "gear")
                .imageScale(.large)
                .padding(13)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
                .padding(.horizontal, 9)
        })
    }
}

struct ConfigDestinationView: View {
    @Binding var name: String {
        didSet {
            UserDefaults.standard.name = name
        }
    }
    @Binding var nickname: String {
        didSet {
            UserDefaults.standard.nickname = nickname
        }
    }
    @Binding var selectedImage: String {
        didSet {
            UserDefaults.standard.selectedImage = selectedImage
        }
    }
    
    @Binding var showPhotoPicker: Bool
    @Binding var customImage: UIImage? {
        didSet {
            if let customImage = customImage {
                UserDefaults.standard.customImageData = customImage.jpegData(compressionQuality: 1.0)
            } else {
                UserDefaults.standard.customImageData = nil
            }
        }
    }
    
    let images = ["image01", "image02", "image03", "image04", "image05", "image06"]
    
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Choose a profile picture")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {
                            showPhotoPicker = true
                        }, label: {
                            if let customImage = customImage {
                                Image(uiImage: customImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .background(Color.white.opacity(0.5))
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                            } else {
                                Image(systemName: "photo")
                                    .imageScale(.large)
                                    .frame(width: 60, height: 60)
                                    .background(Color.white.opacity(0.5))
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(customImage != nil ? Color.blue : Color.clear, lineWidth: 2))
                            }
                        })
                        
                        ForEach(images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)
                                .overlay(Circle().stroke(selectedImage == image ? Color.blue : Color.clear, lineWidth: 2))
                                .onTapGesture {
                                    selectedImage = image
                                    customImage = nil
                                }
                        }
                    }
                }
                .padding(.horizontal, 35)
                
                TextField("Change Name", text: $name)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.5)))
                TextField("Change Nickname", text: $nickname)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.5)))
            }
            .padding(.horizontal, 5)
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(customImage: $customImage, showPicker: $showPhotoPicker)
        }
    }
}

#Preview {
    ConfigDestinationView(name: .constant("Gabriel"), nickname: .constant("Biel"), selectedImage: .constant("image01"), showPhotoPicker: .constant(false), customImage: .constant(nil))
}
