//
//  UserSettingsConfigurationModel.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 23.08.2023.
//

import Foundation

final class UserSettingsConfigurationModel {
    enum AppLanguage: String, Hashable, CaseIterable { case Ukrainian = "Ukrainian", English = "English", system = "System" }
    enum ImageFormat: String, Hashable, CaseIterable { case jpg = "jpg", png = "png", tiff = "tiff" }
    
    var cacheData: Bool = UserDefaults.standard.bool(forKey: Keys.cacheData.rawValue)
    { didSet { UserDefaults.standard.setValue(cacheData, forKey: Keys.cacheData.rawValue) } }
    
    var appLanguage: AppLanguage.RawValue =
    UserDefaults.standard.string(forKey: Keys.appLanguage.rawValue) ?? AppLanguage.system.rawValue
    { didSet {
        UserDefaults.standard.setValue(appLanguage, forKey: Keys.appLanguage.rawValue)
        Localizer.locale.setSelectedLanguage()
    } }
    
    var exportImageFormat: ImageFormat.RawValue = UserDefaults.standard.string(forKey: Keys.exportImageFormat.rawValue) ?? ImageFormat.jpg.rawValue
    { didSet { UserDefaults.standard.setValue(exportImageFormat, forKey: Keys.exportImageFormat.rawValue) } }

    var lossesDataElementsToShow: [EquipmentLossesModel.CodingKeys.RawValue] =
    UserDefaults.standard.array(forKey: Keys.lossesDataElementsToShow.rawValue) as? [EquipmentLossesModel.CodingKeys.RawValue]
    ??
    EquipmentLossesModel.CodingKeys.allCases.map { $0.rawValue }
    { didSet { UserDefaults.standard.set(lossesDataElementsToShow, forKey: Keys.lossesDataElementsToShow.rawValue) } }
    
    enum Keys: String {
        case cacheData = "cacheData",
             appLanguage = "appLanguage",
             exportImageFormat = "exportImageFormat",
             lossesDataElementsToShow = "lossesDataElementsToShow"
    }
    
}
