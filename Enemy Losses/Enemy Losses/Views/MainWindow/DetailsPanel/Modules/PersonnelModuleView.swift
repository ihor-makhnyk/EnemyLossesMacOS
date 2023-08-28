//
//  PersonnelModuleView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 26.08.2023.
//

import SwiftUI

struct PersonnelModuleView<Content: View>: View {
    var view: Content
    @State private var isHovered: Bool = false
    @State private var isClicked: Bool = false
    @State private var isExpanded: Bool = {
        if UserSettingsConfigurationModel().lossesDataElementsToShow.isEmpty { return true } else {
            return DataService.shared.isDetailsPanelExpandedForImage
        }
    }()
    
    @State private var graphStep: CGFloat = 0
    var graphData: [Int]?
    
    init(isExpanded: Bool, graphData: [Int]?, @ViewBuilder _ view: () -> Content) {
        self.view = view()
        self.isExpanded = isExpanded
        self.graphData = graphData
    }
    
    var body: some View {
//MARK: - Content Viwe
        view
            .padding()
            .onHover { isHovering in withAnimation(.easeInOut(duration: 0.2).delay(0.05)) { isHovered = isHovering }}
            .frame(width: ViewConstants.detailsPersonnelPanelWidth, height: ViewConstants.detailsPersonnelPanelHeight * (isExpanded ? 1 : 0.31))
            .background {
                ZStack {
//MARK: - Background Image
                    Image(AppImages.personnel)
                        .personnelModuleImageConfiguration()
                        .offset(x: (ViewConstants.defaultWindowWidth * (isExpanded ? 0.3 : 0.29)), y: (ViewConstants.defaultWindowHeight * 0.26) * (isExpanded ? 1 : 0.3 ))
//MARK: - Graph dividers
                    if let graphData, graphData.count > 1 {
                        VStack {
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(0..<graphData.count, id: \.self) { i in
                                    HStack {
                                        Rectangle()
                                            .fill(.linearGradient(
                                                Gradient(
                                                    colors: [.clear, .gray.opacity(0.2), .gray.opacity(0.01)]),
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                            .frame(width: 2, height: ViewConstants.defaultWindowHeight)
                                        Spacer()
                                    }
//MARK: - Graph month number overlay
                                    .overlay {
                                        TextBuilder.makeText("\(monthLoopConvert(i + 2))")
                                            .fontWeight(.black)
                                            .opacity(0.2)
                                            .offset(y: ViewConstants.defaultWindowHeight * 0.3)
                                    }
                                }
                            }
                            .frame(width: ViewConstants.detailsPanelContainerWidth, height: ViewConstants.defaultWindowHeight * 0.56)
//MARK: - Graph title overlay
                            .overlay {
                                GraphTitle()
                            }
                            
                            Spacer()
                        }
                        .opacity(isExpanded ? 1 : 0)
//MARK: - Graph
                        DetailsPanelBackgroundGraphView(isExpanded: $isExpanded, data: graphData)
                    }
                }
            }
            .background(.gray.opacity(isHovered ? 0.55 : 0.4))
            .cornerRadius(28)
            .shadow(color: .black.opacity(isHovered ? 0.5 : 0.2), radius: isHovered ? 16 : 4, x: 0, y: 0)
            .padding(.bottom, 6)
            .offset(y: isHovered ? -2 : 0)
            .scaleEffect(isHovered ? 1.01 : 1)
            .padding(.top, isExpanded ? ViewConstants.detailsPersonnelPanelPaddingTop : 0)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isClicked.toggle()
                    isExpanded.toggle()
                    DataService.shared.isDetailsPanelExpandedForImage = isExpanded
                }
                withAnimation(.easeInOut(duration: 0.2).delay(0.22)) { isClicked.toggle() }
            }
    }
    
    private func monthLoopConvert(_ count: Int) -> String {
        let convertedValue = (count - 1) % 12 + 1
        let monthString = convertedValue > 9 ? "\(convertedValue)" : "0\(convertedValue)"
        return "\(monthString)"
    }
    
    private struct GraphTitle: View {
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    TextBuilder.makeText(AppTexts.graphTitle, variant: .settingsTitle)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    TextBuilder.makeText(AppTexts.graphDescription, variant: .settingsDescription)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                }
                .opacity(0.35)
                .frame(width: ViewConstants.detailsGraphTitleWidth)
                Spacer()
            }
            .offset(y: ViewConstants.detailsGraphTitleOffset)
        }
    }
    
}
