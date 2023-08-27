//
//  DetailsPanelModuleViewFactory.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 22.08.2023.
//

import SwiftUI

struct DetailsPanelModuleViewFactory {
    
    enum DetailsPanelModuleType: EquipmentLossesModel.CodingKeys.RawValue {
        case day = "AppTexts.dayDataString",
             aircraft = "aircraft",
             helicopter = "helicopter",
             tank = "tank",
             apc = "APC",
             fieldArtillery = "field artillery",
             mrl = "MRL",
             drone =  "drone",
             navalShip = "naval ship",
             antiAircraftWarfare = "anti-aircraft warfare",
             specialEquipment = "special equipment",
             vehiclesAndFuelTanks = "vehicles and fuel tanks",
             cruiseMissiles = "cruise missiles"
    }
    
    //MARK: - RESULT LAYOUT
    func makeModuleLayout(with types: [DetailsPanelModuleType], models: (PersonnelLossesModel, EquipmentLossesModel), vm: DetailsPanelViewModel, expanded: Bool) -> some View {
        VStack {
            let availableTypes = validateDataIntegrity(for: models.1)
            let typesToShow = validateUserPreferences(availableTypes.filter { types.contains($0) })
            lazy var rows = Array(repeating: GridItem(alignment: .center), count: setNumberOfRows(typesToShow.count))
            PersonnelModuleView(isExpanded: expanded, graphData: vm.lossesDynamicDataForSelectedPeriod) {
                makePersonnelModule(models.0)
            }
            makeGrid(with: types, models: models, rows: rows)
        }
        .frame(width: ViewConstants.detailsPanelContainerWidth)
    }
    
    //MARK: - GRID
    private func makeGrid(with types: [DetailsPanelModuleType], models: (PersonnelLossesModel, EquipmentLossesModel), rows: [GridItem]) -> some View {
        LazyHGrid(rows: rows, alignment: .top, spacing: 2) {
            let availableTypes = validateDataIntegrity(for: models.1)
            let typesToShow = validateUserPreferences(availableTypes.filter { types.contains($0) })
            ForEach(typesToShow, id: \.self) { type in
                switch type {
                case .day:
                    EquipmentModuleView { makeDayModule(models.0.day) }
                case .aircraft:
                    EquipmentModuleView { makeAircraftModule(models.1.aircraft!) }
                case .helicopter:
                    EquipmentModuleView { makeHelicopterModule(models.1.helicopter!) }
                case .tank:
                    EquipmentModuleView { makeTankModule(models.1.tank!) }
                case .apc:
                    EquipmentModuleView { makeApcModule(models.1.apc!) }
                case .fieldArtillery:
                    EquipmentModuleView { makeFieldArtilleryModule(models.1.fieldArtillery!) }
                case .mrl:
                    EquipmentModuleView { makeMrlModule(models.1.mrl!) }
                case .drone:
                    EquipmentModuleView { makeDroneModule(models.1.drone!) }
                case .navalShip:
                    EquipmentModuleView { makeNavalShipModule(models.1.navalShip!) }
                case .antiAircraftWarfare:
                    EquipmentModuleView { makeAntiAircraftWarfareModule(models.1.antiAircraftWarfare!) }
                case .specialEquipment:
                    EquipmentModuleView { makeSpecialEquipmentModule(models.1.specialEquipment!) }
                case .vehiclesAndFuelTanks:
                    EquipmentModuleView { makeVehiclesAndFuelTanksModule(models.1.vehiclesAndFuelTanks!) }
                case .cruiseMissiles:
                    EquipmentModuleView { makeCruiseMissilesModule(models.1.cruiseMissiles!) }
                }
            }
        }
        .frame(width: ViewConstants.detailsPanelContainerWidth, height: ViewConstants.defaultWindowHeight * 0.56)
        
        
    }
    
