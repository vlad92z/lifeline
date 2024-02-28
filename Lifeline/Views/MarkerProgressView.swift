//
//  MarkerProgressView.swift
//  Lifeline
//
//  Created by Vlad Z on 28/02/2024.
//

import SwiftUI

struct MarkerProgressView: View {
    
    let progress: Double
    
    var progressInt: Int {
        return Int(100 * progress)
    }
    var body: some View {
        ProgressBarView(remaining: progress)
            .frame(height: 4)
            .overlay(GeometryReader { geo in
                let xOffset = geo.size.width * progress - 20
                TextBubble(text: "\(progressInt)%")
                    .offset(x: max(xOffset, 5), y: -35)
                        })
    }
}

#Preview {
    MarkerProgressView(progress: 0.3)
}
