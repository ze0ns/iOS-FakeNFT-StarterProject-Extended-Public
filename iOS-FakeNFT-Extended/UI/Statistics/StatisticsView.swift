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
    
    // MARK: - Dependencies (для передачи в следующий экран)
    private let nftService: MyNftService
    private let profileService: ProfileService
    
    // MARK: - Init
    
    init(
        usersInfoService: UsersInfoService,
        nftService: MyNftService,
        profileService: ProfileService
    ) {
        _viewModel = StateObject(
            wrappedValue: StatisticsViewModel(usersInfoService: usersInfoService)
        )
        self.nftService = nftService
        self.profileService = profileService
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Основной контент
            NavigationStack {
                ZStack {
                    if viewModel.isLoading && viewModel.users.isEmpty {
                        // Первая загрузка — центральный индикатор
                        ProgressView("Загрузка пользователей...")
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let error = viewModel.errorMessage, viewModel.users.isEmpty {
                        // Ошибка при первой загрузке
                        errorView(error)
                    } else {
                        usersList
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation(.easeInOut) {
                                showSortPopup.toggle()
                            }
                        } label: {
                            Image(.sortButton)
                        }
                        .background(Color(.systemBackground))
                    }
                }
                .navigationDestination(item: $selectedUser) { user in
                    UserCardView(
                        userInfo: user,
                        nftService: nftService,
                        profileService: profileService,
                        onProfileUpdated: { _ in }
                    )
                }
            }
            .task {
                await viewModel.loadUsers()
            }
            
            // Индикатор дозагрузки внизу списка
            if viewModel.isLoadingMore {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                .transition(.opacity)
                .allowsHitTesting(false)
            }
            
            // Всплывающее окно сортировки
            if showSortPopup {
                sortPopupOverlay
            }
        }
        .animation(.easeInOut, value: viewModel.isLoadingMore)
    }
    
    // MARK: - Users List
    
    private var usersList: some View {
        List {
            ForEach(viewModel.users) { user in
                HStack {
                    if let index = viewModel.users.firstIndex(where: { $0.id == user.id }) {
                        Text("\(index + 1)")
                            .frame(width: 30, alignment: .leading)
                    }
                    
                    Button {
                        selectedUser = user
                    } label: {
                        UserInfoCell(
                            name: user.name,
                            score: Int(user.rating) ?? 0,
                            avatarUrl: user.avatar
                        )
                    }
                    .buttonStyle(.plain)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .onAppear {
                    // Триггер пагинации при появлении элемента
                    Task {
                        await viewModel.loadMoreIfNeeded(currentUser: user)
                    }
                }
            }
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.refresh()
        }
    }
    
    // MARK: - Error View
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            
            Text(message)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Button {
                Task { await viewModel.loadUsers() }
            } label: {
                Text("Повторить")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .padding(.top, 8)
        }
        .padding()
    }
    
    // MARK: - Sort Popup
    
    private var sortPopupOverlay: some View {
        VStack {
            // Затемненный фон
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showSortPopup = false
                    }
                }
            
            Spacer()
            
            VStack(spacing: 8) {
                VStack(spacing: 0) {
                    Text("Сортировка")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 16)
                    
                    Divider()
                    
                    Button {
                        viewModel.sortUsers(by: .name)
                        withAnimation(.easeInOut) { showSortPopup = false }
                    } label: {
                        Text("По имени")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)
                    
                    Divider()
                    
                    Button {
                        viewModel.sortUsers(by: .rating)
                        withAnimation(.easeInOut) { showSortPopup = false }
                    } label: {
                        Text("По рейтингу")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)
                }
                .background(Color(.systemBackground))
                .cornerRadius(14)
                
                Button {
                    withAnimation(.easeInOut) {
                        showSortPopup = false
                    }
                } label: {
                    Text("Закрыть")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .background(Color(.systemBackground))
                .cornerRadius(14)
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview("Success with pagination") {
    StatisticsView(
        usersInfoService: MockUsersInfoService(behavior: .paginated),
        nftService: MyNftServicePreviewStub(),
        profileService: ProfileServicePreviewStub()
    )
}