    //MARK: - DATA INTEGRITY
    private func validateDataIntegrity(for data: EquipmentLossesModel) -> [DetailsPanelModuleType] {
        var availableTypes: [DetailsPanelModuleType] = []
        
        func validate(data: Any?, isValid: @escaping () -> Void) {
            if data != nil
            {
                if let data = data as? Int, data != -1 && data != 0 {
                    isValid()
                }
            }
            
        }
        validate(data: data.day) { availableTypes.append(.day) }
        validate(data: data.aircraft) { availableTypes.append(.aircraft) }
        validate(data: data.helicopter) { availableTypes.append(.helicopter) }
        validate(data: data.tank) { availableTypes.append(.tank) }
        validate(data: data.apc) { availableTypes.append(.apc) }
        validate(data: data.fieldArtillery) { availableTypes.append(.fieldArtillery) }
        validate(data: data.mrl) { availableTypes.append(.mrl) }
        validate(data: data.drone) { availableTypes.append(.drone) }
        validate(data: data.navalShip) { availableTypes.append(.navalShip) }
        validate(data: data.antiAircraftWarfare) { availableTypes.append(.antiAircraftWarfare) }
        validate(data: data.specialEquipment) { availableTypes.append(.specialEquipment) }
        validate(data: data.vehiclesAndFuelTanks) { availableTypes.append(.vehiclesAndFuelTanks) }
        validate(data: data.cruiseMissiles) { availableTypes.append(.cruiseMissiles) }
        
        
        return availableTypes
    }
    
    private func validateUserPreferences(_ data: [DetailsPanelModuleType]) -> [DetailsPanelModuleType] {
        var typesToShow: [DetailsPanelModuleType] = []
        let settingsTypes: [DetailsPanelModuleType] = UserSettingsConfigurationModel().lossesDataElementsToShow.compactMap{ DetailsPanelModuleType(rawValue: $0) }
        typesToShow.append(contentsOf: settingsTypes)
        return data.filter { typesToShow.contains($0) }
    }
    
    private func setNumberOfRows(_ itemCount: Int) -> Int {
        return itemCount > 9 ? 4 : itemCount > 6 ? 3 : itemCount > 3 ? 2 : itemCount > 0 ? 1 : 0
    }
    
    //MARK: - Personnel module
    private func makePersonnelModule(_ personnelLosses: PersonnelLossesModel) -> some View {
        VStack {
            HStack {
                VStack {
                    HStack(alignment: .bottom, spacing: 0) {
                        TextBuilder.makeText(AppTexts.asOf, variant: .detailsDescription)
                        TextBuilder.makeText("\(personnelLosses.date)", variant: .detailsDate)
                        Spacer()
                    }
                    Spacer()
                    HStack(alignment: .bottom, spacing: 0) {
                        TextBuilder.makeText(AppTexts.day, variant: .detailsDescription).opacity(0.8).offset(y: -3)
                        TextBuilder.makeText("\(personnelLosses.day)", variant: .detailsTitle)
                        Spacer()
                    }
                }
                Spacer()
                VStack {
                    Spacer()
                    HStack(alignment: .bottom, spacing: 0) {
                        TextBuilder.makeText(AppTexts.personnel, variant: .detailsPersonnelText).opacity(0.8).offset(y: -5)
                        TextBuilder.makeText("\(personnelLosses.personnel)", variant: .detailsPersonnelValue)
                    }
                }
            }
        }.zIndex(17)
    }
    
