//
//  MainLossesListView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import SwiftUI

struct MainLossesListView: View {
    @ObservedObject private var vm = MainLossesListViewModel()
    
    @State private var isHovered: Bool = false
    @State private var animationState: Double = 1
    @State private var isRefreshButtonClicked: Bool = false
    
    @State private var monthItemCount: Int = 0
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    if !vm.isLoading {
                        if !vm.listOfLosses.isEmpty {
                            VStack(spacing: 0) {
                                ForEach(vm.listOfLosses, id: \.self) { monthChunk in
                                    HStack(alignment: .bottom) {
                                        if pickYearDividerTitle(with: monthChunk, for: .lastYear) {
                                            TextBuilder.makeText(AppTexts.lastYear)
                                                .opacity(0.5)
                                                .padding(.top, 4)
                                        } else if pickYearDividerTitle(with: monthChunk, for: .year) {
                                            TextBuilder.makeText("\(monthChunk.first!.date.dateFromString()!.format(.year))")
                                                .opacity(0.5)
                                                .padding(.top, 4)
                                        }
                                    }
                                    MainLossesListDisclosureGroupView(model: vm.listOfLosses, monthChunk: monthChunk) { isExpanded in
                                        if vm.listOfLosses.last == monthChunk, isExpanded {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                withAnimation(.easeInOut(duration: 0.2)) {
                                                    proxy.scrollTo(0, anchor: .top)
                                                }
                                            }
                                        }
                                    }
                                }
                                .offset(y: -4)
                                TextBuilder.makeText(AppTexts.theBeginning).opacity(0.5).frame(height: 30).id(monthItemCount)
                                    .padding(.top, 0)
                                    .offset(y: -2)
                            }
                        } else {
                            VStack {
                                TextBuilder.makeText(AppTexts.lowOnNetwork, variant: .settingsDescription)
                                    .multilineTextAlignment(.center)
                                    .frame(width: ViewConstants.listScrollViewSize.width * 0.7)
                                    .scaleEffect(1 - (animationState * 0.25), anchor: .trailing)
                                    .opacity(1 - animationState)
                                CustomRefreshButton {
                                    withAnimation(.easeInOut(duration: 0.15)) { isRefreshButtonClicked.toggle() }
                                    withAnimation(.easeInOut(duration: 0.25).delay(0.15)) { isRefreshButtonClicked.toggle() }
                                    vm.loadPersonnel()
                                }
                                .frame(width: ViewConstants.listScrollViewSize.width)
                            }
                            .frame(height: ViewConstants.listScrollViewSize.height)
                        }
                    } else {
                        VStack {
                            ProgressView()
                                .onReceive(NotificationCenter.default.publisher(for: .loadingError)) { _ in
                                    vm.isLoading = false
                                }
                        }
                        .frame(height: ViewConstants.listScrollViewSize.height)
                    }
                }
                .onChange(of: vm.listWindowShouldAppear, perform: { shouldAppear in
                    withAnimation(.easeInOut(duration: 0.35)) {
                        animationState = shouldAppear ? 0 : 1
                    }
                })
                .mainLossesListConfiguration()
                .scrollDisabled(vm.listOfLosses.isEmpty)
                .scaleEffect(isRefreshButtonClicked ? 0.985 : (1 - (animationState * 0.25)), anchor: .trailing)
                .opacity(1 - animationState)
                .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 0)
                    
            }
        }
        .compensateSizeForMainLossesListShadow()
        .onHover(perform: { isHovering in withAnimation(.easeInOut(duration: 0.3)) { self.isHovered = isHovering } } )
        .scaleEffect(isHovered ? 1 : 0.99)
    }
    
    private enum YearPeriod { case lastYear, year }
    private func pickYearDividerTitle(with monthChunk: [PersonnelLossesModel], for period: YearPeriod) -> Bool {
        guard let date = monthChunk.first?.date else { return false }
        switch period {
        case .lastYear:
            guard let formattedYear = Int(Date().format(.year)) else { return false }
            return date == "\(formattedYear - 1)-12-31"
        case .year:
            return date.suffix(5) == "12-31"
        }
    }
    
}
