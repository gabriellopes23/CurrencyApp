import SwiftUI

struct WelcomeView: View {
    @State var name = UserDefaults.standard.name
    @State var nickname = UserDefaults.standard.nickname
    @State var selectedImage = UserDefaults.standard.selectedImage
    @State private var isValidName = false
    @State private var isNicknameValid = false
    @State private var isFormSubmitted = false

    @State var showPhotoPicker: Bool = false
    @State var customImage: UIImage? = UserDefaults.standard.customImageData.flatMap { UIImage(data: $0) }

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

                TextField("Name", text: $name)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onChange(of: name) {
                        isValidName = !name.isEmpty
                    }

                TextField("Nickname", text: $nickname)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onChange(of: nickname) {
                        isNicknameValid = !nickname.isEmpty
                    }

                Button(action: {
                    if isValidName && isNicknameValid {
                        UserDefaults.standard.name = name
                        UserDefaults.standard.nickname = nickname
                        UserDefaults.standard.selectedImage = selectedImage
                        if let customImage = customImage {
                            UserDefaults.standard.customImageData = customImage.jpegData(compressionQuality: 1.0)
                        } else {
                            UserDefaults.standard.customImageData = nil
                        }
                        UserDefaults.standard.isFirstLaunch = false
                        isFormSubmitted = true
                    }
                }, label: {
                    Text("Continuar")
                })
            }
            .fullScreenCover(isPresented: $isFormSubmitted) {
                TabMainView(name: $name, nickname: $nickname, selectedImage: $selectedImage, customImage: $customImage, showPhotoPicker: $showPhotoPicker)
            }
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPicker(customImage: $customImage, showPicker: $showPhotoPicker)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
