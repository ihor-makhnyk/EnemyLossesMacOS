//
//  HeaderButtonView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

struct HeaderButtonView: View {
    enum ButtonType { case settings, share, close, photo }
    
    @State private var isHovered: Bool = false
    
    let type: ButtonType
    let action: () -> Void
    
    @State private var clickAnimation: CGFloat = 1
    init(_ type: ButtonType, _ action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }
    var body: some View {
        VStack {
            Spacer()
            SelectButtonImage()
                .foregroundColor(.white.opacity(isHovered ? 1 : 0.8))
                .padding(4)
            Spacer()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.15).delay(0.25)) { clickAnimation = 0 }
        }
        .scaleEffect(1 - clickAnimation * 0.1)
        .padding(.trailing, ViewConstants.headerEachButtonTrailingPadding)
        .padding(.top, 2)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.15)) { clickAnimation = 1 }
            withAnimation(.easeInOut(duration: 0.15).delay(0.15)) { clickAnimation = 0 }
            action()
        }
        .onHover { isHovering in withAnimation(.easeInOut(duration: 0.1)) { isHovered = isHovering } }
    }
    
    private func SelectButtonImage() -> some View {
        VStack {
            switch type {
            case .settings:
                VStack {
                    Image(systemName: AppImages.settings)
                        .resizable()
                        .frame(width: ViewConstants.headerSettingsButtonWidth, height: ViewConstants.headerSettingsButtonHeight)
                }
            case .share:
                HStack {
                    Image(systemName: AppImages.share)
                        .resizable()
                        .offset(x: 0, y: -2)
                        .frame(width: ViewConstants.headerShareButtonWidth, height: ViewConstants.headerShareButtonHeight)
                    Rectangle()
                        .fill(.linearGradient(colors: [.clear, .gray.opacity(0.6), .clear], startPoint: .bottom, endPoint: .top)
                        .opacity(0.3))
                        .frame(width: 2, height: ViewConstants.headerHDividerHeight)
                        .padding(0)
                        .offset(x: 10)
                }
                
            case .close:
                VStack {
                    Image(systemName: AppImages.close)
                        .resizable()
                        .offset(x: -4)
                        .frame(width: ViewConstants.headerCloseButtonWidth, height: ViewConstants.headerCloseButtonHeight)
                }
            case .photo:
                VStack {
                    Image(systemName: AppImages.camera)
                        .resizable()
                        .offset(x: 8)
                        .frame(width: ViewConstants.headerPhotoButtonWidth, height: ViewConstants.headerPhotoButtonHeight)
                }
            }
        }
    }
}
