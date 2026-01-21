//
//  MenuView.swift
//  PouchCellInspecter
//
//  Created by Firas Abueida on 1/20/26.
//

import SwiftUI

enum AppAppearance: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

struct MenuView: View {

    @Environment(\.dismiss) private var dismiss

    // ✅ REAL state (not .constant)
    @AppStorage("appAppearance") private var appearance: AppAppearance = .system

    var body: some View {
        NavigationStack {
            List {

                // MARK: - Safety
                Section("Safety") {
                    NavigationLink("Battery inspection disclaimer") {
                        InfoDetailView(
                            title: "Safety Disclaimer",
                            message: "This app provides a visual inspection only and does not replace professional battery testing or safety procedures."
                        )
                    }
                }

                // MARK: - Accessibility
                Section("Accessibility") {
                    Toggle("Larger text", isOn: .constant(false))
                    Toggle("Enhanced VoiceOver descriptions", isOn: .constant(true))
                }

                // MARK: - Appearance
                Section("Appearance") {
                    Picker("App appearance", selection: $appearance) {
                        ForEach(AppAppearance.allCases) { option in
                            Text(option.title).tag(option)
                        }
                    }
                }

                // MARK: - About
                Section("About") {
                    LabeledContent("App version", value: "1.0")
                    LabeledContent("Model version", value: "v1")

                    NavigationLink("Contact & feedback") {
                        InfoDetailView(
                            title: "Contact & Feedback",
                            message: "For feedback or support, please contact the development team."
                        )
                    }
                }
            }
            .navigationTitle("Menu")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Info Screen
struct InfoDetailView: View {
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 48))
                .foregroundColor(.accentColor)

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle(title)
    }
}

#Preview {
    MenuView()
}
