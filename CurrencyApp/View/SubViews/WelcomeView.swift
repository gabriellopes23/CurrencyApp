
import SwiftUI

struct WelcomeView: View {
    @ObservedObject var settingsManager: SettingsManager

    @State private var isValidName = true
    @State private var isNicknameValid = true
    @State private var isFormSubmitted = false
    @State private var showFormSubmitted = false
    @State private var showText = false
    @State private var shakeAnimation = false
    @State private var showPhotoPicker = false

    let images = ["image01", "image02", "image03", "image04", "image05", "image06"]

    var body: some View {
        ZStack {
        
            bgColor.ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                if showText {
                    VStack {
                        Text("HI!")
                            .font(.largeTitle)
                        Text("Welcome Currency App")
                    }
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                    .transition(.move(edge: .leading).combined(with: .opacity))
                }

                Spacer()

                // Formulário de informações do usuário
                if showFormSubmitted {
                    VStack(spacing: 15) {
                        Text("Fill in the information")
                            .foregroundColor(.white)
                            .fontWeight(.bold)

                        // Seleção de imagem
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Button(action: {
                                    showPhotoPicker = true
                                }) {
                                    if let customImage = settingsManager.customImage {
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
                                }

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
                                        }
                                }
                            }
                        }
                        .padding(.horizontal, 35)

                        // Entrada de nome
                        TextField("Name", text: $settingsManager.name)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .onChange(of: settingsManager.name) {
                                isValidName = !settingsManager.name.isEmpty
                            }
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !isValidName {
                                        Image(systemName: "questionmark.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.horizontal, 20)
                            )
                            .modifier(ShakeEffect(animatableData: CGFloat(shakeAnimation ? 1 : 0)))

                        // Entrada de apelido
                        TextField("Nickname", text: $settingsManager.nickname)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .onChange(of: settingsManager.nickname) {
                                isNicknameValid = !settingsManager.nickname.isEmpty
                            }
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !isNicknameValid {
                                        Image(systemName: "questionmark.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.horizontal, 20)
                            )
                            .modifier(ShakeEffect(animatableData: CGFloat(shakeAnimation ? 1 : 0)))

                        // Botão de envio
                        Button(action: {
                            // Lógica de validação
                            if settingsManager.name.isEmpty {
                                isValidName = false
                                withAnimation {
                                    shakeAnimation = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    shakeAnimation = false
                                }
                            }

                            if settingsManager.nickname.isEmpty {
                                isNicknameValid = false
                                withAnimation {
                                    shakeAnimation = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    shakeAnimation = false
                                }
                            }

                            if isValidName && isNicknameValid {
                                // Salvar as configurações
                                settingsManager.saveSettings()
                                UserSettings.shared.isFirstLaunch = false
                                // Atualizar o estado para mostrar a tela principal
                                isFormSubmitted = true
                            }
                        }) {
                            Text("Continue")
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.purple))
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.7))
                    )
                    .padding(5)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                }

                Spacer()
            }
        }
        .onAppear {
            withAnimation {
                showText = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    showFormSubmitted = true
                }
            }
        }
        .fullScreenCover(isPresented: $isFormSubmitted) {
            TabMainView(settingsManager: settingsManager)
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(customImage: $settingsManager.customImage, showPicker: $showPhotoPicker)
        }
    }
}

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat 
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}

#Preview {
    WelcomeView(settingsManager: SettingsManager())
}
