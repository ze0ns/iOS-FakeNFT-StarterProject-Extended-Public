//
//  StatisticsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//


import Foundation

@MainActor
final class StatisticsViewModel: ObservableObject {

    enum ViewState {
        case loading
        case loaded([UserModelElement])
        case error(String)
    }
    
    @Published private(set) var state: ViewState = .loading
    @Published private(set) var isLoadingMore: Bool = false
    
    let usersInfoService: UsersInfoService
    private var currentPage: Int = 1
    private var hasMorePages: Bool = true
    private var sortOption: SortOption?
    
    enum SortOption {
        case name
        case rating
    }
    
    init(usersInfoService: UsersInfoService) {
        self.usersInfoService = usersInfoService
    }
    
    // MARK: - Public API (Intents)
    
    func onAppear() async {
        if case .loaded = state { return } 
        await loadUsers()
    }
    
    func loadUsers() async {
        state = .loading
        currentPage = 1
        hasMorePages = true
        
        do {
            let response = try await usersInfoService.loadUsersInfo(page: String(currentPage))
            state = .loaded(applySortingIfNeeded(to: response))
            hasMorePages = !response.isEmpty
        } catch {
            state = .error("Не удалось загрузить пользователей")
        }
    }
    
    func loadMoreIfNeeded(currentIndex: Int) async {
        guard case let .loaded(users) = state, !isLoadingMore, hasMorePages else { return }
        
        // Триггер подгрузки за 3 элемента до конца
        let thresholdIndex = users.index(users.endIndex, offsetBy: -3, limitedBy: users.startIndex) ?? users.startIndex
        guard currentIndex >= thresholdIndex else { return }
        
        isLoadingMore = true
        
        do {
            let nextPage = currentPage + 1
            let response = try await usersInfoService.loadUsersInfo(page: String(nextPage))
            
            if response.isEmpty {
                hasMorePages = false
            } else {
                let newUsers = users + response
                state = .loaded(applySortingIfNeeded(to: newUsers))
                currentPage = nextPage
            }
        } catch {
            print("Error loading more users: \(error)")
        }
        
        isLoadingMore = false
    }
    
    func sortUsers(by option: SortOption) {
        sortOption = option
        if case let .loaded(currentUsers) = state {
            state = .loaded(applySortingIfNeeded(to: currentUsers))
        }
    }
    
    // MARK: - Private
    
    private func applySortingIfNeeded(to users: [UserModelElement]) -> [UserModelElement] {
        guard let option = sortOption else { return users }
        
        switch option {
        case .name:
            return users.sorted { $0.name < $1.name }
        case .rating:
            return users.sorted { (Int($0.rating) ?? 0) > (Int($1.rating) ?? 0) }
        }
    }
}
