//
//  SystemCreationView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 18.10.2023.
//

import SwiftUI

struct SystemCreationView: View {
    private static let dumbImage = UIImage()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State var name: String = .init()
    @State var image = dumbImage
    @State var themeColor: ColorComponents = .init(red: 255, green: 255, blue: 255)

    @State private var showSheet = false
    
    var body: some View {
        VStack {
            headerPreview
                .frame(height: 200)
            ScrollView {
                Group {
                    TextField("Name", text: $name)
                        .padding(4)
                        .background(
                            .white
                            .shadow(.inner(radius: 4))
                            .shadow(.drop(radius: 10))
                        )
                        .clipShape(.rect(cornerRadius: 4))
                        .padding(.vertical)
                    HStack {
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(50)
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                        Text("Change photo")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                showSheet = true
                            }
                    }
                    .padding(.vertical)
                    HStack {
                        Text(String(format: "%.f", themeColor.red))
                            .font(.headline)
                            .frame(height: 50)
                            .cornerRadius(16)
                            .padding(.horizontal, 20)
                        Stepper("Red", value: $themeColor.red, in: 0...255)
                    }
                    .padding(.vertical)
                    HStack {
                        Text(String(format: "%.f", themeColor.green))
                            .font(.headline)
                            .frame(height: 50)
                            .cornerRadius(16)
                            .padding(.horizontal, 20)
                        Stepper("Green", value: $themeColor.green, in: 0...255)
                    }
                    .padding(.vertical)
                    HStack {
                        Text(String(format: "%.f", themeColor.blue))
                            .font(.headline)
                            .frame(height: 50)
                            .cornerRadius(16)
                            .padding(.horizontal, 20)
                        Stepper("Blue", value: $themeColor.blue, in: 0...255)
                    }
                    .padding(.vertical)
                }
                .padding()
            }
            .background(.white.shadow(.inner(radius: 5)))
            Button {
                let newSystem = SmartSystem(timestamp: Date(), name: name, keyHash: UUID(), backgroundImageData: image.resizeImage(targetSize: .init(width: 200, height: 200)).jpegData(compressionQuality: 1) ?? Data(), themeColor: themeColor)
                modelContext.insert(newSystem)
                dismiss()
            } label: {
                Text("Save")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .disabled(name.isEmpty || image == SystemCreationView.dumbImage)
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
    }
    
    private var headerPreview: some View {
        HStack {
            Spacer()
            SystemCardPreviewView(name: $name,
                                  backgroundImage: $image,
                                  themeColor: $themeColor)
            .background(
                .ultraThinMaterial
                    .shadow(.drop(radius: 20))
                    .shadow(.inner(radius: 10))
            )
            .clipShape(.rect(cornerRadius: 16))
            
            Spacer()
        }
        .padding()
        .background(.gray.shadow(.inner(radius: 10)))
    }
}

#Preview {
    SystemCreationView()
        .modelContainer(for: SmartSystem.self, inMemory: true)
}
