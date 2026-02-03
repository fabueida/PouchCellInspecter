import SwiftUI
import UIKit
import Combine

struct HomeScreen: View {

    @StateObject private var cameraManager = CameraPermissionManager()
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    @State private var prediction: String?
    @State private var showLoading = false
    @State private var showResult = false
    @State private var showSafetyInfo = false

    private let classifier = ImageClassifier()


    var body: some View {
        ZStack {
            AppTheme.background
                .ignoresSafeArea()

            VStack(spacing: 35) {
                Spacer()
                
                Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 350)
                
                Spacer()
                

                VStack(spacing: 28) {

                    // MARK: - Scan Battery (Camera)
                    Button {
                        cameraManager.requestPermission()
                    } label: {
                        Text("Scan Battery")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(AppTheme.buttonColor)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 40)

                    // MARK: - Safety Info (Restored)
                    Button {
                        // TODO: Navigate to Safety Info screen
                        showSafetyInfo = true
                    } label: {
                        Text("Safety Info")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(AppTheme.buttonColor.opacity(0.85))
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 70)
                }

                Spacer()
            }
        }
        // iOS 17+ onChange
        .onChange(of: cameraManager.permissionGranted) { _, granted in
            if granted {
                showCamera = true
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraView { image in
                capturedImage = image
                showCamera = false
                runClassification()
            }
        }
        
        .sheet(isPresented: $showSafetyInfo) {
            SafetyInfoScreen()
        }
        
        .fullScreenCover(isPresented: $showLoading) {
            AnalysisLoadingScreen()
        }

        .fullScreenCover(isPresented: $showResult) {
            DetectionResultScreen(result: prediction ?? "Unknown")
        }

        .alert("Camera Access Required", isPresented: $cameraManager.showPermissionAlert) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("We use the camera to take a picture of your battery to determine if your battery is bulging.")
        }
    }
    
    private func runClassification() {
        guard let classifier else {
            print("Classifier is nil (model failed to load)")
            prediction = "Unknown"
            showResult = true
            return
        }
        
        guard let image = capturedImage else { return }
        
        showLoading = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            let result = classifier.classify(image)
            
            DispatchQueue.main.async {
                showLoading = false
                prediction = result ?? "Unknown"
                showResult = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeScreen()
        }
    }
}
