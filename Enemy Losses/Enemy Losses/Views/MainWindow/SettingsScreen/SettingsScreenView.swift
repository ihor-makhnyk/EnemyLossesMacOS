//
//  SettingsScreenView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 22.08.2023.
//

import SwiftUI

struct SettingsScreenView: View {
    @Binding var currentWindow: AppWindow
    @State private var localeUpdateId: Int = 0
    var body: some View {
        VStack {
            VStack {
                SettingsScreenModules(.checkbox(title: AppTexts.saveDataToCache, description: AppTexts.saveDataToCacheDescription,  setting: .cacheData))
                SettingsScreenModules(.parameterSelector)
                SettingsScreenModules(.imageFormatAndLanguageSelector)
                SettingsScreenModules(.other)
                Spacer()
            }
            .frame(height: ViewConstants.defaultWindowHeight * 0.88)
            .id(localeUpdateId)
            .onReceive(NotificationCenter.default.publisher(for: .didLocaleUpdate), perform: { _ in
                localeUpdateId += 1
            })
        }
        .background(.clear)
        .offset(y: -ViewConstants.defaultWindowHeight * 0.04)
    }
}
