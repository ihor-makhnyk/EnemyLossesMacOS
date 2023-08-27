//
//  DetailsPanelBackgroundGraphView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 24.08.2023.
//

import SwiftUI

struct DetailsPanelBackgroundGraphView: View {
    @Binding var isExpanded: Bool
    @State private var isLitUp: Bool = DataService.shared.isDetailsPanelExpandedForImage
    @State private var graphExpansion: CGFloat = DataService.shared.isDetailsPanelExpandedForImage ? 1 : 0
    var data: [Int]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let graph = GraphPath(data: data.reversed(), geometry: geometry)
                ZStack {
                    graph
                        .scale(y: -1)
                        .stroke(
                            .linearGradient(
                                stops: [.init(color: .blue, location: 0.0), .init(color: .yellow, location: 0.7)],
                                startPoint: .top,
                                endPoint: .bottom),
                            lineWidth: isLitUp ? 5 : 0
                        )
                        .blur(radius: isLitUp ? 5 : 0)
                    graph
                        .scale(y: -1)
                        .stroke(.white.opacity(isLitUp ? 0.8 : 0.25), lineWidth: 10 + (graphExpansion * -7))
                }
                .onChange(of: isExpanded) { newValue in
                    withAnimation(.easeInOut(duration: 1).delay(0.5)) { isLitUp = newValue }
                    withAnimation(.easeInOut(duration: 0.6)) { graphExpansion = newValue ? 1 : 0 }
                }
            }
            .padding(.vertical)
            .scaleEffect(y: (graphExpansion + 0.2) )
            .frame(width: ViewConstants.detailsPanelContainerWidth, height: ViewConstants.defaultWindowHeight * 0.56)
        }
    }
}

struct GraphPath: Shape {
    var data: [Int]
    var geometry: GeometryProxy
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let stepX = geometry.size.width / CGFloat(data.count - 1)
        let stepY = geometry.size.height / CGFloat(data.max() ?? 1)
        
        guard let firstDataItem = data.first else { return path }
        path.move(to: CGPoint(x: 0, y: CGFloat(firstDataItem) * stepY))
        
        for index in data.indices {
            let x = CGFloat(index) * stepX
            let y = CGFloat(data[index]) * stepY
            
            if index > 0 {
                let prevX = CGFloat(index - 1) * stepX
                let prevY = CGFloat(data[index - 1]) * stepY
                let controlPoint1 = CGPoint(x: (prevX + x) / 2, y: prevY)
                let controlPoint2 = CGPoint(x: (prevX + x) / 2, y: y)
                path.addCurve(to: CGPoint(x: x, y: y), control1: controlPoint1, control2: controlPoint2)
            }
        }
        return path
    }
    
    
}
