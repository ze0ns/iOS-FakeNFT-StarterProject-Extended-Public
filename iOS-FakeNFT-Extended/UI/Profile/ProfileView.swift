//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

import SwiftUI

struct ProfileView: View {

    @Environment(ServicesAssembly.self) private var servicesAssembly
    @State private var viewModel: ProfileViewModel?

    var body: some View {
        content
            .task {
                await loadProfile()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel?.state ?? .loading {
        case .loading:
            ProgressView()
        case let .loaded(profile):
            loadedContent(for: profile)
        case let .failed(message):
            Text(message)
                .multilineTextAlignment(.center)
                .padding(16)
        }
    }

    private func loadedContent(for profile: Profile) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(profile.name)
                .font(.headline)

            Text(profile.description)
                .font(.body)

            if let websiteURL = profile.websiteURL {
                Link(profile.website, destination: websiteURL)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
    }

    private func loadProfile() async {
        let viewModel = viewModel ?? ProfileViewModel(profileService: servicesAssembly.profileService)
        self.viewModel = viewModel
        await viewModel.loadProfile()
    }
}
