//
//  EquipmentModuleView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 26.08.2023.
//

import SwiftUI

struct EquipmentModuleView<Content: View>: View {
    var view: Content
    @State private var  isHovered: Bool = false
    @State private var isClicked: Bool = false
    
    init(@ViewBuilder _ view: () -> Content) {
        self.view = view()
    }
    
    var body: some View {
        VStack {
            VStack {
                view
                    .scaleEffect(isHovered ? 1 : 0.99)
                    .allowsHitTesting(false)
            }
            .padding()
            .frame(width: ViewConstants.detailsEquipmentModuleWidth)
            .frame(
                minHeight: ViewConstants.detailsEquipmentModuleMinHeight,
                maxHeight: .infinity
            )
            .background {
                Rectangle().fill(.gray.opacity(isHovered ? 0.6 : 0.4))
                .onHover { isHovering in withAnimation(.easeInOut(duration: 0.2).delay(0.1)) { isHovered = isHovering }} }
            .cornerRadius(28)
            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 0)
            .padding(.vertical, 0)
        }
        .frame(
            minHeight: ViewConstants.detailsEquipmentModuleMinHeight,
            maxHeight: .infinity
        )
        .padding(.horizontal, 4)
    }
}
