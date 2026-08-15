//
//  StatisticsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//


import Foundation
import SwiftUI

@MainActor
final class StatisticsViewModel: ObservableObject {
    
    // MARK: - Published States
    
    @Published var users: [UserModelElement] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false  // Для пагинации
    @Published var errorMessage: String?
    
    // MARK: - Private
    
    private let usersInfoService: UsersInfoService
    private var currentPage: Int = 1
    private var hasMorePages: Bool = true
    private var sortOption: SortOption?
    
    enum SortOption {
        case name
        case rating
    }
    
    // MARK: - Init
    
    init(usersInfoService: UsersInfoService) {
        self.usersInfoService = usersInfoService
    }
    
    // MARK: - Public API
    
    /// Первичная загрузка (сбрасывает пагинацию)
    func loadUsers() async {
        guard !isLoading else { return }
        
        currentPage = 1
        hasMorePages = true
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await usersInfoService.loadUsersInfo(page: String(currentPage))
            self.users = applySortingIfNeeded(to: response)
            self.hasMorePages = !response.isEmpty
        } catch {
            self.errorMessage = "Не удалось загрузить пользователей"
            print("Error loading users: \(error)")
        }
        
        isLoading = false
    }
    
    /// Подгрузка следующей страницы (вызывается при скролле вниз)
    func loadMoreIfNeeded(currentUser: UserModelElement) async {
        guard !isLoadingMore, hasMorePages else { return }
        
        // Загружаем следующую страницу, когда пользователь доскроллил до последних 3 элементов
        let thresholdIndex = users.index(users.endIndex, offsetBy: -3, limitedBy: users.startIndex) ?? users.startIndex
        guard let userIndex = users.firstIndex(where: { $0.id == currentUser.id }),
              userIndex >= thresholdIndex else { return }
        
        isLoadingMore = true
        
        do {
            let nextPage = currentPage + 1
            let response = try await usersInfoService.loadUsersInfo(page: String(nextPage))
            
            if response.isEmpty {
                hasMorePages = false
            } else {
                self.users.append(contentsOf: applySortingIfNeeded(to: response))
                self.currentPage = nextPage
            }
        } catch {
            print("Error loading more users: \(error)")
        }
        
        isLoadingMore = false
    }
    
    /// Сортировка с сохранением выбора
    func sortUsers(by option: SortOption) {
        sortOption = option
        users = applySortingIfNeeded(to: users)
    }
    
    /// Принудительное обновление (pull-to-refresh)
    func refresh() async {
        await loadUsers()
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
