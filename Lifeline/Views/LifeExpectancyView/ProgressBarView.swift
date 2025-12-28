//
//  LifelineProgressView.swift
//  Lifeline
//
//  Created by Vlad Z on 25/02/2024.
//

import SwiftUI

struct ProgressBarView: View {
    
    let remaining: Double
    
    var progress: CGFloat {
        // Ensure value is between 0 and 1
        return CGFloat(min(max(self.remaining, 0.0), 1.0))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                let width = geometry.size.width
                let height = geometry.size.height
                Capsule()
                    .fill(Color.gray)
                    .frame(width: width, height: height)
                Capsule()
                    .fill(Color.pink)
                    .frame(width: progress * width, height: height)
            }
        }
    }
}

#Preview {
    ProgressBarView(remaining: 0.7)
        .frame(height: 4)
}
