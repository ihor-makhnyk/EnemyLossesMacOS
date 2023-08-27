//
//  SettingsScreenModule.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 23.08.2023.
//

import SwiftUI

struct SettingsScreenModules: View {
    enum SettingsModuleType { case checkbox(title: String, description: String? = nil, setting: UserSettingsConfigurationModel.Keys),
                                   parameterSelector,
                                   imageFormatAndLanguageSelector,
                                   other
    }
    var type: SettingsModuleType
    
    init(_ type: SettingsModuleType) { self.type = type }
    
    @State private var config = UserSettingsConfigurationModel()
    @State private var isClearCacheButtonPresented: Bool = !DataService.shared.shouldCache
    @State private var animationState: CGFloat = !DataService.shared.shouldCache ? 1 : 0
    
    @State private var updateId = 0
    
    var body: some View {
        VStack {
            switch type {
            case .checkbox(let title, let description, let setting):
                VStack(alignment: .center) {
                    HStack {
                        
                        SettingsToggleView(setting, title: title, description: description, showSecondColumn: $isClearCacheButtonPresented, with: $config)
                            .onChange(of: isClearCacheButtonPresented) { _ in
                                if !DataService.shared.shouldCache {
                                    withAnimation(.easeInOut(duration: 0.5).delay(0.1)) { animationState = 1 }
                                    DataService.shared.clearAllCaches()
                                }
                            }
                            .onReceive(NotificationCenter.default.publisher(for: .allCachesCleared), perform: { _ in
                                withAnimation(.easeInOut(duration: 0.5).delay(1.5)) { animationState = 0; isClearCacheButtonPresented = !DataService.shared.shouldCache }
                            })
                            .padding()
                            .frame(width: ViewConstants.defaultWindowWidth * (0.6 - (animationState * 0.14)))
                            .background(.gray.opacity(0.4))
                            .cornerRadius(28)
                            .offset(x: ViewConstants.defaultWindowWidth * 0.066 * (1 - animationState))
                        
                        SettingsClearCacheButtonView()
                            .padding()
                            .background(.gray.opacity(0.4))
                            .cornerRadius(28)
                            .transition(.push(from: .leading))
                            .scaleEffect(x: animationState + 0.001, anchor: .trailing)
                            .offset(x: -ViewConstants.defaultWindowWidth * 0.066 * (1 - animationState))
                        
                    }
                    .padding(.horizontal, ViewConstants.settingsModuleHorizontalPadding)
                }
            case .parameterSelector:
                SettingsModule {
                    SettingsDataParameterSelector(config: $config)
                }
            case .imageFormatAndLanguageSelector:
                SettingsModule(twoRows: .constant(true)) {
                    SettingsLanguageSelector(config: $config)
                } secondContentRow: {
                    SettingsImageFormatSelector(config: $config)
                }
            case .other:
                SettingsModule {
                    SettingsDonateBanner()
                }
            }
        }
        .frame(width: ViewConstants.settingsModuleWidth)
    }
    
    private func SettingsModule(twoRows: Binding<Bool> = .constant(false), content: () -> some View, secondContentRow: (() -> some View) = { EmptyView().hidden() }) -> some View {
        VStack(alignment: .center) {
            HStack {
                content()
                    .frame(minWidth: ViewConstants.settingsModuleMinWidth, maxWidth: ViewConstants.settingsModuleMaxWidth)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .cornerRadius(28)
                if twoRows.wrappedValue {
                    secondContentRow()
                        .padding()
                        .background(.gray.opacity(0.4))
                        .cornerRadius(28)
                }
            }
            .padding(.horizontal, ViewConstants.settingsModuleHorizontalPadding)
        }
    }
}
