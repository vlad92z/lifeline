# Lifeline

Lifeline is an iOS app that helps users explore personal health insights and export Apple Health data to CSV for sharing.

## Functionality
- Export HealthKit metrics to CSV with metric selection and a date range, then share via the system share sheet.
- Health insights view showing calories burned vs consumed over time.
- Lifeline view that estimates remaining days and weeks based on birthday and life expectancy.
- Home screen widgets (small/medium) that mirror the Lifeline progress.

## Tech Stack
- Swift 5, SwiftUI, async/await
- HealthKit for read-only health data access
- Charts for insights visualizations
- WidgetKit + AppIntents for widgets
- ActivityKit (imported for Live Activities support)
- App Group storage (`group.com.vladz.lifeline`) for app/widget shared values
- CSV export via temporary files and `UIActivityViewController`
- Xcode project (`Lifeline.xcodeproj`), iOS deployment target 18.6

## Project Structure
- `Lifeline/Views`: SwiftUI screens and view models
- `Lifeline/Data/HealthKit`: HealthKit access and metric mappings
- `Lifeline/Data/CSV`: CSV writing utilities
- `Lifeline/Domain`: Health metric definitions and categories
- `Lifeline/Model`: Core calculations (life expectancy stats)
- `WidgetExtension`: Widget UI and timeline provider

## Coding Standards
- SwiftUI-first with `@MainActor` view models and `ObservableObject`.
- Keep HealthKit access in `HealthMetricReader` and mappings in `HealthMetric+HealthKit`.
- Update `HealthMetricCategory` and `HealthMetric` together when adding or removing metrics.
- Use protocol-based dependencies (`HealthMetricReading`, `CSVWriting`, `HealthCSVWriting`) to keep logic testable.
- Keep shared defaults keys and app-group IDs stable for widget compatibility.
- Avoid blocking the main thread; use async tasks for HealthKit and file I/O.