    //MARK: - Default module text maker
    private func makeDefaultModuleText(_ string: String, with value: Int) -> some View {
        HStack {
            VStack(alignment: .leading) {
                TextBuilder.makeText(string, variant: .subtitle).opacity(0.8)
            }.frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.6)
            VStack {
                TextBuilder.makeText("\(value)", variant: .title)
                    .padding(.trailing, 12)
            }.frame(width: (ViewConstants.defaultWindowWidth * 0.245) * 0.4)
        }
    }
    
    //MARK: - DAY
    private func makeDayModule(_ dayCount: Int) -> some View {
        ZStack {
            makeDefaultModuleText(AppTexts.day, with: dayCount)
        }
    }
    //MARK: - Aircraft
    private func makeAircraftModule(_ aircraftLosses: Int) -> some View {
        ZStack {
            Image(AppImages.aircraft)
                .aircraftModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.aircraft, with: aircraftLosses)
        }
    }
    //MARK: - Helicopter
    private func makeHelicopterModule(_ helicopterLosses: Int) -> some View {
        ZStack {
            Image(AppImages.helicopter)
                .helicopterModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.helicopters, with: helicopterLosses)
        }
        
    }
    //MARK: - Tank
    private func makeTankModule(_ tankLosses: Int) -> some View {
        ZStack {
            Image(AppImages.tanks)
                .tankModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.tanks, with: tankLosses)
        }
    }
    //MARK: - APC
    private func makeApcModule(_ apcLosses: Int) -> some View {
        ZStack {
            Image(AppImages.apc)
                .apcModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.apcs, with: apcLosses)
        }
        
    }
    //MARK: - Field Artillery
    private func makeFieldArtilleryModule(_ fieldArtilleryLosses: Int) -> some View {
        ZStack {
            Image(AppImages.fieldArtillery)
                .fieldArtilleryModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.fieldArtillery, with: fieldArtilleryLosses)
        }
        
    }
    //MARK: - MRL
    private func makeMrlModule(_ mrlLosses: Int) -> some View {
        ZStack {
            Image(AppImages.mrl)
                .mrlModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.mrls, with: mrlLosses)
        }
        
    }
    //MARK: - Drone
    private func makeDroneModule(_ droneLosses: Int) -> some View {
        ZStack {
            Image(AppImages.drone)
                .droneModuleImageConfiguration(imageNumber: 1)
            Image(AppImages.drone)
                .droneModuleImageConfiguration(imageNumber: 2)
            Image(AppImages.drone)
                .droneModuleImageConfiguration(imageNumber: 3)
            Image(AppImages.drone)
                .droneModuleImageConfiguration(imageNumber: 4)
            makeDefaultModuleText(AppTexts.drones, with: droneLosses)
        }
        
    }
    //MARK: - Naval ship
    private func makeNavalShipModule(_ navalShipLosses: Int) -> some View {
        ZStack {
            Image(AppImages.navalShip)
                .navalShipModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.navalShips, with: navalShipLosses)
        }
        
    }
    //MARK: - Anti Aircraft
    private func makeAntiAircraftWarfareModule(_ antiAircraftWarfareLosses: Int) -> some View {
        ZStack {
            Image(AppImages.antiAircraft)
                .antiAircraftWarfareModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.antiAircraftWarfare, with: antiAircraftWarfareLosses)
        }
        
    }
    //MARK: - Special Equipment
    private func makeSpecialEquipmentModule(_ specialEquipmentLosses: Int) -> some View {
        ZStack {
            Image(AppImages.specialEquipment)
                .specialEquipmentModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.specialEquipment, with: specialEquipmentLosses)
        }
        
    }
    //MARK: - Vehicles
    private func makeVehiclesAndFuelTanksModule(_ vehiclesAndFuelTanksLosses: Int) -> some View {
        ZStack {
            Image(AppImages.vehicle)
                .vehiclesAndFuelTanksModuleImageConfiguration()
            makeDefaultModuleText(AppTexts.vehiclesAndFuelTanks, with: vehiclesAndFuelTanksLosses)
        }
        
    }
    //MARK: - Cruise missiles
    private func makeCruiseMissilesModule(_ cruiseMissilesLosses: Int) -> some View {
        ZStack {
            Image(AppImages.cruiseMissile)
                .cruiseMissilesModuleImageConfiguration(imageCount: 1)
            Image(AppImages.cruiseMissile)
                .cruiseMissilesModuleImageConfiguration(imageCount: 2)
            makeDefaultModuleText(AppTexts.cruiseMissiles, with: cruiseMissilesLosses)
        }
    }
}

