//
//  CustomRefreshButton.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 22.08.2023.
//

import SwiftUI

struct CustomRefreshButton: View {
    @State private var animationProgress: CGFloat = 0
    var action: () -> Void
    var body: some View {
        VStack {
            Image(systemName: AppImages.refresh)
                .resizable()
                .foregroundColor(.gray)
                .rotationEffect(Angle(degrees: 360 * animationProgress))
                .frame(width: ViewConstants.listScrollViewSize.width * 0.05, height: ViewConstants.listScrollViewSize.width * 0.055)
        }
        .padding()
        .background {
            Circle()
                .fill(.gray.opacity(0.05))
                .blur(radius: 40)
                .frame(width: ViewConstants.listWindowWidth, height: ViewConstants.listWindowWidth)
        }
        .onTapGesture {
            action()
            withAnimation {
                animationProgress += 1
            }
        }

    }
}
