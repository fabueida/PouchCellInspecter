//
//  SpeechSettings.swift
//  PouchCellInspecter
//
//  Created by Firas Abueida on 1/23/26.
//

import AVFoundation

struct SpeechSettings: Codable {
    var isEnabled: Bool
    var rate: Float
    var pitch: Float
    var voiceIdentifier: String?

    var voice: AVSpeechSynthesisVoice? {
        if let id = voiceIdentifier {
            return AVSpeechSynthesisVoice(identifier: id)
        }
        return AVSpeechSynthesisVoice(language: Locale.current.identifier)
    }

    static let `default` = SpeechSettings(
        isEnabled: false,
        rate: AVSpeechUtteranceDefaultSpeechRate,
        pitch: 1.0,
        voiceIdentifier: nil
    )
}
