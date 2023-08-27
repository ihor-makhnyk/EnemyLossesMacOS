//
//  HeaderView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

struct HeaderView: View {
    private enum HeaderConfiguration { case shareButton, settingsButton, closeButton, systemButtons, photoButton }
    @State private var config: [HeaderConfiguration] = [.shareButton, .photoButton, .settingsButton, .systemButtons]
    
    @State private var canTakePicture: Bool = false
    @State private var isTakingPicture: Bool = false
    @State private var savingToClipboard: Bool = false
    
    @State private var localeUpdateId: Int = 0
    
    @Binding var currentWindow: AppWindow
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if config.contains(.systemButtons) {
                    CustomSystemButtons()
                }
                HStack(alignment: .top) {
                    Spacer()
                    VStack {
                        Spacer()
                        TextBuilder.makeText(savingToClipboard ? AppTexts.copiedToClipboard : isTakingPicture ? AppTexts.savedToDesktop : "", variant: .settingsDescription)
                            .opacity(isTakingPicture ? 0.3 : 0)
                            .padding()
                            .offset(y: 5)
                        Spacer()
                    }
                    if config.contains(.photoButton) {
                        HeaderButtonView(.photo) {
                            NotificationCenter.default.post(name: .shouldTakePicture, object: true)
                            withAnimation(.easeInOut(duration: 0.4)) { isTakingPicture.toggle(); canTakePicture = false }
                            playPhotoSound(0.5)
                            withAnimation(.easeInOut(duration: 3).delay(1)) { isTakingPicture.toggle(); }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.easeInOut(duration: 0.5)) { canTakePicture = true }
                            }
                        }
                        .help(AppTexts.photoTooltip.localized(lang: Localizer.locale.selectedLanguage))
                        .onLongPressGesture(minimumDuration: 0.2, perform: {
                            NotificationCenter.default.post(name: .shouldTakePicture, object: false)
                            withAnimation(.easeInOut(duration: 0.2)) { savingToClipboard.toggle(); isTakingPicture.toggle() }
                            playPhotoSound(0.25)
                            withAnimation(.easeInOut(duration: 3).delay(1)) { savingToClipboard.toggle(); isTakingPicture.toggle() }
                        })
                        .disabled(!canTakePicture)
                        .opacity(canTakePicture ? 1 : 0.6)
                        .scaleEffect(canTakePicture ? 1 : 0.9, anchor: .center)
                        .transition(.opacity.animation(.easeInOut(duration: 0.35)))
                    }
                    if config.contains(.shareButton) {
                        HeaderButtonView(.share) {
                            shareContent()
                        }
                        .help(AppTexts.shareTooltip.localized(lang: Localizer.locale.selectedLanguage))
                        .transition(.opacity.animation(.easeInOut(duration: 0.35)))
                    }
                    if config.contains(.settingsButton) {
                        HeaderButtonView(.settings) {
                            withAnimation(.easeInOut(duration: 0.3).delay(0.1)) {
                                currentWindow = .settings
                            }
                        }
                        .help(AppTexts.settingsTooltip.localized(lang: Localizer.locale.selectedLanguage))
                        .transition(.opacity.animation(.easeInOut(duration: 0.35)))
                    }
                    if config.contains(.closeButton) {
                        HeaderButtonView(.close) {
                            closeSettings()
                        }
                        .help(AppTexts.closeTooltip.localized(lang: Localizer.locale.selectedLanguage))
                        .background(KeyEventHandler(closeSettings))
                        .transition(.opacity.animation(.easeInOut(duration: 0.35)))
                    }
                }
                .padding(.trailing, ViewConstants.headerButtonsTrailingPadding)
            }
            .id(localeUpdateId)
            .onReceive(NotificationCenter.default.publisher(for: .didLocaleUpdate)) { _ in localeUpdateId += 1 }
            .onReceive(NotificationCenter.default.publisher(for: .didEquipmentLossesLoad)) { _ in canTakePicture = true }
            .onReceive(NotificationCenter.default.publisher(for: .loadingError)) { _ in canTakePicture = false }
            .onChange(of: currentWindow, perform: { newValue in
                if newValue == .main { config = [.systemButtons, .photoButton, .shareButton, .settingsButton] }
                else if newValue == .settings { config = [.systemButtons, .closeButton] }
                else { config = [.systemButtons, .closeButton] }
            })
        }
        .frame(width: ViewConstants.defaultWindowWidth, height: ViewConstants.headerHeight)
        .padding(.bottom, ViewConstants.headerPaddingBottom)
    }
    
    private func playPhotoSound(_ volume: Float) {
        if let soundURL = Bundle.main.url(forResource: "photoSound", withExtension: "mp3"), let sound = NSSound(contentsOf: soundURL, byReference: true) {
            sound.volume = volume
            sound.play()
        }
    }
    
    private func closeSettings() {
        withAnimation(.easeInOut(duration: 0.3).delay(0.1)) {
            currentWindow = .main
        }
        NotificationCenter.default.post(name: .shouldPersonnelLossesLoad, object: true)
    }
    
    private func shareContent() {
        let sharingService = NSSharingServicePicker(items: ["https://github.com/IhorMakhnyk"])
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate, let mainWindowView = appDelegate.mainWindow.contentView else { return }
        sharingService.show(relativeTo: .zero, of: mainWindowView, preferredEdge: .maxX)
    }
    
}
