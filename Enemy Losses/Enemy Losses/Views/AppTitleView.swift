//
//  AppTitleView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

struct AppTitleView: View {
    @State private var localeUpdateId: Int = 0
    @State private var animationProgress: CGFloat = 0
    @State private var shouldHideWelcomeText: Bool = false
    @State private var disappearWorkItem: DispatchWorkItem?
    
    @State private var isHovered: Bool = false
    
    @Binding var currentWindow: AppWindow
    init(_ currentWindow: Binding<AppWindow>) { self._currentWindow = currentWindow }
    
    var body: some View {
        VStack {
            HStack {
                if !shouldHideWelcomeText {
                    TextBuilder.makeText(AppTexts.welcome, variant: .title)
                        .foregroundColor(.white)
                        .transition(.scale(scale: 0, anchor: .trailing).combined(with: .move(edge: .trailing)))
                }
                TextBuilder.makeText(currentWindow.rawValue.localized(lang: Localizer.locale.selectedLanguage), variant: .title)
                    .foregroundColor(.white)
                    .id(localeUpdateId)
                    .onReceive(NotificationCenter.default.publisher(for: .didLocaleUpdate), perform: { _ in
                        localeUpdateId += 1
                    })
                    .onTapGesture {
                        if shouldHideWelcomeText == true {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                currentWindow = currentWindow == .about ? .main : .about
                            }
                        }
                    }
                    .scaleEffect(isHovered ? 1.02 : 1)
                TextBuilder.makeText("tryzub", variant: .tryzub)
                    .foregroundColor(.white)
            }
            .offset(x: ViewConstants.defaultWindowWidth * ((1 - animationProgress) * 0.01), y: -(animationProgress * ViewConstants.defaultWindowHeight * 0.64))
            .zIndex(100)
        }
        .onHover(perform: { isHovering in withAnimation(.easeInOut(duration: 0.15).delay(0.01)) {
            guard animationProgress == 1 else { return }
            self.isHovered = isHovering
        } } )
        .scaleEffect(1 - (animationProgress * 0.282))
        .frame(width: ViewConstants.defaultWindowWidth, height: ViewConstants.defaultWindowHeight)
        .background(.ultraThickMaterial.opacity(1 - animationProgress))
        .onAppear {
            disappearWorkItem = DispatchWorkItem(block: { moveToTitlePosition() })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: disappearWorkItem!)
        }
        .onTapGesture {
            disappearWorkItem?.cancel()
            moveToTitlePosition()
        }
        .background(.clear)
    }
    
    private func moveToTitlePosition() {
        withAnimation(.easeInOut(duration: 0.35)) { animationProgress = 1 }
        withAnimation(.easeInOut(duration: 0.35).delay(0.6)) { shouldHideWelcomeText = true }
        NotificationCenter.default.post(name: .shouldToggleListWindowAppearance, object: currentWindow)
    }
}
