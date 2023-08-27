//
//  SettingsDataParameterSelectorView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 23.08.2023.
//

import SwiftUI

struct SettingsDataParameterSelector: View {
    @Binding var config: UserSettingsConfigurationModel
    @State private var updatesId: Int = 0
    @State private var allElements: [ [EquipmentLossesModel.CodingKeys] ] = [[], [], [], [], []]
    
    var body: some View {
        VStack(alignment: .center) {
            TextBuilder.makeText(AppTexts.howMuchDataToShow, variant: .settingsTitle)
                .padding(4)
            TextBuilder.makeText(AppTexts.pickDataForMainScreen, variant: .settingsDescription)
                .padding(4)
                .padding(.bottom, 6)
            ForEach(0..<3) { rowArray in
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack {
                        if !allElements[Int(rowArray)].isEmpty {
                            HStack {
                                if rowArray == 0 {
                                    SettingsDataParameterSelectorCell(itemName: AppTexts.selectAll, $config, updatesId: $updatesId) { updatesId += 1 }
                                }
                                ForEach(allElements[Int(rowArray)], id: \.self) { lossesItem in
                                    SettingsDataParameterSelectorCell(itemName: lossesItem.rawValue, $config, updatesId: $updatesId) { updatesId += 1 }
                                }
                                Spacer().frame(width: ViewConstants.defaultWindowWidth * 0.02)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .frame(height: ViewConstants.defaultWindowHeight * 0.07)
                }
                .frame(width: ViewConstants.defaultWindowWidth * 0.6)
            }
            .onAppear {
                configureRows()
            }
        }
        .frame(width: ViewConstants.defaultWindowWidth * 0.6)
    }

    private func configureRows() {
        allElements = [[.aircraft, .antiAircraftWarfare, .drone,],
                       [.cruiseMissiles, .apc, .helicopter, .tank, .fieldArtillery,],
                       [.navalShip, .mrl, .specialEquipment, .vehiclesAndFuelTanks,]]
    }
}

struct SettingsDataParameterSelectorCell: View {
    @Binding var config: UserSettingsConfigurationModel
    var itemName: String
    
    @State private var isSelected = true
    @State private var isClicked = false
    @Binding var updatesId: Int
    
    private let sound = NSSound(named: "Frog")
    
    var isSelectAllCell: Bool
    var allSelectedCallback: (() -> Void)?
    
    init(itemName: String, _ config: Binding<UserSettingsConfigurationModel>, updatesId: Binding<Int>, allSelectedCallback: (() -> Void)? = nil) {
        self._config = config
        self.itemName = itemName
        self.isSelectAllCell = itemName == AppTexts.selectAll
        self._updatesId = updatesId
        self.allSelectedCallback = allSelectedCallback
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: isSelected ? AppImages.checkmarkSelected : AppImages.checkmarkNotSelected)
                    .resizable()
                    .foregroundColor(.white.opacity(isSelected ? 1 : 0.7))
                    .frame(width: ViewConstants.defaultWindowWidth * 0.015, height: ViewConstants.defaultWindowWidth * 0.015)
                    .onAppear { validateSelection() }
                TextBuilder.makeText(capitalize(isSelectAllCell ? (isSelected ? AppTexts.deselectAll : itemName) : itemName), variant: .settingsTitle)
                    .lineLimit(1)
                    .foregroundColor(.white.opacity(isSelected ? 1 : 0.7))
            }
        }
        .padding()
        .background(isSelectAllCell ? .black.opacity(isClicked ? 0.45 : 0.55) : .gray.opacity(isClicked ? 0.35 : 0.25))
        .cornerRadius(28)
        .scaleEffect(isClicked ? 0.97 : 1)
        .onChange(of: updatesId) { _ in validateSelection()}
        .onTapGesture { manageSelection() }
    }
    
    private func validateSelection() {
        if isSelectAllCell {
            isSelected = config.lossesDataElementsToShow.count == 12
        } else {
            isSelected = config.lossesDataElementsToShow.contains { $0 == itemName }
        }
    }
    
    private func manageSelection() {
        if !isSelectAllCell {
            if isSelected {
                config.lossesDataElementsToShow.removeAll(where: { $0 == itemName })
            } else {
                config.lossesDataElementsToShow.append(itemName)
            }
        } else {
            if isSelected {
                config.lossesDataElementsToShow = []
            } else {
                config.lossesDataElementsToShow = []
                EquipmentLossesModel.CodingKeys.allCases.forEach {
                    if $0 != .day && $0 != .date {
                        config.lossesDataElementsToShow.append($0.rawValue)
                    }
                }
            }
        }
        playSound()
        withAnimation(.easeInOut(duration: 0.1)) { isClicked.toggle(); isSelected.toggle() }
        withAnimation(.easeOut(duration: 0.15).delay(0.1)) { isClicked.toggle() }
        guard let allSelectedCallback else { return }
        allSelectedCallback()
    }
    
    private func playSound() {
        DispatchQueue.main.async {
            guard let sound else { return }
            sound.stop()
            sound.volume = 0.12
            sound.play()
        }
    }
    
    private func capitalize(_ text: String) -> String {
        if let firstLetter = text.first, firstLetter.isUppercase { return text } else { return text.capitalized }
    }
    
}
