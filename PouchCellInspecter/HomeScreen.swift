import SwiftUI
import Combine
import PhotosUI

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

    private let classifier = ImageClassifier()

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background
                    .ignoresSafeArea()

                VStack(spacing: 36) {

                    //Spacer()

                    Text("PouchCell Inspector")
                        .font(.system(size: 32, weight: .bold))

                    Spacer()

                    // MARK: - Primary Action
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
            if granted {
                showCamera = true
            }
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
                        Button("Close") {
                            showPhotoPicker = false
                        }
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

        DispatchQueue.global(qos: .userInitiated).async {
            let result = classifier.classify(image)

            DispatchQueue.main.async {
                showLoading = false
                prediction = result ?? "Unable to analyze image"
                showResult = true
            }
        }
    }
}

