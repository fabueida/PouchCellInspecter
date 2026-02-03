//
//  SpeechManager.swift
//  PouchCellInspecter
//
//  Created by Firas Abueida on 1/23/26.
//

import AVFoundation

final class SpeechManager {

    static let shared = SpeechManager()

    private let synthesizer = AVSpeechSynthesizer()

    private init() {}

    func speak(_ text: String, settings: SpeechSettings) {
        guard settings.isEnabled else { return }

        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = settings.rate
        utterance.pitchMultiplier = settings.pitch
        utterance.voice = settings.voice

        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
