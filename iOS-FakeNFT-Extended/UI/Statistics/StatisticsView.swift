//
//  StatisticsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//
import SwiftUI

struct StatisticsView: View {
    @State
    private var users: [UserModelElement] = [
        UserModelElement(name: "Алексей Бузикин",
                         avatar: "https://i.pravatar.cc/150?img=1",
                         description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                         website: "https://practicum.yandex.ru/devops/",
                         nfts: [
                            "ca34d35a-4507-47d9-9312-5ea7053994c0",
                            "1464520d-1659-4055-8a79-4593b9569e48"
                         ],
                         rating: "1543",
                         id: "7057c681-037f-4391-8ba5-4268d1a9d2b1"),
        UserModelElement(name: "Алексей Пупкин",
                         avatar: "https://i.pravatar.cc/150?img=1",
                         description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                         website: "https://practicum.yandex.ru/devops/",
                         nfts: [
                            "ca34d35a-4507-47d9-9312-5ea7053994c0",
                            "1464520d-1659-4055-8a79-4593b9569e44"
                         ],
                         rating: "734",
                         id: "7057c681-037f-4391-8ba5-4268d1a9d2b2"),
        UserModelElement(name: "Иван Бузикин",
                         avatar: "https://i.pravatar.cc/150?img=1",
                         description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                         website: "https://practicum.yandex.ru/devops/",
                         nfts: [
                            "ca34d35a-4507-47d9-9312-5ea7053994c0",
                            "1464520d-1659-4055-8a79-4593b9569e48"
                         ],
                         rating: "942",
                         id: "7057c681-037f-4391-8ba5-4268d1a9d2b0")
    ]
    

    @State private var selectedUser: UserModelElement?
    @State private var showSortPopup: Bool = false
    
    enum SortOption {
        case name
        case rating
    }
    
    var body: some View {
        ZStack {
            // Основной контент
            NavigationStack {
                List {
                    ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                        HStack {
                            Text("\(index + 1)")
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
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    }
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation(.easeInOut) {
                                showSortPopup.toggle()
                            }
                        } label: {
                            Image(systemName: "list.dash.badge.ellipsis")
                        }
                        .background(Color(.systemBackground))
                    }
                }
                .navigationDestination(item: $selectedUser) { user in
                    UserCardView(userInfo: user)
                }
            }
            
            // Всплывающее окно сортировки
            if showSortPopup {
                // Затемненный фон
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSortPopup = false
                        }
                    }
                
                VStack {
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
                                sortUsers(by: .name)
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
                                sortUsers(by: .rating)
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
    }
    
    private func sortUsers(by option: SortOption) {
        switch option {
        case .name:
            users.sort { $0.name < $1.name }
        case .rating:
            // Конвертируем строковый рейтинг в Int для корректной сортировки чисел, а не строк
            users.sort { (Int($0.rating) ?? 0) > (Int($1.rating) ?? 0) }
        }
        
        withAnimation(.easeInOut) {
            showSortPopup = false
        }
    }
}

#Preview {
    StatisticsView()
}
