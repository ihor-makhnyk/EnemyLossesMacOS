//
//  ViewConstants.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import AppKit

struct ViewConstants {
    //----------------------------------
    //MARK: - SCREEN
    //----------------------------------
    static let screenWidth = {
        guard let screen = NSScreen.main else { return CGFloat(0) }
        return screen.frame.size.width
    }()
    static let screenHeight = {
        guard let screen = NSScreen.main else { return CGFloat(0) }
        return screen.frame.size.width * 0.625
    }()
    static let screenSize: CGSize = CGSize(width: screenWidth, height: screenHeight)
    
    //----------------------------------
    //MARK: - WINDOW SIZING
    //----------------------------------
    // Main window
    static let defaultWindowWidth = screenWidth * 0.8
    static let defaultWindowHeight = screenHeight * 0.8
    static let defaultWindowSize: NSSize = NSSize(width: defaultWindowWidth, height: defaultWindowHeight)
    
    // List window
    static let listWindowWidth = screenWidth * 0.3
    static let listWindowHeight = screenHeight * 0.6
    static let listWindowHeightShadowCompensation = defaultWindowHeight * 0.9
    static let listWindowWidthShadowCompensation = defaultWindowWidth * 0.3
    
    static let listScrollViewSize = NSSize(width: defaultWindowWidth * 0.25, height: defaultWindowHeight * 0.797)
    static let listCellHeight = defaultWindowHeight * 0.09
    
    static let listWindowOffserX = defaultWindowWidth * 0.06
    static let listWindowOffserY = defaultWindowHeight * 0.035
    
    //---------------------------------
    //MARK: - HEADER
    //---------------------------------
    static let headerHeight = defaultWindowHeight * 0.086
    
    static let headerSettingsButtonWidth = defaultWindowWidth * 0.024
    static let headerSettingsButtonHeight = defaultWindowWidth * 0.024
    
    static let headerShareButtonWidth = defaultWindowWidth * 0.018
    static let headerShareButtonHeight = defaultWindowWidth * 0.0225
    
    static let headerCloseButtonWidth = defaultWindowWidth * 0.017
    static let headerCloseButtonHeight = defaultWindowWidth * 0.017
    
    static let headerPhotoButtonWidth = defaultWindowWidth * 0.024
    static let headerPhotoButtonHeight = defaultWindowWidth * 0.019
    
    static let headerHDividerHeight = defaultWindowWidth * 0.03
    
    static let headerPaddingBottom = defaultWindowHeight * 0.03
    static let headerButtonsTrailingPadding = defaultWindowWidth * 0.006
    static let headerEachButtonTrailingPadding = defaultWindowWidth * 0.01
    
    
    //---------------------------------
    //MARK: - DETAILS PANEL
    //---------------------------------
    static let detailsPanelContainerWidth = defaultWindowWidth * 0.75
    static let detailsPanelSize = NSSize(width: defaultWindowWidth * 0.77, height: defaultWindowHeight * 0.87)
    
    static let detailsPanelLeadingPadding = defaultWindowWidth * 0.22
    
    static let detailsPersonnelPanelWidth = defaultWindowWidth * 0.75
    static let detailsPersonnelPanelHeight = defaultWindowHeight * 0.84
    
    static let detailsEquipmentModuleMinHeight = defaultWindowHeight * 0.125
    static let detailsEquipmentModuleWidth = defaultWindowWidth * 0.245
    
    static let detailsPersonnelPanelPaddingTop = defaultWindowHeight * 0.585
    
    static let detailsGraphTitleWidth = detailsPanelContainerWidth * 0.6
    static let detailsGraphTitleOffset = defaultWindowHeight * 0.41
    
    static let customSystemButtonsOffset = CGSize(width: defaultWindowWidth * 0.001, height: -defaultWindowHeight * 0.018)
    
    //---------------------------------
    //MARK: - SETTINGS SCREEN
    //---------------------------------
    static let settingsModuleWidth = defaultWindowWidth * 0.8
    static let settingsModuleMinWidth = defaultWindowWidth * 0.28
    static let settingsModuleMaxWidth = defaultWindowWidth * 0.6
    
    static let settingsToggleViewHeight = defaultWindowHeight * 0.15
    static let settingsToggleViewTitleHeight = defaultWindowHeight * 0.05
    static let settingsToggleViewDescriptionMinWidth = defaultWindowWidth * 0.25
    static let settingsToggleViewDescriptionMaxWidth = defaultWindowWidth * 0.45
    static let settingsToggleViewDescriptionContainerHeight = defaultWindowHeight * 0.09
    
    static let settingsClearCacheButtonWidth = defaultWindowWidth * 0.1
    static let settingsClearCacheButtonHeight = defaultWindowHeight * 0.15
    
    
    static let settingsModuleHorizontalPadding = defaultWindowWidth * 0.1
    
}
