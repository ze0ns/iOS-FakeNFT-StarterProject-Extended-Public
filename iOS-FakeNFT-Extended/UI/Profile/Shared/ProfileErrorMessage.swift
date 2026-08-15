//
//  ProfileErrorMessage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 09.08.2026.
//

import Foundation

/// Текст ошибки для экранов профиля.
enum ProfileErrorMessage {

    /// `URLSession` бросает `URLError` мимо `NetworkClientError`, поэтому обрыв сети ловится отдельно.
    static func text(for error: Error) -> String {
        let isNetwork = error is NetworkClientError || error is URLError
        let key = isNetwork ? ProfileStrings.networkError : ProfileStrings.unknownError
        return NSLocalizedString(key, comment: "")
    }
}
