//
//  All.swift
//  PouchCellInspecter
//
//  Created by Oquba Khan on 12/16/25.
//
import SwiftUI
struct Intro: View {
    var body: some View {
        ZStack {
            // Background color from Figma (#DCE3E8)
            Color(red: 0.86, green: 0.89, blue: 0.91)
                .ignoresSafeArea()
            VStack(spacing: 24) {
                // Logo image – make sure the asset is named exactly "background"
                // If your logo has a different name, change it here
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200) // Adjust to match your Figma size
                    .shadow(radius: 4)
                // App Title
                Text("PouchCell Inspector")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
    }
}
struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        Intro()
    }
}

struct Home: View {
    var body: some View {
        ZStack {
            // Same background as loading screen
            Color(red: 0.86, green: 0.89, blue: 0.91)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // App title
                Text("PouchCell Inspector")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                VStack(spacing: 30) {
                    // Scan Battery button
                    Button(action: {
                        // TODO: Scan battery action
                    }) {
                        Text("Scan Battery")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color("DarkBlue"))   // 🔹 custom color from Assets
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 40)

                    // Safety Info button
                    Button(action: {
                        // TODO: Safety info action
                    }) {
                        Text("Safety Info")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color("DarkBlue"))   // 🔹 custom color from Assets
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 70)
                }

                Spacer()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Camera Scan Screen
struct CSS: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 0.92, green: 0.95, blue: 0.98)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)

                Spacer().frame(height: 10)
                
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(red: 0.61, green: 0.69, blue: 0.72))
                    .frame(width: 320, height: 230)
                    .overlay(
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.black)
                    )
                
                Text("Position the battery in frame")
                    .font(.system(size: 20))
                    .padding(.top, 10)
                
                Button(action: {
                    // Scan action
                }) {
                    Text("Scan")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color(red: 0.73, green: 0.81, blue: 0.86))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 80)
                
                Button(action: {
                    // Upload from Photos action
                }) {
                    Text("Upload from Photos")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                .padding(.top, -10)
                
                Spacer()
            }
        }
    }
}

struct CSS_Previews: PreviewProvider {
    static var previews: some View {
        CSS()
    }
}

struct AnalysisLoadingScreen: View {
    var body: some View {
        ZStack {
            // App background (same as other screens)
            Color(red: 0.86, green: 0.89, blue: 0.91)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                // Top back button
                HStack {
                    Button(action: {
                        // TODO: go back
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)

                // Camera card
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("DarkBlue"))                    // 🔹 changed to DarkBlue
                    .frame(height: 220)
                    .overlay(
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .padding(60)
                            .foregroundColor(.black)
                    )
                    .padding(.horizontal, 32)

                Spacer().frame(height: 40)

                // Label
                Text("Analyzing Battery...")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.black)

                // Loading spinner with DarkBlue circle behind it
                ZStack {
                    Circle()
                        .fill(Color("DarkBlue"))                // 🔹 dark blue circle
                        .frame(width: 130, height: 130)

                    Image("LoadingIcon")                         // your spinner asset
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                }

                Spacer()
            }
        }
    }
}

struct AnalysisLoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisLoadingScreen()
    }
}

// Detection Result Screen
struct DRS: View {
    var body: some View {
        ZStack {
            // Background (same as other screens)
            Color(red: 0.86, green: 0.89, blue: 0.91)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                // Top back button
                HStack {
                    Button(action: {
                        // TODO: go back
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)

                // Camera card
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.73, green: 0.81, blue: 0.86)) // same grey as buttons
                    .frame(height: 180)
                    .overlay(
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .padding(40)
                            .foregroundColor(.black)
                    )
                    .padding(.horizontal, 32)

                // Result text
                Text("Battery is Normal")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.top, 8)

                // Short explanation label
                Text("Short Explanation")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.black)

                // Two grey placeholder lines
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(red: 0.90, green: 0.92, blue: 0.94))
                        .frame(width: 230, height: 6)

                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(red: 0.90, green: 0.92, blue: 0.94))
                        .frame(width: 230, height: 6)
                }

                Spacer()

                // Buttons
                VStack(spacing: 20) {
                    Button(action: {
                        // TODO: scan again
                    }) {
                        Text("Scan")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 0.73, green: 0.81, blue: 0.86))
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 60)

                    Button(action: {
                        // TODO: navigate to safety tips
                    }) {
                        Text("View Safety Tips")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 0.73, green: 0.81, blue: 0.86))
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 60)
                }

                Spacer(minLength: 24)
            }
        }
    }
}

struct DRS_Previews: PreviewProvider {
    static var previews: some View {
        DRS()
    }
}

struct SafetyInfoScreen: View {
    var body: some View {
        ZStack {
            Color(red: 0.92, green: 0.95, blue: 0.98)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {

                // Back button (visual only)
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                        .background(Color.white)
                        .clipShape(Circle())
                    Spacer()
                }

                Text("Battery Safety Tips")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.top, 10)

                section("What is Battery Swelling?")
                section("Signs of Swelling")
                section("Causes of Swelling")
                section("What to do if Swelling is Detected")

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
        }
    }

    private func section(_ title: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 20, weight: .semibold))

            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 6)
                .cornerRadius(3)

            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 6)
                .cornerRadius(3)
        }
    }
}

struct SafetyInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        SafetyInfoScreen()
    }
}

struct AboutAppScreen: View {
    var body: some View {
        ZStack {
            Color(red: 0.92, green: 0.95, blue: 0.98)
                .ignoresSafeArea()

            VStack(spacing: 30) {

                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                        .background(Color.white)
                        .clipShape(Circle())
                    Spacer()
                }

                Text("About This App")
                    .font(.system(size: 26, weight: .bold))
                    .padding()
                    .background(Color(red: 0.73, green: 0.81, blue: 0.86))
                    .cornerRadius(14)

                Text("""
This app helps detect swelling in lithium-ion car batteries. It uses machine learning and computer vision to analyze photos and identify possible safety risks.

The goal of the app is to help users stay safe, understand battery problems early, and protect their vehicles from damage.

It is designed to be simple, fast, and useful for anyone working with electric vehicle batteries.
""")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

                Spacer()

                HStack(alignment: .top, spacing: 50) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Developers")
                            .font(.system(size: 16, weight: .bold))
                        Text("Eman Sedqi")
                        Text("Oquba Khan")
                        Text("Nesreen Ismail")
                        Text("Firas Abueida")
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("University of Michigan")
                        Text("Dearborn")
                        Text("Dr. Jie Shen")
                    }
                }
                .font(.system(size: 14))

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
}

struct AboutAppScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppScreen()
    }
}

struct InvalidImageScreen: View {
    var body: some View {
        ZStack {
            Color(red: 0.92, green: 0.95, blue: 0.98)
                .ignoresSafeArea()

            VStack(spacing: 28) {

                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                        .background(Color.white)
                        .clipShape(Circle())
                    Spacer()
                }

                Spacer()

                Text("Image Not\nRecognized")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)

                Text("""
The battery is not clearly visible in this image.
Please try again with a clearer photo.
""")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(red: 0.73, green: 0.81, blue: 0.86))
                    .frame(width: 220, height: 160)
                    .overlay(
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .foregroundColor(.black)
                    )

                Button("Retake Photo") {}
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.73, green: 0.81, blue: 0.86))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .padding(.horizontal, 60)

                Button("Choose from Photos") {}
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.73, green: 0.81, blue: 0.86))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .padding(.horizontal, 60)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
}

struct InvalidImageScreen_Previews: PreviewProvider {
    static var previews: some View {
        InvalidImageScreen()
    }
}


