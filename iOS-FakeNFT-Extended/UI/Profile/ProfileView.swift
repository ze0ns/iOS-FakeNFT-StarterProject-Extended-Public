//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

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
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
