//
//  UserCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 01.08.2026.
//

import SwiftUI

struct UserCardView: View {
    @StateObject private var viewModel: UserCardViewModel
    @State private var showWebsite: Bool = false
    
    init(
        userId: String,
        usersInfoService: UsersInfoService,
        nftService: MyNftService,
        profileService: ProfileService,
        onProfileUpdated: @escaping (ProfileDTO) -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: UserCardViewModel(
                userId: userId,
                usersInfoService: usersInfoService,
                nftService: nftService,
                profileService: profileService,
                onProfileUpdated: onProfileUpdated
            )
        )
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let message):
                VStack {
                    Text(message)
                    Button("Повторить") { Task { await viewModel.loadUserInfo() } }
                }
            case .loaded(let userInfo):
                content(for: userInfo)
            }
        }
        .task {
            if case .loading = viewModel.state {
                await viewModel.loadUserInfo()
            }
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - Content
    private func content(for userInfo: UserModelElement) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 20) {
                    AsyncImage(url: URL(string: userInfo.avatar)) { phase in
                        switch phase {
                        case .empty: ProgressView()
                        case .success(let image): image.resizable().aspectRatio(contentMode: .fill)
                        case .failure: Image(systemName: "person.crop.circle.fill").foregroundColor(.gray)
                        @unknown default: EmptyView()
                        }
                    }
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    
                    Text(userInfo.name)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Text(userInfo.description ?? " ")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .lineSpacing(4)
            }
            .padding(.top, 40)
            Button {
                showWebsite = true
            } label: {
                Text("Перейти на сайт пользователя")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.black, lineWidth: 0.5))
            }
            .padding(.bottom, 20)
            
            NavigationLink {
                UserCollectionsNFTView(
                    likeIds: userInfo.nfts,
                    service: viewModel.nftService,
                    profileService: viewModel.profileService,
                    onProfileUpdated: viewModel.onProfileUpdated
                )
            } label: {
                HStack {
                    Text("Коллекция NFT (\(userInfo.nfts.count))")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundStyle(Color.black)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $showWebsite) {
            if let url = URL(string: userInfo.website) {
                NavigationStack {
                    WebView(url: url)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Готово") {
                                    showWebsite = false
                                }
                            }
                        }
                }
            }
        }
    }
}
