//
//  CustomWatermarkView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 24.08.2023.
//

import SwiftUI

struct CustomWatermarkView: View {
    @Binding var currentWindow: AppWindow
    @State private var previousScreen: AppWindow = .main
    @State private var localeUpdateId: Int = 0
    @State private var isHovered: Bool = false
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextBuilder.makeText(AppTexts.watermark, variant: .body).id(localeUpdateId)
                    .multilineTextAlignment(.leading)
                    .opacity(isHovered ? 0.35 : 0.2)
                    .padding(.horizontal)
                    .scaleEffect(isHovered ? 1.1 : 1, anchor: .center)
                    .onHover { isHovering in withAnimation(.easeInOut(duration: 0.3)) { isHovered = isHovering } }
                if currentWindow == .main {
                    Spacer().transition(.move(edge: .trailing).animation(.easeInOut(duration: 0.4).delay(0.2)))
                }
            }
            .onTapGesture { toggleWindow() }
            .onReceive(NotificationCenter.default.publisher(for: .shouldToggleAboutWindow)) { _ in toggleWindow() }
            .onReceive(NotificationCenter.default.publisher(for: .didLocaleUpdate), perform: { _ in localeUpdateId += 1 })
            .padding(.horizontal, 13)
            .padding(.bottom, 6)
        }
    }
    
    func toggleWindow() {
        withAnimation(.easeInOut(duration: 0.5)) {
            if currentWindow == .about {
                currentWindow =  previousScreen
            } else {
                previousScreen = currentWindow
                currentWindow = .about
            }
        }
    }
}
