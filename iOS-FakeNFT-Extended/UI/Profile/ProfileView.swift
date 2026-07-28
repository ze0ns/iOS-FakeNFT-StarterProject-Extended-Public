//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

import Kingfisher
import SwiftUI

struct ProfileView: View {

    @State private var viewModel: ProfileViewModel

    @MainActor
    init(profileService: ProfileService) {
        _viewModel = State(initialValue: ProfileViewModel(profileService: profileService))
    }

    var body: some View {
        NavigationStack {
            content
        }
        .task {
            await viewModel.loadProfile()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .loaded(profile):
            loadedContent(for: profile)
        case let .failed(message):
            Text(message)
                .multilineTextAlignment(.center)
                .padding(16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func loadedContent(for profile: Profile) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            header(for: profile)

            Text(profile.description)
                .font(.system(size: 13))
                .lineSpacing(3)
                .foregroundStyle(Color.primary)
                .padding(.top, 20)

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func header(for profile: Profile) -> some View {
        HStack(spacing: 16) {
            KFImage(profile.avatarURL)
                .resizable()
                .placeholder {
                    Circle()
                        .fill(Color(.systemGray5))
                }
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(.circle)

            Text(profile.name)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color.primary)

            Spacer(minLength: 0)
        }
        .padding(.top, 20)
    }
}
