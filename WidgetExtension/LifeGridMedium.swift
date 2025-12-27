//
//  LifeGridMedium.swift
//  WidgetExtensionExtension
//
//  Created by Vlad Z on 26/02/2024.
//

import SwiftUI
import WidgetKit

struct LifeGridMedium: View {

    let birthday: Date
    let lifeExpectancy: Int
    let columns: Int

    private let pastColor = Color.gray.opacity(0.55)
    private let futureColor = Color.pink.opacity(0.85)

    var body: some View {
        let totalMonths = max(lifeExpectancy, 0) * 12
        let monthsSpent = min(monthsSinceBirthday(), totalMonths)

        GeometryReader { proxy in
            let size = proxy.size
            let spacing: CGFloat = 2
            let totalSquares = max(totalMonths, 0)
            let columnCount = max(1, columns)
            let rows = max(1, Int(ceil(Double(totalSquares) / Double(columnCount))))
            let squareSize = min(
                (size.width - spacing * CGFloat(columnCount - 1)) / CGFloat(columnCount),
                (size.height - spacing * CGFloat(rows - 1)) / CGFloat(rows)
            )
            let cornerRadius = max(1, squareSize * 0.2)

            LazyVGrid(
                columns: Array(repeating: GridItem(.fixed(squareSize), spacing: spacing), count: columnCount),
                spacing: spacing
            ) {
                ForEach(0..<totalSquares, id: \.self) { index in
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(index < monthsSpent ? pastColor : futureColor)
                        .frame(width: squareSize, height: squareSize)
                }
            }
            .frame(width: size.width, height: size.height, alignment: .center)
        }
    }

    private func monthsSinceBirthday() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month], from: birthday, to: now)
        let years = components.year ?? 0
        let months = components.month ?? 0
        return max(0, years * 12 + months)
    }
}

struct LifeGridMediumPreviews: PreviewProvider {

    static var pastDate: Date {
        let now = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = -25

        let maybeDate = calendar.date(byAdding: dateComponents, to: now)
        return maybeDate ?? Date.distantPast
    }

    static var previews: some View {
        VStack {
            LifeGridMedium(birthday: pastDate, lifeExpectancy: 83, columns: 48)
        }
        .containerBackground(.fill.tertiary, for: .widget)
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
