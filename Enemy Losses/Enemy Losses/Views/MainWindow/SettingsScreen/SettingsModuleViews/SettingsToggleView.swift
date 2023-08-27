//
//  SettingsToggleView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 23.08.2023.
//

import SwiftUI

struct SettingsToggleView: View {
    @State private var isOn: Bool
    @Binding var config: UserSettingsConfigurationModel
    @Binding var shouldPresentSecondColumn: Bool
    var titleText: String
    var descriptionText: String?
    init(_ defaultsKey: UserSettingsConfigurationModel.Keys, title: String, description: String? = nil, showSecondColumn: Binding<Bool> = .constant(false), with config: Binding<UserSettingsConfigurationModel>) {
        self.isOn = { if defaultsKey == .cacheData { return config.wrappedValue.cacheData }; return true }()
        self._shouldPresentSecondColumn = showSecondColumn
        self.descriptionText = description
        self.titleText = title
        self._config = config
    }
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Toggle(isOn: $isOn) {
                    TextBuilder.makeText(titleText, variant: .settingsTitle)
                        .padding(4)
                }
                .tint(.black)
                .toggleStyle(.switch)
                .onChange(of: isOn) { newValue in
                    config.cacheData = newValue
                    shouldPresentSecondColumn.toggle()
                }
            }
            .frame(height: ViewConstants.settingsToggleViewTitleHeight)
            if let descriptionText = descriptionText {
                VStack {
                    TextBuilder.makeText(descriptionText, variant: .settingsDescription)
                        .multilineTextAlignment(.center)
                        .padding(4)
                        .padding(.horizontal, 6)
                        .frame(minWidth: ViewConstants.settingsToggleViewDescriptionMinWidth,
                               maxWidth: ViewConstants.settingsToggleViewDescriptionMaxWidth)
                    Spacer()
                }
                .frame(height: ViewConstants.settingsToggleViewDescriptionContainerHeight)
            }
        }
        .frame(width: ViewConstants.defaultWindowWidth * (isOn ? 0.46 : 0.6), height: ViewConstants.settingsToggleViewHeight)
    }
}
