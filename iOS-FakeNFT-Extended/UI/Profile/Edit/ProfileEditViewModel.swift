//
//  ProfileEditViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 06.08.2026.
//

import Foundation

@Observable
@MainActor
final class ProfileEditViewModel {

    var name: String
    var description: String
    var website: String

    /// Диалог с действиями над фото профиля.
    var isPhotoDialogPresented = false

    /// Алерт со ссылкой на новое фото.
    var isPhotoLinkPresented = false

    /// Алерт с вопросом о выходе без сохранения.
    var isExitConfirmationPresented = false

    /// Ссылка, которую пользователь вводит в алерте.
    var photoLink = ""

    private(set) var avatar: String
    private(set) var isSaving = false
    private(set) var errorMessage: String?

    var avatarURL: URL? {
        URL(string: avatar)
    }

    /// Отличаются ли поля от того, что пришло с сервера.
    var hasChanges: Bool {
        name != profile.name
            || description != profile.description
            || website != profile.website
            || avatar != profile.avatar
    }

    private let profile: ProfileDTO
    private let service: ProfileService

    init(profile: ProfileDTO, service: ProfileService) {
        self.profile = profile
        self.service = service
        name = profile.name
        description = profile.description
        website = profile.website
        avatar = profile.avatar
    }

    /// Ставит фото по ссылке из алерта.
    /// Подходит только абсолютный адрес с http или https: остальное приложение не загрузит.
    func applyPhotoLink() {
        let link = photoLink.trimmingCharacters(in: .whitespacesAndNewlines)
        photoLink = ""
        guard !link.isEmpty else { return }
        guard isImageLink(link) else {
            errorMessage = NSLocalizedString(ProfileStrings.photoLinkInvalid, comment: "")
            return
        }
        avatar = link
    }

    func removePhoto() {
        avatar = ""
    }

    /// Отправляет изменения и возвращает обновлённый профиль, либо `nil`, если запрос не удался.
    func save() async -> ProfileDTO? {
        guard !isSaving else { return nil }
        guard hasChanges else { return profile }

        isSaving = true
        defer { isSaving = false }

        let edited = ProfileDTO(
            name: name,
            avatar: avatar,
            description: description,
            website: website,
            nfts: profile.nfts,
            likes: profile.likes,
            id: profile.id
        )

        do {
            return try await service.updateProfile(profile: edited)
        } catch {
            errorMessage = ProfileErrorMessage.text(for: error)
            return nil
        }
    }

    func dismissError() {
        errorMessage = nil
    }

    private func isImageLink(_ link: String) -> Bool {
        guard let url = URL(string: link), let scheme = url.scheme?.lowercased() else { return false }
        return (scheme == "http" || scheme == "https") && url.host?.isEmpty == false
    }
}
