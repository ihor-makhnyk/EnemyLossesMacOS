//
//  AppStrings.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 26.08.2023.
//

import Foundation

final class Localizer {
    static let locale = Localizer()
    
    private(set) var selectedLanguage: String?
    
    private init() { setSelectedLanguage() }
    
    func setSelectedLanguage() {
        let config = UserSettingsConfigurationModel()
        if config.appLanguage == "Ukrainian" {
           selectedLanguage = "uk"
        } else if config.appLanguage == "English" {
            selectedLanguage = "en"
        } else {
            selectedLanguage = nil
        }
    }
    
}

struct AppTexts {
    static let welcome = "Welcome to"
    
    /* Pesonnel Losses */
    static let day = "Day: " 
    static let asOf = "As of "

    /* Equipment Losses */
    static let mrls = "MRLs: "
    static let apcs = "APCs: "
    static let tanks = "Tanks: "
    static let drones = "Drones: "
    static let aircraft = "Aircraft: "
    static let personnel = "Personnel: "
    static let helicopters = "Helicopters: "
    static let navalShips = "Naval ships: "
    static let cruiseMissiles = "Cruise missiles: "
    static let fieldArtillery = "Field Artillery: "
    static let specialEquipment = "Special equipment: "
    static let antiAircraftWarfare = "Anti-aircraft Warfare: "
    static let vehiclesAndFuelTanks = "Vehicles and fuel tanks: "
    
    /* Personnel losses graph */
    static let graphTitle = "Enemy losses trend by months'"
    static let graphDescription = "Each segment of the graph shows the change in the average value of enemy personnel losses per day during the month"

    /* List indications */
    static let lastYear = "Last year"
    static let theBeginning = "The beginning"
    static let lowOnNetwork = "Oh shoot.. Seems like you're low on Network."

    /* No data texts */
    static let noDataHere = "No data here...."

    /* Settings */
    static let donateButton = "Donate Now"
    static let clearCache = "Clear cache"
    static let clearCacheSuccess = "All good"
    static let selectImageFormat = "Image format:"
    static let saveDataToCache = "Save data to cache?"
    static let selectLanguage = "Choose your language:"
    static let howMuchDataToShow = "How much data to show?"
    static let pickDataForMainScreen = "Feel free to pick data which you want to see on the main screen."
    static let selectLanguageDescription = "NOTE. If you select 'system' option it will set according to the language of your Mac."
    static let selectImageFormatDescription = "Select the format in which you prefer to export your images. \nNOTE: 'jpg' is the fastest."
    static let donateBannerText = "Ukrainian warriors laid thousands of their lives as well. To protect you and your country they keep doing it every single day."
    static let saveDataToCacheDescription = "We will save your loaded losses data to the app cache folder, so that you won't need to use internet to load it and will have access to this data when offline."

    /* Watermark */
    static let watermark = "Made with love by Ihor Makhnyk – 2023"
    
    /* About */
    static let aboutTitle = "Hi, my name is Ihor."
    static let aboutCoverText = "I've been developing this app for exactly one week in terms of test task for Bootcamp at MacPaw ltd. with a goal not to just make it do a simple function, but to deliver a quality product with attention to detail. Undoubtedly there is still a lot of room for improvement and development, as well as fixing bugs and adapting it for older MacOS versions. Here is small list of what it can do, hope you enjoy it. ❤️"
    static let aboutOverview = "See enemy losses since the beginning of the full fledged invasion. Some data have been modified later, corrections have been applied. The app shows you the most relevant data."
    static let aboutGraph = "Click on the biggest box where personnel data losses are shown to use an interactive chart. It takes values for each day in month period and finds an average value personnel losses."
    static let aboutImages = "Copy to clipboard or save to desktop picture of the data from a certain day. You can customize your layout and choose the best export format option for you from: jpg, png or tiff."
    static let aboutCache = "Manage your data usage in a better way. You can save data to app cache, so that it available to you even offline. You'll be able to clean your cache at anytime."
    
    static let savedToDesktop = "Saved to desktop ☑️"
    static let copiedToClipboard = "Copied to clipboard 📄"
    
    static let selectAll = "Select all"
    static let deselectAll = "Deselect all"
    
    /* Tooltips */
    static let photoTooltip = "Hold to copy.\nClick to save to desktop"
    static let shareTooltip = "Share"
    static let closeTooltip = "[ESC] Close"
    static let settingsTooltip = "Settings"
    
}

struct AppImages {
    
    static let aircraft = "Aircraft"
    static let helicopter = "Helicopter"
    static let tanks = "Tanks"
    static let apc = "APC"
    static let fieldArtillery = "FieldArtillery"
    static let mrl = "MRL"
    static let drone = "Drone"
    static let navalShip = "NavalShip"
    static let antiAircraft = "AntiAircraft"
    static let specialEquipment = "SpecialEquipment"
    static let vehicle = "Vehicle"
    static let cruiseMissile = "CruiseMissile"
    static let personnel = "Personnel"
    
    static let close = "xmark"
    static let delete = "trash"
    static let settings = "gear"
    static let camera = "camera"
    static let refresh = "arrow.clockwise"
    static let minituarize = "minus"
    static let checkmark = "checkmark"
    static let share = "square.and.arrow.up"
    static let checkmarkNotSelected = "checkmark.circle"
    static let checkmarkSelected = "checkmark.circle.fill"
    
    static let developer = "Developer"
    static let lookupData = "doc.text.magnifyingglass"
    static let chartLine = "chart.line.uptrend.xyaxis"
    static let detailscamera = "camera"
    static let cache = "memorychip"
    
}
