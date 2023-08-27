//
//  MainAppScreen.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

enum AppWindow: String { case main = "Enemy Losses", settings = "Settings", about = "About"}
struct MainAppScreenView: View {
    @State var currentWindow: AppWindow = .main
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HeaderView(currentWindow: $currentWindow)
                    if currentWindow == .main {
                        HStack(alignment: .top) {
                            Spacer()
                                .frame(width: ViewConstants.detailsPanelLeadingPadding)
                            DetailsPanelView()
                                .transition(.opacity.animation(.easeInOut(duration: 0.1)))
                        }
                    } else if currentWindow == .settings {
                        SettingsScreenView(currentWindow: $currentWindow)
                    } else {
                        Spacer()
                        AboutScreenView(currentWindow: $currentWindow)
                        Spacer()
                    }
                }
                AppTitleView($currentWindow)
                CustomWatermarkView(currentWindow: $currentWindow)
            }
            .onChange(of: currentWindow) { _ in
                NotificationCenter.default.post(name: .shouldToggleListWindowAppearance, object: currentWindow)
            }
        }
        .mainWindowConfiguration()
    }
}

