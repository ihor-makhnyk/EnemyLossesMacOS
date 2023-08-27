//
//  MainLossesListDisclosureCellView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 22.08.2023.
//

import SwiftUI

struct MainLossesListDisclosureCellView: View {
    @State private var isHovered: Bool = false
    @Binding var isExpanded: Bool
    var date: String
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { cellGeometry in
                HStack(alignment: .center) {
                    makeTitleText(in: cellGeometry)
                }
                .frame(height: ViewConstants.listCellHeight / 2)
                .background(.clear)
                .padding()
            }
        }
        .background(.gray.opacity(isHovered ? 0.55 : 0.45))
        .cornerRadius(28)
        .frame(width: ViewConstants.listScrollViewSize.width * 0.97, height: ViewConstants.listCellHeight)
        .offset(x: -ViewConstants.listScrollViewSize.width * 0.01)
        .padding([.horizontal, .top], 5)
        .onTapGesture {
            withAnimation(.easeInOut(duration: isExpanded ? 0.1 : 0.3)) {
                isExpanded.toggle()
            }
        }
        .onHover(perform: { isHovering in withAnimation(.easeInOut(duration: 0.2).delay(0.01)) { self.isHovered = isHovering } } )
    }
    
    private func makeTitleText(in cellGeometry: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            if let monthText = date.dateFromString()?.format(.month),
               let yearText = date.dateFromString()?.format(.yearShort) {
                HStack {
                    TextBuilder.makeText(monthText, variant: .disclosureCellMonth)
                    Spacer()
                    TextBuilder.makeText(yearText, variant: .disclosureCellYear)
                        .foregroundColor(.gray.opacity(0.25))
                }
            } else {
                Text(date)
            }
        }
        .padding(.leading, cellGeometry.size.width * 0.06)
    }

}
