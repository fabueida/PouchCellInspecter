import SwiftUI
import AVFoundation
import Combine

@MainActor
final class CameraPermissionManager: ObservableObject {

    @Published var permissionGranted: Bool = false
    @Published var showPermissionAlert: Bool = false

    func requestPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {

        case .authorized:
            permissionGranted = true
            showPermissionAlert = false

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                Task { @MainActor in
                    self.permissionGranted = granted
                    self.showPermissionAlert = !granted
                }
            }

        case .denied, .restricted:
            permissionGranted = false
            showPermissionAlert = true

        @unknown default:
            permissionGranted = false
            showPermissionAlert = true
        }
    }
}

