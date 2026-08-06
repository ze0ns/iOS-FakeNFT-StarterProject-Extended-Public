//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 06.08.2026.
//

import Kingfisher
import SwiftUI

struct ProfileEditView: View {

    @State private var viewModel: ProfileEditViewModel

    @Environment(\.dismiss) private var dismiss

    private let onSaved: (ProfileDTO) -> Void

    @MainActor
    init(profile: ProfileDTO, service: ProfileService, onSaved: @escaping (ProfileDTO) -> Void) {
        _viewModel = State(initialValue: ProfileEditViewModel(profile: profile, service: service))
        self.onSaved = onSaved
    }

    var body: some View {
        VStack(spacing: 0) {
            fields
            saveButton
        }
        .disabled(viewModel.isSaving)
        .overlay {
            if viewModel.isSaving {
                ProgressView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .alert(
            NSLocalizedString(ProfileStrings.photoLinkTitle, comment: ""),
            isPresented: $viewModel.isPhotoLinkPresented
        ) {
            photoLinkButtons
        }
        .alert(
            NSLocalizedString(ProfileStrings.exitTitle, comment: ""),
            isPresented: $viewModel.isExitConfirmationPresented
        ) {
            Button(NSLocalizedString(ProfileStrings.stay, comment: ""), role: .cancel) {}
            Button(NSLocalizedString(ProfileStrings.exit, comment: "")) {
                dismiss()
            }
        }
        .errorAlert(message: viewModel.errorMessage) {
            viewModel.dismissError()
        }
    }

    private var fields: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                photo

                field(titleKey: ProfileStrings.nameField) {
                    TextField("", text: $viewModel.name)
                        .modifier(ProfileEditFieldStyle())
                }
                field(titleKey: ProfileStrings.descriptionField) {
                    TextEditor(text: $viewModel.description)
                        .scrollContentBackground(.hidden)
                        .modifier(ProfileEditFieldStyle())
                        .frame(height: 132)
                }
                field(titleKey: ProfileStrings.websiteField) {
                    TextField("", text: $viewModel.website)
                        .modifier(ProfileEditFieldStyle())
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private var backButton: some View {
        Button {
            close()
        } label: {
            Image(systemName: ProfileIcons.back)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color(.blackPrimary))
        }
        .buttonStyle(.plain)
    }

    private var saveButton: some View {
        PrimaryButton(title: NSLocalizedString(ProfileStrings.save, comment: "")) {
            Task { await saveAndClose() }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }

    private var photo: some View {
        KFImage(viewModel.avatarURL)
            .resizable()
            .placeholder {
                Image(systemName: ProfileIcons.avatarPlaceholder)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color(.grayUniversal))
            }
            .scaledToFill()
            .frame(width: 70, height: 70)
            .clipShape(.circle)
            .overlay(alignment: .bottomTrailing) {
                photoButton
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 22)
    }

    private var photoButton: some View {
        Button {
            viewModel.isPhotoDialogPresented = true
        } label: {
            Image(systemName: ProfileIcons.camera)
                .font(.system(size: 10))
                .foregroundStyle(Color(.whiteUniversal))
                .frame(width: 22, height: 22)
                .background(Color(.blackUniversal))
                .clipShape(.circle)
        }
        .buttonStyle(.plain)
        // Диалог объявлен на самой кнопке, иначе система указывает хвостом в центр экрана
        .confirmationDialog(
            NSLocalizedString(ProfileStrings.photoTitle, comment: ""),
            isPresented: $viewModel.isPhotoDialogPresented,
            titleVisibility: .visible
        ) {
            photoDialogButtons
        }
    }

    @ViewBuilder
    private var photoDialogButtons: some View {
        Button(NSLocalizedString(ProfileStrings.changePhoto, comment: "")) {
            viewModel.isPhotoLinkPresented = true
        }
        Button(NSLocalizedString(ProfileStrings.removePhoto, comment: ""), role: .destructive) {
            viewModel.removePhoto()
        }
        // Роль cancel не указана: система прячет такую кнопку, когда показывает диалог поповером
        Button(NSLocalizedString(ProfileStrings.cancel, comment: "")) {}
    }

    @ViewBuilder
    private var photoLinkButtons: some View {
        TextField(
            NSLocalizedString(ProfileStrings.photoLinkPlaceholder, comment: ""),
            text: $viewModel.photoLink
        )
        Button(NSLocalizedString(ProfileStrings.cancel, comment: ""), role: .cancel) {
            viewModel.photoLink = ""
        }
        Button(NSLocalizedString(ProfileStrings.save, comment: "")) {
            viewModel.applyPhotoLink()
        }
    }

    private func field(titleKey: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(NSLocalizedString(titleKey, comment: ""))
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color(.blackPrimary))

            content()
        }
        .padding(.top, 24)
    }

    /// Уходит назад, спросив про несохранённые изменения.
    private func close() {
        guard viewModel.hasChanges else {
            dismiss()
            return
        }
        viewModel.isExitConfirmationPresented = true
    }

    /// Сохраняет изменения и уходит назад: при ошибке экран остаётся открытым.
    private func saveAndClose() async {
        guard let profile = await viewModel.save() else { return }
        onSaved(profile)
        dismiss()
    }
}

/// Общий вид полей ввода на экране редактирования.
private struct ProfileEditFieldStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.system(size: 17))
            .foregroundStyle(Color(.blackPrimary))
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
            .background(Color(.lightGrayPrimary))
            .clipShape(.rect(cornerRadius: 12))
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ProfileEditView(profile: .mock, service: ProfileServiceMock(), onSaved: { _ in })
    }
}
#endif
