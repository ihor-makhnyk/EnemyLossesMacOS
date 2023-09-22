//
//  DetailsPanelViewModel.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 22.08.2023.
//

import SwiftUI
import Algorithms

final class DetailsPanelViewModel: ObservableObject {
    @Published var currentEquipmentLossesModel: EquipmentLossesModel?
    @Published var currentPersonnelLossesModel: PersonnelLossesModel?
    @Published var lossesDynamicDataForSelectedPeriod: [Int]?
    
    private var fullPersonnelLossesList: [PersonnelLossesModel]?
    
    private var personnelDidLoadObserver: NSObjectProtocol?
    private var shouldEquipmentLossesLoadObserver: NSObjectProtocol?
    
    private let sound = NSSound(named: "Morse")
    
    init() {
        configureObservers()
    }
    
    private func loadEquipmentLosses(for day: Int) {
        DispatchQueue.main.async {
            DataService.shared.loadEquipment(for: day) {[weak self] equipmentLosses in
                guard let self = self else { return }
                guard let equipmentLosses = equipmentLosses else {
                    self.currentEquipmentLossesModel = nil
                    return
                }
                DispatchQueue.main.async {
                    self.currentEquipmentLossesModel = equipmentLosses.first
                    NotificationCenter.default.post(name: .didEquipmentLossesLoad, object: (self.currentEquipmentLossesModel != nil, equipmentLosses.first?.day))
                    
                    guard let currentSelectedDay = equipmentLosses.first?.day else { return }
                    self.lossesDynamicDataForSelectedPeriod = self.computePersonnelLossesDynamics(till: currentSelectedDay)
                }
            }
        }
    }
    
    private func configureObservers() {
        personnelDidLoadObserver = NotificationCenter.default.addObserver(
            forName: .didPersonnelLossesLoad,
            object: nil,
            queue: nil
        )
        { [weak self] personnelDateNotification in
            guard let self = self, let personnelObject = personnelDateNotification.object as? ([[PersonnelLossesModel]], Int) else { return }
            let listOfAllPersonnelData = personnelObject.0.flatMap{$0}
            let selectedDay = personnelObject.1
            self.currentPersonnelLossesModel = listOfAllPersonnelData.filter { $0.day == selectedDay }.first
            self.fullPersonnelLossesList = listOfAllPersonnelData
            self.loadEquipmentLosses(for: selectedDay)
        }
        shouldEquipmentLossesLoadObserver = NotificationCenter.default.addObserver(
            forName: .shouldEquipmentLossesLoad,
            object: nil,
            queue: nil
        )
        { [weak self] personnelDateNotification in
            DispatchQueue.main.async {
                guard let sound = self?.sound else { return }
                sound.stop()
                sound.volume = 0.02
                sound.play()
            }
            guard let self = self, let personnelObject = personnelDateNotification.object as? PersonnelLossesModel else { return }
            self.currentPersonnelLossesModel = personnelObject
            self.loadEquipmentLosses(for: personnelObject.day)
        }
    }
    
    private func computePersonnelLossesDynamics(till day: Int) -> [Int] {
        guard let fullPersonnelLossesList else { return [] }
        var resultData: [Int] = []
        let chunckedData = fullPersonnelLossesList.chunked {
            guard let date0 = $0.date.dateFromString(), let date1 = $1.date.dateFromString() else { return false }
            return Calendar.current.isDate(date0, equalTo: date1, toGranularity: .month)
        }
        chunckedData.forEach {
            guard let dueDay = $0.last?.day, dueDay <= day else { return }
            resultData.append(calculateAverageDifference($0.compactMap { $0.personnel }))
        }
        return resultData
    }
    
    private func calculateAverageDifference(_ array: [Int]) -> Int {
        guard array.count >= 2 else { return 0 }
        
        var sumOfDifferences = 0
        for i in 1..<array.count {
            let difference = array[i - 1] - array[i]
            sumOfDifferences += difference
        }
        
        let averageDifference = Int(sumOfDifferences / array.count - 1)
        return averageDifference
    }
    
    @MainActor func renderAndSaveImage(shouldSaveToDesktop: Bool, content: some View) {
        DispatchQueue.main.async {
            let renderer = ImageRenderer(content: self.configureImageContent(content))
            renderer.scale = 2
            renderer.colorMode = .extendedLinear
            guard let image = renderer.cgImage else { return }
            
            let nsImage = NSImage(cgImage: image, size: NSSize(width: ViewConstants.detailsPanelSize.width, height: ViewConstants.detailsPanelSize.height))
            let userSettingsConfig = UserSettingsConfigurationModel()
            
            var imageData: Data?
            guard shouldSaveToDesktop else {
                imageData = nsImage.pngData()
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.setData(imageData, forType: .png)
                return
            }
            
            switch UserSettingsConfigurationModel.ImageFormat(rawValue: userSettingsConfig.exportImageFormat) {
            case .jpg:
                imageData = nsImage.jpegData(compressionQuality: 0.9)
            case .png:
                imageData = nsImage.pngData()
            case .tiff:
                imageData = nsImage.tiffData()
            case .none:
                break
            }
            
            guard let imageData else { return }
            if let documentsDirectory = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent(self.buildImageName())
                do {
                    try imageData.write(to: fileURL)
                    NSLog("Image saved as PNG: \(fileURL)")
                } catch {
                    NSLog("Error saving image as PNG: \(error)")
                }
            }
        }
    }
    
    private func configureImageContent(_ content: some View) -> some View {
        VStack {
            HStack(alignment: .bottom) {
                TextBuilder.makeText("tryzub", variant: .tryzub)
                TextBuilder.makeText("Enemy Losses", variant: .title)
                TextBuilder.makeText("by Ihor Makhnyk", variant: .body).offset(y: -3)
            }
            .padding(30)
            content
                .frame(height: ViewConstants.defaultWindowHeight * 0.78)
                .padding()
        }
        .padding()
        .background(.black)
        .cornerRadius(10)
    }
    
    private func buildImageName() -> String {
        var name: String = "EL"
        let dataService = DataService.shared
        if dataService.isDetailsPanelExpandedForImage {
            name.append("_Graph")
        }
        if let day = dataService.selectedPersonnelModel?.day {
            name.append("_Day\(day)")
        }
        let format = UserSettingsConfigurationModel().exportImageFormat
        name.append(".\(format)")
        return name
    }
    
}
