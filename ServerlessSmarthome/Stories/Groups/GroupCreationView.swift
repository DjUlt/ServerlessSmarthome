//
//  GroupCreationView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 26.11.2023.
//

import SwiftUI

struct GroupCreationView: View {
    private static let dumbImage = UIImage()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var smartSystem: SmartSystem
    
    @State var name: String = .init()
    @State var image = dumbImage
    
    @State private var showSheet = false
    
    var body: some View {
        VStack {
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
                }
                .padding()
            }
            .background(.white.shadow(.inner(radius: 5)))
            Button {
                let newSystemDevice = SmartSystemGroup(name: name, backgroundImageData: image.jpegData(compressionQuality: 1) ?? Data(), parentSystem: smartSystem)
                smartSystem.groups.append(newSystemDevice)
                modelContext.insert(newSystemDevice)
                dismiss()
            } label: {
                Text("Save")
            }
            .disabled(name.isEmpty || image == GroupCreationView.dumbImage)
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
    }
}
