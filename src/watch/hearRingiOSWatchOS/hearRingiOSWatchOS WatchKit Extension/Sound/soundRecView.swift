//
//  soundRecView.swift
//  hearring_12.4
//
//  Created by eddieredmann3 on 4/7/22.
//

import Foundation
import SwiftUI

struct soundRecView: View {
    var body: some View {
        var recognizer = soundRecognizer()
        Text(recognizer.AnalyzeAudio())
    }
}

struct soundRecViewPreviews: PreviewProvider {
    static var previews: some View {
        soundRecView()
    }
}
