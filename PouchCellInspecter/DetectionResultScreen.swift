//
//  DetectionResultScreen.swift
//  PouchCellInspecter
//
//  Created by Oquba Khan on 12/16/25.
//
import SwiftUI

struct DetectionResultScreen: View {
    let result: String
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
                Text("Battery is \(result)")
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

struct DetectionResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetectionResultScreen(result: "Normal")
    }
}
