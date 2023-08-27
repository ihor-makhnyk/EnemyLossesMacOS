//
//  CustomSystemButtons.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

struct CustomSystemButtons: View {
    @State private var isHovered = false
    var body: some View {
        HStack(alignment: .top) {
            CustomCloseButtonView(isHovered: $isHovered)
            CustomMinituarizeButtonView(isHovered: $isHovered)
            
        }
        .offset(x: ViewConstants.customSystemButtonsOffset.width, y: ViewConstants.customSystemButtonsOffset.height)
    }
}

fileprivate struct CustomCloseButtonView: View {
    @Binding var isHovered: Bool
    @State private var isThisHovered: Bool = false
    var body: some View {
        Button {
            URLCache.shared.removeAllCachedResponses()
            DispatchQueue.main.async {
                NSApplication.shared.terminate(nil)
            }
        } label: {
            Circle()
                .fill(.red.gradient)
                .frame(width: 12, height: 12)
                .padding(4)
                .opacity(isHovered ? 1 : 0.3)
                .saturation(isHovered ? 1 : 0.8)
                .overlay {
                    Image(systemName: AppImages.close)
                        .resizable()
                        .colorInvert()
                        .frame(width: 6, height: 6)
                        .opacity(isThisHovered ? 0.99 : (isHovered ? 0.2 : 0))
                }
                .onHover { isHovering in
                    
                    withAnimation(.easeOut(duration: 0.2)) {
                        isHovered = isHovering
                        isThisHovered = isHovering
                    }
                }
                .shadow(radius: 1)
        }
        .buttonStyle(.plain)
        .padding(.leading, 12)
        .padding(.top, 8)
        .padding(.trailing, 0)
    }
}

fileprivate struct CustomMinituarizeButtonView: View {
    @Binding var isHovered: Bool
    @State private var isThisHovered: Bool = false
    var body: some View {
        Button {
            NSApplication.shared.miniaturizeAll(nil)
        } label: {
            Circle()
                .fill(.yellow.gradient)
                .frame(width: 12, height: 12)
                .padding(4)
                .opacity(isHovered ? 1 : 0.3)
                .saturation(isHovered ? 0.8 : 0.6)
                .overlay {
                    Image(systemName: AppImages.minituarize)
                        .resizable()
                        .colorInvert()
                        .frame(width: 6.6, height: 1.4)
                        .cornerRadius(1)
                        .opacity(isThisHovered ? 0.99 : (isHovered ? 0.2 : 0))
                }
                .onHover { isHovering in
                    withAnimation(.easeOut(duration: 0.2)) {
                        isHovered = isHovering
                        isThisHovered = isHovering
                    }
                }
                .shadow(radius: 1)
        }
        .buttonStyle(.plain)
        .padding(.top, 8)
        .offset(x: -8)
    }
}
