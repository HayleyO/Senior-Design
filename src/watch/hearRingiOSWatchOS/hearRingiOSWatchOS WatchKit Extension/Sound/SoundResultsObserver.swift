//
//  SoundResultsObserver.swift
//  hearRingiOSWatchOS
//
//  Created by Eddie on 4/22/22.
//

import Foundation
import SoundAnalysis
import SwiftUI

class SoundResultsObserver: NSObject, SNResultsObserving {
    var globalResult:SNClassificationResult!
    var globalClassification:SNClassification!
    
    func request(_ request: SNRequest, didProduce result: SNResult) {

        guard let result = result as? SNClassificationResult else  { return }
        
        guard let classification = result.classifications.first else { return }
        
        globalResult = result
        globalClassification = classification
        
        print("You are hearing " + classification.identifier)
    }

    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The the analysis failed: \(error.localizedDescription)")
    }

    func requestDidComplete(_ request: SNRequest) {
        print("The request completed successfully!")
    }
}
