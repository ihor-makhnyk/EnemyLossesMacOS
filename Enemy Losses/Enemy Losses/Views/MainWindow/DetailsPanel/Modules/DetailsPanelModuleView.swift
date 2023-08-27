//
//  DetailsPanelModuleView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 22.08.2023.
//

import SwiftUI

struct DetailsPanelModuleView: View {
    
    @ObservedObject var vm: DetailsPanelViewModel
    
    var viewFactory = DetailsPanelModuleViewFactory()
    
    var body: some View {
        if let personnelModel = vm.currentPersonnelLossesModel, let equipmentModel = vm.currentEquipmentLossesModel {
            VStack {
                viewFactory.makeModuleLayout(with: [
                    .mrl,
                    .apc,
                    .tank,
                    .drone,
                    .aircraft,
                    .navalShip,
                    .helicopter,
                    .cruiseMissiles,
                    .fieldArtillery,
                    .specialEquipment,
                    .antiAircraftWarfare,
                    .vehiclesAndFuelTanks
                ], models: (personnelModel, equipmentModel), vm: vm, expanded: DataService.shared.isDetailsPanelExpandedForImage)
            }
            .onReceive(NotificationCenter.default.publisher(for: .shouldTakePicture), perform: {notification in
                guard let shouldSaveToDesktop = notification.object as? Bool else { return }
                vm.renderAndSaveImage(shouldSaveToDesktop: shouldSaveToDesktop, content: DetailsPanelModuleView(vm: vm))
            })
        } else {
            TextBuilder.makeText(AppTexts.noDataHere, variant: .settingsDescription)
        }
    }
    
}
