//
//  NetworkManager.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import Foundation

final class NetworkManager {
    
    func fetchPersonnel(from url: URL) async -> [PersonnelLossesModel]? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode([PersonnelLossesModel].self, from: data)
            return decodedData
        } catch {
            NSLog("Could not fetch personnel. Error: \(error)")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .loadingError, object: nil)                
            }
            return nil
        }
    }
    
    func fetchEquipment(from url: URL, at day: Int? = nil) async -> [EquipmentLossesModel]? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let day = day else {
                let decodedData = try JSONDecoder().decode([EquipmentLossesModel].self, from: data)
                return decodedData
            }
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for json in jsonObject {
                    if let personnelValue = json["day"] as? Int, personnelValue == day {
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                        let decodedData = try JSONDecoder().decode(EquipmentLossesModel.self, from: jsonData)
                        return [decodedData]
                    }
                }
            }
            return nil
        } catch {
            NSLog("Could not fetch equipment. Error: \(error)")
            return nil
        }
    }
    
    func fetchEquipmentCorrection(from url: URL, at day: Int) async -> [EquipmentLossesModel]? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for json in jsonObject {
                    if let personnelValue = json["day"] as? Int, personnelValue == day {
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                        let decodedData = try JSONDecoder().decode(EquipmentLossesModel.self, from: jsonData)
                        return [decodedData]
                    }
                }
            }
            return nil
        } catch {
            NSLog("Could not fetch equipment. Error: \(error)")
            return nil
        }
    }
    
    func clearNetworkCache() {
        URLCache.shared.removeAllCachedResponses()
    }
    
}
