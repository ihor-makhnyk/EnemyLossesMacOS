//
//  MainLossesListCellView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

struct MainLossesListCellView: View {
    var model: PersonnelLossesModel
    @State private var isHovered: Bool = false
    @State private var isClicked: Bool = false
    @State private var isSelected: Bool = false
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { cellGeometry in
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        TextBuilder.makeText(model.date, variant: .cellDate)
                        HStack(spacing: 0) {
                            TextBuilder.makeText(AppTexts.day, variant: .cellSubtitle)
                            TextBuilder.makeText("\(model.day)", variant: .cellSubtitle)
                        }
                    }
                    .padding(.leading, cellGeometry.size.width * 0.06)
                    Spacer()
                    VStack(alignment: .leading) {
                        TextBuilder.makeText("\(model.personnel)", variant: .cellTitle)
                    }
                    .padding(.trailing, cellGeometry.size.width * 0.042)
                }
                .background(.clear)
                .padding()
            }
        }
        .background(.gray.opacity(isSelected ? 0.45 : 0.3))
        .cornerRadius(28)
        .scaleEffect((isClicked ? 0.98 : (isHovered ? 1.025 : 1)))
        .shadow(color: .black, radius: isSelected ? 8 : (isHovered ? 6 : 0))
        .frame(width: ViewConstants.listScrollViewSize.width * 0.9 , height: ViewConstants.listCellHeight * 0.92)
        .onHover(perform: { isHovering in withAnimation(.easeInOut(duration: 0.15).delay(0.01)) { self.isHovered = isHovering } } )
        .padding([.horizontal], 8)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.15)) { isClicked.toggle() }
            NotificationCenter.default.post(name: .shouldEquipmentLossesLoad, object: model)
            DataService.shared.selectedPersonnelModel = model
            withAnimation(.easeOut(duration: 0.3).delay(0.15)) { isClicked.toggle() }
        }
        .onReceive(NotificationCenter.default.publisher(for: .didEquipmentLossesLoad)) { equipmentLoadStatusNotification in
            guard let didLoad = equipmentLoadStatusNotification.object as? (Bool, Int) else { return }
            withAnimation(.easeInOut(duration: 0.15)) { isSelected = (didLoad.0 && model.day == didLoad.1) }
        }
    }
}
