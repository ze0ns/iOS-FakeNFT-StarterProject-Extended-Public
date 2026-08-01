//
//  ProfileState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

/// Состояние экрана профиля.
enum ProfileState {

    /// Данные загружаются.
    case loading

    /// Данные успешно загружены.
    case success(ProfileDTO)

    /// Загрузка завершилась ошибкой, содержит текст для пользователя.
    case error(String)
}
