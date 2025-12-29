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

    private let monthsPerDecade = 120
    private let decadeFutureColors = [
        Color.gray.opacity(0.85),
        Color.gray.opacity(0.65)
    ]
    private let decadePastColors = [
        Color.pink,
        Color.orange
    ]

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
                        .fill(squareColor(for: index, monthsSpent: monthsSpent))
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

    private func squareColor(for index: Int, monthsSpent: Int) -> Color {
        let decadeIndex = max(0, index) / monthsPerDecade
        let colorIndex = decadeIndex % 2
        if index < monthsSpent {
            return decadePastColors[colorIndex]
        }
        return decadeFutureColors[colorIndex]
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
