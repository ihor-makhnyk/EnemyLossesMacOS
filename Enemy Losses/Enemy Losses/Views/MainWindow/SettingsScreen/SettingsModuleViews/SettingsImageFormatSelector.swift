//
//  SettingsImageFormatSelector.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 24.08.2023.
//

import SwiftUI

struct SettingsImageFormatSelector: View {
    @State private var selectedFormat: UserSettingsConfigurationModel.ImageFormat
    
    init(config: Binding<UserSettingsConfigurationModel>) {
        self._config = config
        self.selectedFormat = UserSettingsConfigurationModel.ImageFormat(rawValue: config.exportImageFormat.wrappedValue) ?? .jpg
    }
    
    @Binding var config: UserSettingsConfigurationModel
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    TextBuilder.makeText(AppTexts.selectImageFormat, variant: .settingsTitle)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    TextBuilder.makeText(AppTexts.selectImageFormatDescription, variant: .settingsNote)
                        .foregroundColor(.white.opacity(0.65))
                }
                VStack(spacing: 2) {
                    ForEach(UserSettingsConfigurationModel.ImageFormat.allCases, id: \.self) { imageFormatOption in
                        VStack {
                            HStack {
                                TextBuilder.makeText(imageFormatOption.rawValue, variant: .settingsDescription).fontWeight(selectedFormat == imageFormatOption ? .black : .light)
                            }
                            .padding(4)
                            .padding(.horizontal, 6)
                            .frame(width: ViewConstants.defaultWindowWidth * (selectedFormat == imageFormatOption ? 0.09 : 0.08))
                            .background(.gray.opacity(0.25))
                            .cornerRadius(12)
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedFormat = imageFormatOption
                                config.exportImageFormat = imageFormatOption.rawValue
                            }
                        }
                    }
                }
            }
        }
        .frame(width: ViewConstants.defaultWindowWidth * 0.26, height: ViewConstants.defaultWindowHeight * 0.1)
    }
    
}
