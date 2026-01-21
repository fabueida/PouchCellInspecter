//
//  ContentView.swift
//  PouchCellInspecter
//
//  Created by Firas Abueida on 11/25/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 60) {
                Text(colorScheme == .dark ? "In dark mode" : "In light mode")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.secondary)

                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .shadow(radius: 4)

                Text("Welcome to Pouch Cell Inspector!")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

