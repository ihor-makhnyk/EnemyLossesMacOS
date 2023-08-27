//
//  DetailsPanelView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI
import AppKit

struct DetailsPanelView: View {
    @ObservedObject private var vm = DetailsPanelViewModel()
    @State private var id = 0
    @State private var isLoading: Bool = true
    @State private var isCapturing: Bool = false
    var body: some View {
        VStack {
            VStack {
                if !isLoading {
                    DetailsPanelModuleView(vm: vm)
                } else {
                    ProgressView()
                        .onReceive(NotificationCenter.default.publisher(for: .didEquipmentLossesLoad)) { _ in isLoading = false }
                        .onReceive(NotificationCenter.default.publisher(for: .loadingError)) { _ in isLoading = false }
                }
            }
            .id(id)
            .frame(width: ViewConstants.detailsPanelSize.width, height: ViewConstants.detailsPanelSize.height)
            .background(.gray.opacity(0.27))
            .background(.white.opacity(isCapturing ? 0.7 : 0))
            .onReceive(NotificationCenter.default.publisher(for: .shouldTakePicture), perform: {_ in
                withAnimation(.easeInOut(duration: 0.2)) { isCapturing.toggle() }
                withAnimation(.easeInOut(duration: 1).delay(0.25)) { isCapturing.toggle() }
            })
            .cornerRadius(28)
            Spacer()
        }
    }
    
}

