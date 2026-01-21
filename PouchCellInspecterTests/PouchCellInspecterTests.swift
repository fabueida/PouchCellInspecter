//
//  PouchCellInspecterTests.swift
//  PouchCellInspecterTests
//
//  Created by Oquba Khan on 12/15/25.
//

import XCTest
@testable import PouchCellInspecter

final class ImageClassifierTests: XCTestCase {
//    func testLocalImageClassification() {
//        guard let url = Bundle(for: type(of: self)).url(forResource: "test_image", withExtension: "jpg") else {
//            XCTFail("not found")
//            return
//        }
//        
//        guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
//            XCTFail("Failed to load UIImage")
//            return
//        }
//        
//        guard let classifier = ImageClassifier() else {
//            XCTFail("Failed to initialize ImageClassifier")
//            return
//        }
//        
//        let result = classifier.classify(image)
//        print("Prediction:", result ?? "nil")
//        XCTAssertNotNil(result, "Expected a classification result")
//    }
    
    func testSanity() {
            XCTAssertTrue(true)
        }

}
