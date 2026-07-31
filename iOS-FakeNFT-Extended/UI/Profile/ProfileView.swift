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
    @State private var path: [Route] = []

    @MainActor
    init(profileService: ProfileService) {
        _viewModel = State(initialValue: ProfileViewModel(profileService: profileService))
    }

    var body: some View {
        NavigationStack(path: $path) {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {}) {
                            Image(systemName: Constants.editIcon)
                                .foregroundStyle(Color.primary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    destination(for: route)
                }
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

    private func loadedContent(for profile: ProfileModel) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header(for: profile)

                Text(profile.description)
                    .font(.system(size: 13))
                    .lineSpacing(3)
                    .foregroundStyle(Color.primary)
                    .padding(.top, 20)

                if let websiteURL = profile.websiteURL {
                    Button(profile.website) {
                        path.append(.website(websiteURL))
                    }
                    .font(.system(size: 15))
                    .foregroundStyle(Color.blue)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 8)
                }

                menu(for: profile)
                    .padding(.top, 40)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func header(for profile: ProfileModel) -> some View {
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

    private func menu(for profile: ProfileModel) -> some View {
        List {
            menuRow(title: Constants.myNftTitle, count: profile.nfts.count, route: .myNft)
            menuRow(title: Constants.favoriteNftTitle, count: profile.likes.count, route: .favoriteNft)
        }
        .listStyle(.plain)
        .scrollDisabled(true)
        .frame(height: 108)
    }

    private func menuRow(title: String, count: Int, route: Route) -> some View {
        Button {
            path.append(route)
        } label: {
            HStack(spacing: 8) {
                Text("\(title) (\(count))")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color.primary)

                Spacer()

                Image(systemName: Constants.chevronIcon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.primary)
            }
            .frame(height: 54)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    private func destination(for route: Route) -> some View {
        switch route {
        case .myNft:
            ContentUnavailableView(Constants.myNftTitle, systemImage: "square.stack")
                .navigationTitle(Constants.myNftTitle)
                .navigationBarTitleDisplayMode(.inline)
        case .favoriteNft:
            ContentUnavailableView(Constants.favoriteNftTitle, systemImage: "heart")
                .navigationTitle(Constants.favoriteNftTitle)
                .navigationBarTitleDisplayMode(.inline)
        case let .website(url):
            ContentUnavailableView(url.absoluteString, systemImage: "safari")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private enum Route: Hashable {
        case myNft
        case favoriteNft
        case website(URL)
    }

    private enum Constants {
        static let chevronIcon = "chevron.right"
        static let editIcon = "square.and.pencil"
        static let myNftTitle = "Мои NFT"
        static let favoriteNftTitle = "Избранные NFT"
    }
}

#Preview {
    ProfileView(profileService: ProfileServiceMock())
}
