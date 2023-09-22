//
//  CacheManager.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 24.08.2023.
//

import Foundation
import CoreData
import AppKit

final class CacheManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EnemyLossesDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //---------------------
    //MARK: - Personnel
    //---------------------
    func savePersonnel(model: PersonnelLossesModel, in context: NSManagedObjectContext) {
        let personnel = PersonnelLosses(context: context)
        personnel.date = model.date
        personnel.day = Int16(model.day)
        personnel.personnel = Int32(model.personnel)
        
        do {
            try context.save()
        } catch {
            NSLog("[PERSONNEL] Couldn't save: \(error)")
        }
    }
    
    func fetchPersonnel(in context: NSManagedObjectContext) -> [PersonnelLossesModel] {
        let fetchRequest: NSFetchRequest<PersonnelLosses> = PersonnelLosses.fetchRequest()
        var personnelLossesList: [PersonnelLossesModel] = []
        
        do {
            let personnelFetchResult = try context.fetch(fetchRequest)
            for personnelItem in personnelFetchResult {
                guard let date = personnelItem.date else { continue }
                personnelLossesList.append(PersonnelLossesModel(date: date, personnelAbout: "about", day: Int(personnelItem.day), personnel: Int(personnelItem.personnel)))
            }
        } catch {
            NSLog("[PERSONNEL] Couldn't fetch: \(error)")
        }
        
        return personnelLossesList
    }
    
    func deletePersonnel() {
        let fetchReq: NSFetchRequest<NSFetchRequestResult> =  NSFetchRequest.init(entityName:"PersonnelLosses")
        let context = persistentContainer.viewContext
        
        do {
            let personnelFetchResult = try context.fetch(fetchReq)
            personnelFetchResult.forEach { item in
                guard let item = item as? NSManagedObject else { return }
                context.delete(item)
            }
            
            do {
                try context.save()
            } catch {
                NSLog("[PERSONNEL] Couldn't update data during deletion: \(error)")
            }
            
        } catch {
            NSLog("[PERSONNEL] Deletion failed with error: \(error)")
        }
    }
    
    //---------------------
    //MARK: - Equipment
    //---------------------
    func saveEquipment(model: EquipmentLossesModel, in context: NSManagedObjectContext) {
        guard fetchEquipment(for: model.day, in: context) == nil else { return }
        let equipment = EquipmentLosses(context: context)
        equipment.day = Int16(model.day ?? -1)
        equipment.apc = Int32(model.apc ?? -1)
        equipment.mrl = Int32(model.mrl ?? -1)
        equipment.tank = Int32(model.tank ?? -1)
        equipment.drone = Int32(model.drone ?? -1)
        equipment.aircraft = Int32(model.aircraft ?? -1)
        equipment.naval_ship = Int32(model.navalShip ?? -1)
        equipment.helicopter = Int32(model.helicopter ?? -1)
        equipment.cruise_missiles = Int32(model.cruiseMissiles ?? -1)
        equipment.field_artillery = Int32(model.fieldArtillery ?? -1)
        equipment.special_equipment = Int32(model.specialEquipment ?? -1)
        equipment.anti_aircraft_warfare = Int32(model.antiAircraftWarfare ?? -1)
        equipment.vehicles_and_fuel_tanks = Int32(model.vehiclesAndFuelTanks ?? -1)
        
        do {
            try context.save()
        } catch {
            NSLog("[EQUIPMENT] Couldn't save: \(error)")
        }
    }
    
    func fetchEquipment(for day: Int? = nil, in context: NSManagedObjectContext) -> EquipmentLossesModel? {
        guard let day = day else { return nil }
        let fetchRequest = EquipmentLosses.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "day == %d", Int16(day))
        var equipmentLosses: EquipmentLossesModel?
        
        do {
            let equipmentFetchResult = try context.fetch(fetchRequest)
            
            guard let equipmentItem = equipmentFetchResult.first else { return nil }
            equipmentLosses = EquipmentLossesModel(date: equipmentItem.date ?? "no date",
                                                   day: Int(equipmentItem.day),
                                                   aircraft: Int(equipmentItem.aircraft),
                                                   helicopter: Int(equipmentItem.helicopter),
                                                   tank: Int(equipmentItem.tank),
                                                   apc: Int(equipmentItem.apc),
                                                   fieldArtillery: Int(equipmentItem.field_artillery),
                                                   mrl: Int(equipmentItem.mrl),
                                                   drone: Int(equipmentItem.drone),
                                                   navalShip: Int(equipmentItem.naval_ship),
                                                   antiAircraftWarfare: Int(equipmentItem.anti_aircraft_warfare),
                                                   specialEquipment: Int(equipmentItem.special_equipment),
                                                   vehiclesAndFuelTanks: Int(equipmentItem.vehicles_and_fuel_tanks),
                                                   cruiseMissiles: Int(equipmentItem.cruise_missiles)
            )
        } catch {
            NSLog("[EQUIPMENT] Couldn't fetch: \(error)")
        }
        
        return equipmentLosses
    }
    
    func deleteEquipment() {
        let fetchReq: NSFetchRequest<NSFetchRequestResult> =  NSFetchRequest.init(entityName:"EquipmentLosses")
        let context = persistentContainer.viewContext

        do {
            
            let equipmentFetchResult = try context.fetch(fetchReq)
            equipmentFetchResult.forEach { item in
                guard let item = item as? NSManagedObject else { return }
                context.delete(item)
            }
            
            do {
                try context.save()
            } catch {
                NSLog("[EQUIPMENT] Couldn't update data during deletion: \(error)")
            }
            
        } catch {
            NSLog("[EQUIPMENT] Deletion failed with error: \(error)")
        }
    }
}
