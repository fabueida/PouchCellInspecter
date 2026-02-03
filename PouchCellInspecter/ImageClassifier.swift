//
//  ImageClassifier.swift
//  Using the SVM Model
//
//  Created by Oquba Khan on 11/29/25.
//
import CoreML
import UIKit

final class ImageClassifier {
    private let model: SVMClassifier
    
    private let classNames = [
        0: "Normal",
        1: "Bulging"
    ]
    
    init?() {
        do {
            self.model = try SVMClassifier(configuration: MLModelConfiguration())
        } catch {
            print("Failed to load SVMClassifer model: \(error)")
            return nil
        }
    }
    
    func classify(_ image: UIImage) -> String? {
        guard
            let vector = ImagePreprocessing.imageToGrayscaleVector(image),
            vector.count == 128 * 128
        else {
            return nil
        }
        
        let count = vector.count
        guard let array = try? MLMultiArray(shape: [NSNumber(value: count)], dataType: .double) else {
            print ("Failed to create MLMultiArray")
            return nil
        }
        
        for i in 0..<count {
            array[i] = NSNumber(value: vector[i])
        }
        
        do {
            let prediction = try model.prediction(input: array)
            
            let labelInt = Int(prediction.classLabel)
            return classNames[labelInt] ?? "Label(\(labelInt))"
            
        } catch {
            print ("Wrapper prediction failed: \(error)")
            return nil
        }
    }
}
