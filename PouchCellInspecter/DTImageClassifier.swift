//
//  DTImageClassifier.swift
//  PouchCellInspecter
//
//  Created by Oquba Khan on 1/30/26.
//

import CoreML
import Vision
import UIKit

struct PredictionResult {
    let classLabel: Int
    let probabilities: [Int: Double]
    let topK: [(label: Int, prob: Double)]
}

final class DTImageClassifier {
    private let model: DTClassifier
    
    init() {
        let config = MLModelConfiguration()
        config.computeUnits = .all
        self.model = try! DTClassifier(configuration: config)
    }
    
    func classify(image: UIImage) throws -> PredictionResult {
        guard let inputArray = ImagePreprocessing.imageToGrayscaleMultiArray(image) else {
            throw NSError(
                domain: "DTImageClassifier",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to preprocess image into MLMultiArray"]
            )
        }
        let out = try model.prediction(input: inputArray)
        
        let label = Int(out.classLabel)
        
        var probs: [Int: Double] = [:]
        
        let rawProbs: [Int64: Double] = out.classProbability
        
        for (k, v) in rawProbs {
            probs[Int(k)] = v
        }
        
        let topK = probs
            .sorted { $0.value > $1.value }
            .prefix(3)
            .map { (label: $0.key, prob: $0.value) }
        
        return PredictionResult(classLabel: label, probabilities: probs, topK: topK)
    }
}
