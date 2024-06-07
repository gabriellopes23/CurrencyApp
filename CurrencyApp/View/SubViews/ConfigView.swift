import SwiftUI

struct ConfigView: View {
    @ObservedObject var settingsManager: SettingsManager

    var body: some View {
        NavigationLink(destination: {
            ConfigDestinationView(settingsManager: settingsManager)
        }, label: {
            Image(systemName: "gear")
                .imageScale(.large)
                .padding(13)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 20).fill(rowList.opacity(0.7)))
                .padding(.horizontal, 9)
        })
    }
}

struct ConfigDestinationView: View {
    @ObservedObject var settingsManager: SettingsManager
    @State private var showPhotoPicker = false
    @State private var customImage: UIImage?
    
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
                            } else if let customImage = settingsManager.customImage {
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
                                    .overlay(Circle().stroke(Color.clear, lineWidth: 2))
                            }
                        })
                        
                        ForEach(images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)
                                .overlay(Circle().stroke(settingsManager.selectedImage == image ? Color.blue : Color.clear, lineWidth: 2))
                                .onTapGesture {
                                    settingsManager.selectedImage = image
                                    settingsManager.customImage = nil
                                    settingsManager.saveSettings()
                                }
                        }
                    }
                }
                .padding(.horizontal, 35)
                
                // Atualize os campos de texto com os valores do settingsManager
                TextField("Change Name", text: $settingsManager.name)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.5)))
                    .onChange(of: settingsManager.name) {
                        settingsManager.saveSettings()
                    }
                
                TextField("Change Nickname", text: $settingsManager.nickname)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.5)))
                    .onChange(of: settingsManager.nickname) {
                        settingsManager.saveSettings()
                    }
                Spacer()
            }
            .padding(.horizontal, 5)
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(customImage: $customImage, showPicker: $showPhotoPicker, onImagePicked: { image in
                settingsManager.customImage = image
                settingsManager.selectedImage = ""
                settingsManager.saveSettings()
            })
        }
        .onDisappear {
            settingsManager.saveSettings()
        }
    }
}

#Preview {
    ConfigDestinationView(settingsManager: SettingsManager())
}

