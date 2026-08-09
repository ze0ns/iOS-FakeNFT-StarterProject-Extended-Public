//
//  FormURLEncodedBody.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 06.08.2026.
//

import Foundation

/// Тело запроса в формате `application/x-www-form-urlencoded`.
/// Сетевой слой отправляет строку как есть, поэтому значения экранируются здесь.
struct FormURLEncodedBody {

    /// Символы, которые можно оставить как есть: всё остальное экранируется,
    /// иначе имя со знаком «&» или «=» разорвёт тело запроса.
    private static let allowedCharacters: CharacterSet = {
        var characters = CharacterSet.alphanumerics
        characters.insert(charactersIn: "-._~")
        return characters
    }()

    private var pairs: [String] = []

    /// Готовое тело запроса.
    var text: String {
        pairs.joined(separator: "&")
    }

    /// Добавляет одно поле.
    mutating func append(_ name: String, _ value: String) {
        let escaped = value.addingPercentEncoding(withAllowedCharacters: Self.allowedCharacters) ?? ""
        pairs.append("\(name)=\(escaped)")
    }

    /// Добавляет список значений: сервер ждёт повторение имени поля для каждого элемента.
    mutating func append(_ name: String, values: [String]) {
        for value in values {
            append(name, value)
        }
    }
}
