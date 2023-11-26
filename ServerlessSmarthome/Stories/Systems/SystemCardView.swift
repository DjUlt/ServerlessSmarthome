//
//  SystemCardView.swift
//  ServerlessSmarthome
//
//  Created by Hlib Anisimov on 18.10.2023.
//

import SwiftUI

struct SystemCardView: View {
    @Binding var system: SmartSystem
    
    var body: some View {
        SystemCardPreviewView(name: .constant(system.name),
                              backgroundImage: .constant(.init(data: system.backgroundImageData) ?? .gaming),
                              themeColor: .constant(system.themeColor))
    }
}

struct SystemCardPreviewView: View {
    @Binding var name: String
    @Binding var backgroundImage: UIImage
    @Binding var themeColor: ColorComponents
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(name)
                .font(.headline)
                .foregroundStyle(.black)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 4))
                .padding()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    themeColor.color
                        .frame(width: 25, height: 25)
                        .blur(radius: 1.6)
                        .clipShape(.circle)
                        .padding([.bottom, .trailing])
                }
            }
        }
        .background(
            Image(uiImage: backgroundImage)
                .resizable()
                .scaledToFill()
                .clipped()
                .blur(radius: 2)
        )
        .clipShape(.rect(cornerRadius: 16))
        .shadow(radius: 6)
    }
}

#Preview {
    SystemCardPreviewView(name: .constant("Test name"), backgroundImage: .constant(UIImage(resource: .gaming)), themeColor: .constant(ColorComponents.fromColor(.purple)))
        .frame(width: 200, height: 100)
}
