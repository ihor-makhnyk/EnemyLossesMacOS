//
//  ViewModifiers.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

//---------------------------------------
// MARK: - VIEW + window size configs
//---------------------------------------
extension View {
    
    func mainWindowConfiguration() -> some View {
        self
            .frame(width: ViewConstants.defaultWindowSize.width, height: ViewConstants.defaultWindowSize.height)
            .background(Rectangle().fill(.ultraThickMaterial))
            .preferredColorScheme(.dark)
            .cornerRadius(31)
    }
    func mainLossesListConfiguration() -> some View {
        self
            .scrollContentBackground(.hidden)
            .frame(width: ViewConstants.listScrollViewSize.width, height: ViewConstants.listScrollViewSize.height)
            .background(.thinMaterial)
            .cornerRadius(31)
            .preferredColorScheme(.dark)
    }
}

//---------------------------------------
// MARK: - IMAGE + details panel configs
//---------------------------------------
extension Image {

    func personnelModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
            .opacity(0.2)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.76)
            .allowsHitTesting(false)
    }
    
    
    //MARK: - Aircraft
    func aircraftModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .rotationEffect(Angle(degrees: 20))
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.2, y: -8)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.75)
    }

    //MARK: - Helicopter
    func helicopterModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.3, y: -6)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.73)
    }
    
    //MARK: - Tank
    func tankModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.2, y: -1)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.7)
    }
    
    //MARK: - APC
    func apcModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.3, y: -1)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.55)
    }
    
    //MARK: - MRL
    func mrlModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.23, y: 8)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.48)
    }
    
    //MARK: - Drone
    func droneModuleImageConfiguration(imageNumber: Int) -> some View {
        switch imageNumber {
        case 1:
            return self
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .opacity(0.2)
                .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.05, y: 4)
                .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.16)
        case 2:
            return self
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .opacity(0.2)
                .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.42, y: 7)
                .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.14)
        case 3:
            return self
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                .opacity(0.2)
                .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.25, y: -14)
                .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.35)
        case 4:
            return self
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .opacity(0.2)
                .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.2, y: 28)
                .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.25)
        default:
            return self
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .opacity(0.2)
                .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.05, y: 4)
                .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.16)
        }
    }
    
    //MARK: - Field Artillery
    func fieldArtilleryModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.25)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.14, y: 10)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.85)
    }
    
    //MARK: - Naval ship
    func navalShipModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.16, y: 8)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.8)
    }
    
    //MARK: - Anti aircraft
    func antiAircraftWarfareModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.26, y: 8)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.6)
    }
    
    //MARK: - Special equipment
    func specialEquipmentModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.28, y: 8)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.6)
    }
    
    //MARK: - Vehicles and fuel tanks
    func vehiclesAndFuelTanksModuleImageConfiguration() -> some View {
        self
            .resizable()
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .scaleEffect(x: -1)
            .opacity(0.2)
            .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.26, y: 8)
            .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.52)
    }
    
    //MARK: - Cruise missile
    func cruiseMissilesModuleImageConfiguration(imageCount: Int) -> some View {
        switch imageCount {
        case 1:
            return self
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                .scaleEffect(x: -1)
                .rotationEffect(Angle(degrees: -70))
                .opacity(0.2)
                .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.36, y: 2)
                .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.7)
        case 2:
            return self
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .scaleEffect(x: -1)
                .rotationEffect(Angle(degrees: -70))
                .opacity(0.2)
                .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.4, y: 60)
                .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.5)
        default:
            return self
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                .scaleEffect(x: -1)
                .rotationEffect(Angle(degrees: -70))
                .opacity(0.2)
                .offset(x: (ViewConstants.defaultWindowWidth * 0.25) * 0.36, y: 2)
                .frame(width: (ViewConstants.defaultWindowWidth * 0.25) * 0.7)
        }
    }
    
    
    
}

//-------------------------------------------
// MARK: - VSTACK + shadow size compensation
//-------------------------------------------
extension VStack {
    
    func compensateSizeForMainLossesListShadow() -> some View {
        self.frame(width: ViewConstants.listWindowWidthShadowCompensation, height: ViewConstants.listWindowHeightShadowCompensation)
    }
    
}

