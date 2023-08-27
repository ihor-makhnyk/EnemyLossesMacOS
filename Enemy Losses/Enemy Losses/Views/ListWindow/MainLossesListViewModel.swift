//
//  MainLossesListViewModel.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import Foundation
import Algorithms

final class MainLossesListViewModel: ObservableObject {
    @Published var listOfLosses: [[PersonnelLossesModel]] = []
    @Published var listWindowShouldAppear: Bool = false
    
    @Published var isLoading: Bool = true
    
    private var launchScreenDismissObserver: NSObjectProtocol?
    private var shouldReloadListObserver: NSObjectProtocol?
    
    init() {
        DispatchQueue.main.async {
            self.configureObservers()
        }
    }
    
    deinit {
        guard let launchScreenDismissObserver, let shouldReloadListObserver else { return }
        NotificationCenter.default.removeObserver(launchScreenDismissObserver)
        NotificationCenter.default.removeObserver(shouldReloadListObserver)
    }
    
    func loadPersonnel() {
        DispatchQueue.main.async {
            DataService.shared.loadPersonnel {[weak self] personnelList in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    guard let personnelList = personnelList else {
                        self.listOfLosses = []
                        return
                    }
                    self.listOfLosses = self.chunkListByMonth(personnelList.reversed())
                    guard let personnelDataChunk = self.listOfLosses.first else { return }
                    let personnelObject = DataService.shared.selectedPersonnelModel ?? personnelDataChunk.first!
                    DataService.shared.selectedPersonnelModel = personnelObject
                    self.isLoading = false
                    NotificationCenter.default.post(name: .didPersonnelLossesLoad, object: (self.listOfLosses, personnelObject.day))
                }
            }
        }
    }
    
    private func configureObservers() {
        launchScreenDismissObserver = NotificationCenter.default.addObserver(
            forName: .shouldToggleListWindowAppearance, object: nil, queue: nil) { [weak self] notification in
                guard let self = self, let currentWindow = notification.object as? AppWindow else { return }
                    guard currentWindow == .main else {
                        self.listWindowShouldAppear = false
                        return
                    }
                    self.listWindowShouldAppear = true
                    if !self.listOfLosses.isEmpty {
                        guard let personnelObject = self.listOfLosses.first?.first else { return }
                        NotificationCenter.default.post(name: .didPersonnelLossesLoad, object: (self.listOfLosses, personnelObject.day))
                    } else {
                        self.loadPersonnel()
                    }
            }
        shouldReloadListObserver = NotificationCenter.default.addObserver(
            forName: .shouldPersonnelLossesLoad, object: nil, queue: nil) { [weak self] _ in
                guard let self = self else { return }
                if !self.listOfLosses.isEmpty {
                    self.loadPersonnel()
                }
            }
    }
    
    private func chunkListByMonth(_ list: [PersonnelLossesModel]) -> [[PersonnelLossesModel]] {
        let chunked = list.chunked {
            guard let date0 = $0.date.dateFromString(), let date1 = $1.date.dateFromString() else { return false }
            return Calendar.current.isDate(date0, equalTo: date1, toGranularity: .month)
        }
        return chunked.map { Array($0) }
    }
}
