//
//  DataService.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import Foundation
import CoreData
import AppKit
import Social

final class DataService {
    static let shared = DataService()
    private init() {}
    
    private let networkManager = NetworkManager()
    private let cacheManager = CacheManager()
    
    var selectedPersonnelModel: PersonnelLossesModel?
    
    var isDetailsPanelExpandedForImage: Bool = false
    
    var shouldCache: Bool = true
    private var shouldEquipmentCache: Bool = true
    
    func clearAllCaches() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            networkManager.clearNetworkCache()
            clearPersonnelCache()
            clearEquipmentCache()
            NotificationCenter.default.post(name: .allCachesCleared, object: nil)
        }
        
    }
    
    //---------------------
    //MARK: - Personnel
    //---------------------
    
    func loadPersonnel(completion: @escaping ([PersonnelLossesModel]?) -> Void) {
        let urlPersonnel = DataSources.personnelLossesDatasource
        guard let url = URL(string: urlPersonnel) else {
            completion(nil)
            return
        }
        
        Task {
            guard let appDelegate = await NSApplication.shared.delegate as? AppDelegate else { fatalError("Couldn't access appDelegate") }
            let context = appDelegate.persistentContainer.newBackgroundContext()
            
            do {
                getCachedPersonnel(in: context) { cachedPersonnel in
                    if let cachedPersonnel {
                        if !cachedPersonnel.isEmpty {
                            completion(cachedPersonnel)
                            self.shouldCache = false
                        } else {
                            completion(nil)
                        }
                        return
                    }
                }
                
                let personnelLossesList = await networkManager.fetchPersonnel(from: url)
                if let personnelLossesList, !personnelLossesList.isEmpty {
                    completion(personnelLossesList)
                }
                guard let personnelLossesList = personnelLossesList else { return }
                try cachePersonnel(personnelLossesList, in: context)
            } catch {
                NSLog("Error: \(error)")
                completion(nil)
            }
        }
    }
    
    private func cachePersonnel(_ personnelData: [PersonnelLossesModel], in context: NSManagedObjectContext) throws {
        if UserDefaults.standard.bool(forKey: UserSettingsConfigurationModel.Keys.cacheData.rawValue), self.shouldCache {
            cacheManager.deletePersonnel()
            try context.performAndWait {
                personnelData.forEach { personnelItem in
                    cacheManager.savePersonnel(model: personnelItem, in: context)
                }
                try context.save()
                self.shouldCache = false
            }
        }
    }
    
    private func getCachedPersonnel(in context: NSManagedObjectContext, completion: @escaping ([PersonnelLossesModel]?) -> Void) {
        if UserDefaults.standard.bool(forKey: UserSettingsConfigurationModel.Keys.cacheData.rawValue) {
            let cachedPersonnel = Array(Set(cacheManager.fetchPersonnel(in: context))).sorted(by: { $0.day < $1.day })
            completion(cachedPersonnel)
        }
    }
    
    private func clearPersonnelCache() {
        cacheManager.deletePersonnel()
        shouldCache = true
        shouldEquipmentCache = true
    }
    
    //---------------------
    //MARK: - Equipment
    //---------------------
    
    func loadEquipment(for day: Int? = nil, _ completion: @escaping ([EquipmentLossesModel]?) -> Void) {
        let urlEquipment = DataSources.equipmentLossesDatasource
        let urlEquipmentCorrection = DataSources.equipmentLossesCorrectionsDatasource
        
        guard let baseUrl = URL(string: urlEquipment), let correctionUrl = URL(string: urlEquipmentCorrection) else { return }
        Task {
            guard let appDelegate = await NSApplication.shared.delegate as? AppDelegate else { fatalError("Couldn't access appDelegate") }
            let context = appDelegate.persistentContainer.newBackgroundContext()
            var shouldUseNetwork: Bool = true
            do {
                if let day = day {
                    getCachedEquipment(for: day, in: context) { cachedEquipment in
                        if let cachedEquipment {
                            completion([cachedEquipment])
                            shouldUseNetwork = false
                        } else {
                            shouldUseNetwork = true
                        }
                        return
                    }
                    if shouldUseNetwork {
                        let equipmentLosses = await networkManager.fetchEquipment(from: baseUrl, at: day)
                        let equipmentLossesCorrection = await networkManager.fetchEquipmentCorrection(from: correctionUrl, at: day)
                        if let equipmentLosses, !equipmentLosses.isEmpty {
                            completion(mergeEquipmentDataWithCorrectionIfNeeded(data: equipmentLosses, correction: equipmentLossesCorrection))
                            guard let equipmentItem = equipmentLosses.first else { return }
                            try cacheEquipment(equipmentItem, in: context)
                        } else {
                            completion(nil)
                        }
                    }
                } else {
                    let equipmentLosses = await networkManager.fetchEquipment(from: baseUrl)
                    completion(equipmentLosses)
                }
            } catch {
                NSLog("Error: \(error)")
                completion(nil)
            }
            
        }
    }
    
    func cacheEquipment(_ equipmentData: EquipmentLossesModel, in context: NSManagedObjectContext) throws {
        if UserDefaults.standard.bool(forKey: UserSettingsConfigurationModel.Keys.cacheData.rawValue), self.shouldEquipmentCache {
            try context.performAndWait {
                cacheManager.saveEquipment(model: equipmentData, in: context)
                try context.save()
            }
        }
    }
    
    func getCachedEquipment(for day: Int? = nil, in context: NSManagedObjectContext, completion: @escaping (EquipmentLossesModel?) -> Void) {
        if UserDefaults.standard.bool(forKey: UserSettingsConfigurationModel.Keys.cacheData.rawValue) {
            guard let day = day else { completion(nil); return }
            let cachedEquipment = cacheManager.fetchEquipment(for: day, in: context)
            completion(cachedEquipment)
        }
    }
    
    private func mergeEquipmentDataWithCorrectionIfNeeded(data: [EquipmentLossesModel]?, correction: [EquipmentLossesModel]?) -> [EquipmentLossesModel]? {
        guard let correction = correction?.first else { return data }
        guard let data = data?.first else { return nil }
         return [EquipmentLossesModel(
            date: data.date,
            day: data.day,
            aircraft: (data.aircraft ?? 0) + (correction.aircraft ?? 0),
            helicopter: (data.helicopter ?? 0) + (correction.helicopter ?? 0),
            tank: (data.tank ?? 0) + (correction.tank ?? 0),
            apc: (data.apc ?? 0) + (correction.apc ?? 0),
            fieldArtillery: (data.fieldArtillery ?? 0) + (correction.fieldArtillery ?? 0),
            mrl: (data.mrl ?? 0) + (correction.mrl ?? 0),
            drone: (data.drone ?? 0) + (correction.drone ?? 0),
            navalShip: (data.navalShip ?? 0) + (correction.navalShip ?? 0),
            antiAircraftWarfare: (data.antiAircraftWarfare ?? 0) + (correction.antiAircraftWarfare ?? 0),
            specialEquipment: (data.specialEquipment ?? 0) + (correction.specialEquipment ?? 0),
            vehiclesAndFuelTanks: (data.vehiclesAndFuelTanks ?? 0) + (correction.vehiclesAndFuelTanks ?? 0),
            cruiseMissiles: (data.cruiseMissiles ?? 0) + (correction.cruiseMissiles ?? 0)
         )
        ]
    }
    
    private func clearEquipmentCache() {
        cacheManager.deleteEquipment()
    }
    
}
