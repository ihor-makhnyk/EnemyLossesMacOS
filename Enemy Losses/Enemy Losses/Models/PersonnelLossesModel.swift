//
//  PersonnelLossesModel.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import Foundation

struct PersonnelLossesModel: Codable, Hashable, Identifiable {
    let id = UUID()
    
    let date,
        personnelAbout: String
    let day,
        personnel: Int

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case day = "day"
        case personnel = "personnel"
        case personnelAbout = "personnel*"
    }
    
    static let mockData = [
        PersonnelLossesModel(
            date: "24-02-2022",
            personnelAbout: "about",
            day: 1,
            personnel: 1000000
        ),
        PersonnelLossesModel(
            date: "24-03-2022",
            personnelAbout: "Fight over Izium",
            day: 30,
            personnel: 20000000
        ),
    ]
}
