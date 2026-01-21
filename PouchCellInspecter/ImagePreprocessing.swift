//
//  ml.swift
//  placeholder
//
//  Created by Oquba Khan on 11/26/25.
//
import UIKit
import CoreGraphics

enum ImagePreprocessing {
    static func imageToGrayscaleVector (_ image: UIImage, size: Int = 128) -> [Double]? {
        guard let cgImage = image.cgImage else { return nil }
        
        let width = size
        let height = size
        let count = width * height
        
        var rawData = [UInt8](repeating: 0, count: count)
        
        guard let colorSpace = CGColorSpace(name: CGColorSpace.linearGray) ?? CGColorSpaceCreateDeviceGray() as CGColorSpace? else {
            return nil
        }
        
        guard let context = CGContext(
            data: &rawData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.none.rawValue
        ) else {
            return nil
        }
        
        context.interpolationQuality = .high
        
        context.draw(cgImage, in: CGRect(x: 0, y:0, width: width, height: height))
        
        return rawData.map { Double($0) / 255.0 }
    }
}
