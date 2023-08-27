//
//  AboutScreenView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 27.08.2023.
//

import SwiftUI

struct AboutScreenView: View {
    @Binding var currentWindow: AppWindow
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Spacer()
                Image(AppImages.developer)
                    .resizable()
                    .scaleEffect(1.05, anchor: .topLeading)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                    .frame(width: ViewConstants.defaultWindowHeight * 0.24)
                    .clipShape(Circle())
                    .padding(.leading, ViewConstants.defaultWindowWidth * 0.03)
                VStack(alignment: .leading) {
                    TextBuilder.makeText(AppTexts.aboutTitle, variant: .aboutTitle)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 0)
                        .frame(height: ViewConstants.defaultWindowHeight * 0.05)
                    TextBuilder.makeText(AppTexts.aboutCoverText, variant: .aboutDescription)
                        .opacity(0.7)
                        .padding(.vertical, 0)
                        .frame(height: ViewConstants.defaultWindowHeight * 0.3)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, ViewConstants.defaultWindowWidth * 0.03)
                .frame(width: ViewConstants.defaultWindowWidth * 0.38)
                Spacer()
            }
            .padding(.horizontal, ViewConstants.defaultWindowWidth * 0.07)
            .padding(.top, ViewConstants.defaultWindowHeight * 0.32)
            .frame(height: ViewConstants.defaultWindowHeight * 0.1)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: AppImages.lookupData)
                            .resizable()
                            .frame(width: ViewConstants.defaultWindowHeight * 0.03, height: ViewConstants.defaultWindowHeight * 0.035)
                            .padding()
                            .offset(y: -5)
                        TextBuilder.makeText(AppTexts.aboutOverview, variant: .aboutDescription)
                            .frame(width: ViewConstants.defaultWindowWidth * 0.46)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing)
                        
                    }
                    .frame(height: ViewConstants.defaultWindowHeight * 0.08)
                }
                .padding(6)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: AppImages.chartLine)
                            .resizable()
                            .frame(width: ViewConstants.defaultWindowHeight * 0.03, height: ViewConstants.defaultWindowHeight * 0.03)
                            .padding()
                            .offset(y: -5)
                        TextBuilder.makeText(AppTexts.aboutGraph, variant: .aboutDescription)
                            .frame(width: ViewConstants.defaultWindowWidth * 0.46)
                            .padding(.trailing)
                    }
                    .frame(height: ViewConstants.defaultWindowHeight * 0.08)
                }
                .padding(6)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: AppImages.camera)
                            .resizable()
                            .frame(width: ViewConstants.defaultWindowHeight * 0.03, height: ViewConstants.defaultWindowHeight * 0.025)
                            .padding()
                            .offset(y: -5)
                        TextBuilder.makeText(AppTexts.aboutImages, variant: .aboutDescription)
                            .frame(width: ViewConstants.defaultWindowWidth * 0.46)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing)
                        
                    }
                    .frame(height: ViewConstants.defaultWindowHeight * 0.08)
                }
                .padding(6)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: AppImages.cache)
                            .resizable()
                            .frame(width: ViewConstants.defaultWindowHeight * 0.03, height: ViewConstants.defaultWindowHeight * 0.032)
                            .padding()
                            .offset(y: -5)
                        TextBuilder.makeText(AppTexts.aboutCache, variant: .aboutDescription)
                            .frame(width: ViewConstants.defaultWindowWidth * 0.46)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing)
                    }
                    .frame(height: ViewConstants.defaultWindowHeight * 0.08)
                }
                .padding(6)
            }
            .padding(.horizontal)
            .frame(width: ViewConstants.defaultWindowWidth * 0.56, height: ViewConstants.defaultWindowHeight * 0.46)
            .background(.gray.opacity(0.2))
            .cornerRadius(28)
            .offset(y: ViewConstants.defaultWindowHeight * 0.2)
            Spacer()
        }
        .frame(width: ViewConstants.defaultWindowWidth * 0.6, height: ViewConstants.defaultWindowHeight * 0.8)
        .background(.gray.opacity(0.3))
        .cornerRadius(28)
        .frame(width: ViewConstants.defaultWindowWidth * 0.6, height: ViewConstants.defaultWindowHeight * 0.8)
        .padding(.bottom, 40)
    }
    
}
