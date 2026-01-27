
Pouch Cell Inspector is an iOS application designed to detect bulging lithium‑ion pouch cells using machine‑learning–based computer vision. Built primarily in Swift and powered by CoreML, the app provides a fast, accessible, and reliable way to assess battery safety using only an iPhone camera.

This tool supports technicians, engineers, researchers, and everyday users by offering real‑time classification, image preprocessing, result history, and optional reporting features. The app is also intentionally designed with accessibility and low‑vision users in mind, incorporating large text, high‑contrast UI, VoiceOver compatibility, and guided capture instructions to ensure safe and inclusive use.

Whether you’re inspecting EV battery cells in a lab or checking pouch cells in a consumer device, Pouch Cell Inspector delivers a streamlined, accurate, and user‑friendly inspection workflow.

---

Features

• Real‑Time Bulging Detection
Uses a trained CoreML model to classify pouch cells as Normal or Bulging within seconds.
• Camera Capture & Photo Library Import
Take a live photo using the iPhone camera or import an existing image from the photo library for analysis.
• Advanced Image Preprocessing
Automatically adjusts lighting, normalizes input, and resizes images to ensure consistent model performance across environments.
• Accessible for Low‑Vision & Blind Users
Designed following Apple’s Human Interface Guidelines:• VoiceOver support
• Large, readable text
• High‑contrast UI
• Clear audio and haptic feedback
• Guided capture instructions for users who cannot visually align the camera

• Result Display & Confidence Scores
Shows classification results with confidence percentages, timestamps, and optional notes.
• Report Generation
Export results as structured reports (PDF/JSON) for documentation, audits, or lab use.
• Local History Tracking
Automatically saves past classifications with thumbnails and metadata for later review.
• Offline Functionality
All processing is done on‑device — no internet required, ensuring privacy and security.


---

Getting Started

Follow these steps to clone, build, and run the app in development mode.

---

1. Clone the Repository

git clone https://github.com/<your-org>/Pouch-Cell-Inspector.git
cd Pouch-Cell-Inspector


---

2. iOS App Setup (Xcode)

Requirements

• macOS with Xcode installed
• iPhone running iOS 14+
• Apple Developer account (for device deployment)
• CoreML‑compatible device (all modern iPhones)


Open the Project

open PouchCellInspector.xcodeproj


Install Dependencies

The project uses:

• SwiftUI
• CoreML
• Vision
• AVFoundation


All dependencies are native to iOS — no external package installation required.

Run on Simulator or Device

1. Select a target device in Xcode.
2. Press Run or use:cmd + r



To run on a physical iPhone:

• Connect your device
• Trust the developer certificate
• Enable Developer Mode under Settings → Privacy & Security


---

3. Machine Learning Model Setup

The app includes:

• A CoreML model trained on labeled pouch cell images
• Preprocessing pipeline for lighting and normalization
• Evaluation metrics (accuracy, precision, recall)


If you retrain or replace the model:

1. Export the .mlmodel file
2. Place it in:PouchCellInspector/Model/

3. Rebuild the project


---

4. Optional: Report Syncing / Cloud Storage

If your team enables cloud syncing in the future:

• Add your cloud configuration files (Firebase, AWS, etc.)
• Do not commit these files to the repository
• Update environment variables accordingly


---

Environment Variables (Optional)

If cloud features are enabled, create a .env file:

CLOUD_API_KEY=your_key_here
MODEL_VERSION=1.0


---

Development Notes

• The app follows the SQA, RMMM, and Project Plan guidelines from your documentation.
• All changes must go through GitHub pull requests with code reviews.
• Testing includes unit tests, integration tests, and ML evaluation tests.
• Accessibility testing is required for all UI updates.


---

Accessibility Commitment

Pouch Cell Inspector is intentionally designed for:

• Blind users
• Low‑vision users
• Users with motor impairments
• Users who rely on audio or haptic feedback


Accessibility features include:

• VoiceOver‑friendly UI
• Large, scalable text
• High‑contrast color palette
• Clear button labeling
• Minimal visual clutter
• Haptic confirmation for capture and classification
• Error messages that are screen‑reader friendly


This ensures the app can be safely used in industrial, laboratory, and consumer environments.

---

Enjoy safer battery inspections with Pouch Cell Inspector!

Built for reliability, accessibility, and real‑world performance.

If you’d like, I can also generate:

• A shorter README
• A version with images or badges
• A version formatted for App Store submission
• A version with installation GIFs or screenshots


Just tell me what direction you want to take it.