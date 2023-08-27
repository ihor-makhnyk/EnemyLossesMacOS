//
//  SettingsClearCacheButtonView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 23.08.2023.
//

import SwiftUI

struct SettingsClearCacheButtonView: View {
    @State private var isClicked: Bool = false
    @State private var shouldIndicateSuccess: Bool = false
    var body: some View {
        VStack {
            TextBuilder.makeText(shouldIndicateSuccess ? AppTexts.clearCacheSuccess : AppTexts.clearCache, variant: .settingsTitle)
                .padding(4)
            VStack {
                Image(systemName: shouldIndicateSuccess ? AppImages.checkmark : AppImages.delete)
                    .resizable()
                    .foregroundColor(isClicked ? .red.opacity(0.5) : (shouldIndicateSuccess ? .green : .white))
                    .frame(width: ViewConstants.defaultWindowHeight * 0.035, height: ViewConstants.defaultWindowHeight * 0.042)
                    .transition(.scale)
            }
                .scaleEffect(isClicked ? 0.95 : 1)
                .padding(ViewConstants.defaultWindowHeight * 0.025)
                .padding(.horizontal, 4)
                .background(.gray.opacity(isClicked ? 0.15 : 0.25))
                .cornerRadius(20)
                .onTapGesture {
                    if !shouldIndicateSuccess {
                        DataService.shared.clearAllCaches()
                        withAnimation(.easeInOut(duration: 0.1)) { isClicked.toggle() }
                        withAnimation(.easeOut(duration: 0.5).delay(0.15)) { isClicked.toggle() }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: .allCachesCleared)) { _ in
                    withAnimation(.easeOut(duration: 0.5).delay(0.5)) { shouldIndicateSuccess = true }
                    guard let sound = NSSound(named: "Blow") else { return }
                    sound.volume = 0.3
                    sound.play()
                }
        }
        .frame(width: ViewConstants.settingsClearCacheButtonWidth, height: ViewConstants.settingsClearCacheButtonHeight)
    }
}

