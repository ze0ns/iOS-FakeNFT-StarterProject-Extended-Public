//
//  MyNftState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

/// Состояние экрана «Мои NFT».
enum MyNftState {

    /// Данные загружаются.
    case loading

    /// Данные успешно загружены, список может быть пустым.
    case success([Nft])

    /// Загрузка завершилась ошибкой, содержит текст для пользователя.
    case error(String)
}
