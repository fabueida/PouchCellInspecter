//
//  ImageClassifier.swift
//  placeholder
//
//  Created by Firas Abueida on 11/26/25.
//

import SwiftUI
import Combine
import PhotosUI

// MARK: - Speech Settings Persistence (same key as MenuView)
private enum SpeechSettingsStorage {
    static let key = "speechSettingsData"

    static func encode(_ settings: SpeechSettings) -> Data {
        (try? JSONEncoder().encode(settings)) ?? Data()
    }

    static func decode(_ data: Data) -> SpeechSettings {
        (try? JSONDecoder().decode(SpeechSettings.self, from: data)) ?? .default
    }
}

struct HomeScreen: View {

    @StateObject private var cameraManager = CameraPermissionManager()

    // MARK: - Menu
    @State private var showMenu = false
    @State private var showSafetyInfo = false

    // MARK: - Camera & Photo Library
    @State private var showCamera = false
    @State private var showPhotoPicker = false
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var capturedImage: UIImage?

    // MARK: - ML & UI State
    @State private var prediction: String?
    @State private var showLoading = false
    @State private var showResult = false

//    private let classifier = ImageClassifier()
    private let classifier = DTImageClassifier()
    

    // ✅ Load speech settings app-wide
    @AppStorage(SpeechSettingsStorage.key) private var speechSettingsData: Data = SpeechSettingsStorage.encode(.default)

    private var speechSettings: SpeechSettings {
        SpeechSettingsStorage.decode(speechSettingsData)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background
                    .ignoresSafeArea()

                VStack(spacing: 36) {

                    Text("PouchCell Inspector")
                        .font(.system(size: 32, weight: .bold))

                    Spacer()

                                        Button {
                        cameraManager.requestPermission()
                    } label: {
                        Label("Scan", systemImage: "camera.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(AppTheme.accent)
                            .cornerRadius(18)
                            .accessibilityHint("Double tap to take a picture of your Lithium battery.")
                    }
                    .padding(.horizontal, 32)

                    // MARK: - Secondary Action
                    Button {
                        showPhotoPicker = true
                    } label: {
                        Label("Import from Library", systemImage: "photo.on.rectangle")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(AppTheme.accent)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(AppTheme.accent, lineWidth: 2)
                            )
                    }
                    .padding(.horizontal, 64)

                    // MARK: - Safety Info (Informational)
                    Button {
                        showSafetyInfo = true
                    } label: {
                        Label("Safety Info", systemImage: "info.circle")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 8)

                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: - Menu Button
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showMenu = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .accessibilityLabel("Menu")
                    }
                }
            }
        }
        // MARK: - Menu
        .sheet(isPresented: $showMenu) {
            MenuView()
        }
        // MARK: - Safety Info
        .sheet(isPresented: $showSafetyInfo) {
            InfoDetailView(
                title: "Safety Information",
                message: "This app provides a visual inspection only and does not replace professional battery testing or safety procedures."
            )
        }
        // MARK: - Camera Permission Handling
        .onChange(of: cameraManager.permissionGranted) { _, granted in
            if granted { showCamera = true }
        }
        // MARK: - Camera
        .sheet(isPresented: $showCamera) {
            CameraView { image in
                capturedImage = image
                showCamera = false
                runClassification()
            }
        }
        // MARK: - Photo Picker
        .sheet(isPresented: $showPhotoPicker) {
            NavigationStack {
                PhotosPicker(
                    selection: $selectedPhotoItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Select a Photo")
                        .font(.headline)
                        .padding()
                }
                .navigationTitle("Import Photo")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Close") { showPhotoPicker = false }
                    }
                }
            }
            .onChange(of: selectedPhotoItem) { _, newItem in
                guard let newItem else { return }

                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        capturedImage = image
                        showPhotoPicker = false
                        runClassification()
                    }
                }
            }
        }
        // MARK: - Loading & Result
        .fullScreenCover(isPresented: $showLoading) {
            AnalysisLoadingScreen()
        }
        .fullScreenCover(isPresented: $showResult) {
            DetectionResultScreen(result: prediction ?? "Unknown")
        }
        // MARK: - Camera Permission Alert
        .alert("Camera Access Required", isPresented: $cameraManager.showPermissionAlert) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("We use the camera to inspect the battery for visible bulging.")
        }
    }

    // MARK: - Classification
    private func runClassification() {
        guard let image = capturedImage else { return }

        showLoading = true

        // for SVM
//        DispatchQueue.global(qos: .userInitiated).async {
//            let result = classifier.classify(image)
//
//            DispatchQueue.main.async {
//                showLoading = false
//
//                let label = result ?? "Unable to analyze image"
//                prediction = label
//                showResult = true
//
//                // ✅ Self-voicing result (separate from VoiceOver)
//                let speakText = speechText(for: label)
//                SpeechManager.shared.speak(speakText, settings: speechSettings)
//            }
//        }
        // for DT
        DispatchQueue.global(qos: .userInitiated).async {
            let result = try? classifier.classify(image)
            
            DispatchQueue.main.async {
                showLoading = false
                
                //                let label = result ?? "Unable to analyze image"
                let label = result?.classLabel
                let labelIndex = result!.classLabel == "Normal" ? 0 : 1
                let confidence = result!.probabilities[labelIndex] ?? 0.0
                prediction = "\(label) – \(String(format: "%.1f%%", confidence * 100))"
                showResult = true
                
                // ✅ Self-voicing result (separate from VoiceOver)
                let speakText = speechText(for: label!)
                SpeechManager.shared.speak(speakText, settings: speechSettings)
            }
        }
    }

    // MARK: - Speakable Result Copy
    private func speechText(for label: String) -> String {
        switch label.lowercased() {
        case "normal":
            return "Result: normal. No visible bulging detected."
        case "bulging":
            return "Result: bulging detected. Please handle the battery with caution."
        case "unable to analyze image":
            return "Result unavailable. The image could not be analyzed."
        default:
            return "Result: \(label)."
        }
    }
}
