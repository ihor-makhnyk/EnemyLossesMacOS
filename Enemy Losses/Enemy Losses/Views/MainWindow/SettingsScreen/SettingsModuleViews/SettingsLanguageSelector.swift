//
//  SettingsLanguageSelector.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 24.08.2023.
//

import SwiftUI

struct SettingsLanguageSelector: View {
    @State private var selectedLanguage: UserSettingsConfigurationModel.AppLanguage
    @State private var updatesId = 0
    @Binding var config: UserSettingsConfigurationModel
    
    init(config: Binding<UserSettingsConfigurationModel>) {
        self._config = config
        selectedLanguage = UserSettingsConfigurationModel.AppLanguage(rawValue: config.appLanguage.wrappedValue) ?? .system
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    TextBuilder.makeText(AppTexts.selectLanguage, variant: .settingsTitle)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    TextBuilder.makeText(AppTexts.selectLanguageDescription, variant: .settingsNote)
                        .foregroundColor(.white.opacity(0.65))
                }
                VStack(spacing: 2) {
                    ForEach(UserSettingsConfigurationModel.AppLanguage.allCases, id: \.self) { languageOption in
                        VStack {
                            HStack {
                                TextBuilder.makeText(languageOption.rawValue, variant: selectedLanguage == languageOption ? .settingsDescription : .settingsNote)
                                    .fontWeight(selectedLanguage == languageOption ? .black : .light)
                            }
                            .padding(4)
                            .padding(.horizontal, 6)
                            .frame(width: ViewConstants.defaultWindowWidth * (selectedLanguage == languageOption ? 0.09 : 0.08))
                            .background(.gray.opacity(0.25))
                            .cornerRadius(12)
                        }
                        .onTapGesture {
                            guard selectedLanguage != languageOption else { return }
                            NotificationCenter.default.post(name: .didLocaleUpdate, object: nil)
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedLanguage = languageOption
                                config.appLanguage = languageOption.rawValue
                            }    
                        }
                    }
                }
            }
        }
        .frame(width: ViewConstants.defaultWindowWidth * 0.28, height: ViewConstants.defaultWindowHeight * 0.1)
    }
}
