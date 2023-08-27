//
//  Notification+.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import Foundation

extension NSNotification.Name {
    static let didPersonnelLossesLoad = NSNotification.Name("EL-didPersonnelLoad")
    static let shouldPersonnelLossesLoad = NSNotification.Name("EL-shouldPersonnelLoad")
    static let didEquipmentLossesLoad = NSNotification.Name("EL-didEquipmentLoad")
    static let shouldEquipmentLossesLoad = NSNotification.Name("EL-shouldEquipmentLoad")
    
    static let loadingError = NSNotification.Name("EL-loadingError")
    
    static let shouldToggleListWindowAppearance = NSNotification.Name("EL-shouldToggleListWindowAppearance")
    
    static let allCachesCleared = NSNotification.Name("EL-allCachesCleared")
    
    static let didLocaleUpdate = NSNotification.Name("EL-didLocaleUpdate")
    
    static let shouldTakePicture = NSNotification.Name("EL-shouldTakePicture")
    
    static let shouldToggleAboutWindow = NSNotification.Name("EL-shouldToggleAboutWindow")
    
}
