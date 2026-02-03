//
//  CameraScanScreen.swift
//  PouchCellInspecter
//
//  Created by Oquba Khan on 12/16/25.
//
import SwiftUI
struct CameraScanScreen: View {
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

struct CameraScanScreen_Previews: PreviewProvider {
    static var previews: some View {
        CameraScanScreen()
    }
}
