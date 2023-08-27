//
//  SettingsDonateBanner.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 24.08.2023.
//

import SwiftUI

struct SettingsDonateBanner: View {
    @State private var isButtonHovered: Bool = false
    @State private var isButtonClicked: Bool = false
    var body: some View {
        VStack {
            HStack {
                TextBuilder.makeText(AppTexts.donateButton, variant: .settingsTitle)
                    .foregroundColor(.white.opacity(isButtonHovered ? 1 : 0.9))
                    .padding()
                    .background(.black.opacity(isButtonHovered ? 1 : 0.8))
                    .cornerRadius(20)
                    .scaleEffect(isButtonHovered ? (isButtonClicked ? 0.96 : 1) : 0.98)
                    .onHover { isHovering in withAnimation(.easeInOut(duration: 0.15)) { isButtonHovered = isHovering } }
                    .onLongPressGesture(minimumDuration: 0.05) {
                        NSWorkspace.shared.open(URL(string: "https://macpaw.foundation/#donate")!)
                    } onPressingChanged: { status in
                        withAnimation(.easeInOut(duration: 0.1)) { isButtonClicked = status }
                    }
                TextBuilder.makeText(AppTexts.donateBannerText, variant: .settingsDescription)
                    .padding(.horizontal)
            }
        }
    }
}
