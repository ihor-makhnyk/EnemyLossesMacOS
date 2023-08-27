//
//  MainLossesListDisclosureGroupView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 23.08.2023.
//

import SwiftUI

struct MainLossesListDisclosureGroupView: View {
    @State private var isExpanded: Bool = false
    var model: [[PersonnelLossesModel]]
    var monthChunk: [PersonnelLossesModel]
    var onExpand: ((Bool) -> Void)
    init(model: [[PersonnelLossesModel]], monthChunk: [PersonnelLossesModel], onExpand: @escaping (Bool) -> Void) {
        self.model = model
        self.monthChunk = monthChunk
        self.onExpand = onExpand
    }
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            Spacer().frame(height: 4)
            ForEach(monthChunk) { dayItem in
                MainLossesListCellView(model: dayItem)
            }
            .background(.clear)
        } label: {
            MainLossesListDisclosureCellView(isExpanded: $isExpanded, date: monthChunk[0].date)
        }
        .onChange(of: isExpanded, perform: { newValue in
            onExpand(isExpanded)
        })
        .onAppear { isExpanded = model.firstIndex(of: monthChunk) == 0 }
    }
}


