//
//  StatisticsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//
import SwiftUI

struct StatisticsView: View {
    @StateObject private var viewModel: StatisticsViewModel
    @State private var selectedUser: UserModelElement?
    @State private var showSortPopup: Bool = false
    
    private let nftService: MyNftService
    private let profileService: ProfileService
    
    init(usersInfoService: UsersInfoService, nftService: MyNftService, profileService: ProfileService) {
        _viewModel = StateObject(wrappedValue: StatisticsViewModel(usersInfoService: usersInfoService))
        self.nftService = nftService
        self.profileService = profileService
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                mainContent
                
                if viewModel.isLoadingMore {
                    VStack {
                        Spacer()
                        ProgressView()
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .padding(.bottom, 20)
                    }
                    .transition(.opacity)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showSortPopup.toggle() } label: {
                        Image(.sortButton)
                    }
                }
            }
            .navigationDestination(item: $selectedUser) { user in
                UserCardView(
                    userId: user.id,
                    usersInfoService: viewModel.usersInfoService,
                    nftService: nftService,
                    profileService: profileService,
                    onProfileUpdated: { _ in }
                )
                .toolbar(.hidden, for: .tabBar)
            }
            .task {
                await viewModel.onAppear()
            }
            .animation(.easeInOut, value: viewModel.isLoadingMore)
            .overlay {
                if showSortPopup {
                    SortPopupView(
                        isPresented: $showSortPopup,
                        onSelect: { option in
                            viewModel.sortUsers(by: option)
                            showSortPopup = false
                        }
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Загрузка пользователей...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .error(let message):
            errorView(message)
        case .loaded(let users):
            usersList(users)
        }
    }
    
    private func usersList(_ users: [UserModelElement]) -> some View {
        List {
            ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                Button {
                    selectedUser = user
                } label: {
                    HStack {
                        Text("\(index + 1)")
                            .frame(width: 30, alignment: .leading)
                        
                        UserInfoCell(
                            name: user.name,
                            score: Int(user.rating) ?? 0,
                            avatarUrlString: user.avatar
                        )
                    }
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .task {
                    await viewModel.loadMoreIfNeeded(currentIndex: index)
                }
            }
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.loadUsers()
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle").font(.system(size: 48)).foregroundColor(.gray)
            Text(message).multilineTextAlignment(.center)
            Button("Повторить") { Task { await viewModel.loadUsers() } }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

private struct SortPopupView: View {
    @Binding var isPresented: Bool
    let onSelect: (StatisticsViewModel.SortOption) -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { isPresented = false }
            
            VStack {
                Spacer()
                VStack(spacing: 8) {
                    VStack(spacing: 0) {
                        Text("Сортировка").padding(.vertical, 16)
                        Divider()
                        Button("По имени") { onSelect(.name) }.padding(.vertical, 16)
                        Divider()
                        Button("По рейтингу") { onSelect(.rating) }.padding(.vertical, 16)
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    
                    Button("Закрыть") { isPresented = false }
                        .fontWeight(.semibold)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBackground))
                        .clipShape(.rect(cornerRadius: 14))
                }
                .padding([.bottom, .horizontal], 8)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}
#Preview("Success with pagination") {
    StatisticsView(
        usersInfoService: MockUsersInfoService(behavior: .paginated),
        nftService: MyNftServicePreviewStub(),
        profileService: ProfileServicePreviewStub()
    )
}
