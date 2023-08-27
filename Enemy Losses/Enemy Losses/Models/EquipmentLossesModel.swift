//
//  EquipmentLossesModel.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import Foundation

struct EquipmentLossesModel: Codable, Hashable {
    let date: String
    let day,
        aircraft,
        helicopter,
        tank,
        apc,
        fieldArtillery,
        mrl,
        drone,
        navalShip,
        antiAircraftWarfare,
        specialEquipment,
        vehiclesAndFuelTanks,
        cruiseMissiles: Int?

    enum CodingKeys: String, CodingKey, CaseIterable, Hashable {
        case date = "date",
             day = "day",
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
    
    static let mockData = [EquipmentLossesModel(
        date: "24-02-2022",
        day: 1,
        aircraft: 2,
        helicopter: 3,
        tank: 4,
        apc: 5,
        fieldArtillery: 6,
        mrl: 7,
        drone: 8,
        navalShip: 9,
        antiAircraftWarfare: 10,
        specialEquipment: 11,
        vehiclesAndFuelTanks: 12,
        cruiseMissiles: 13
    ),]
}
