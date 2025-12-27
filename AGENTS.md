# AGENTS

This file guides coding agents working on the Lifeline iOS project.

## Project Overview
- SwiftUI iOS app with three tabs: Export, Insights, Lifeline.
- Read-only HealthKit access, CSV export, and share sheet workflow.
- WidgetExtension target that mirrors life expectancy progress via app group storage.

## Architecture Map
- `Lifeline/Views`: SwiftUI views and view models (e.g., `HealthExportView+ViewModel`).
- `Lifeline/Data/HealthKit`: HealthKit integration (`HealthMetricReader`, `HealthMetric+HealthKit`).
- `Lifeline/Data/CSV`: CSV writer utilities (`CSVWriter`, `HealthCSVWriter`).
- `Lifeline/Domain`: canonical health metric definitions and categories.
- `Lifeline/Model`: core calculations (`LifeStats`).
- `WidgetExtension`: widget UI and timeline provider.

## Guardrails
- Keep the app group ID `group.com.vladz.lifeline` unchanged in app and widget.
- Preserve shared keys: `lifeExpectancy`, `selectedDate`, `isHealthDataRequested`, `metricsToExport`.
- Do not access HealthKit directly in views; go through `HealthMetricReading` and `HealthMetricReader`.
- When adding metrics, update `HealthMetric`, `HealthMetric+HealthKit`, and `HealthMetricCategory`.
- Keep CSV output stable: first column `Date`, file names prefixed with `lifeline_`.
- Avoid `try!` in new code; return errors or handle them in the UI.

## Coding Standards
- SwiftUI-first; keep view models `@MainActor` and `ObservableObject`.
- Prefer protocol-based dependency injection for testability.
- Keep async work off the main thread; use async/await and `Task`.
- Maintain 4-space indentation, existing file headers, and ASCII text.

## Tests and Validation
- Unit tests live in `LifelineTests`, UI tests in `LifelineUITests`.
- If adding non-trivial logic, add tests; mock HealthKit via `HealthMetricReading`.
- Build/run with Xcode or `xcodebuild -scheme Lifeline`.
