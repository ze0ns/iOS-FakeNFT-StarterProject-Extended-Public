//
//  StatisticsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//
import SwiftUI

struct StatisticsView: View {
    @State private var users: [UserInfoCellModel] = [
        UserInfoCellModel(name: "Алексей", score: 1540, avatarUrl: "https://i.pravatar.cc/150?img=1"),
        UserInfoCellModel(name: "Мария", score: 1320, avatarUrl: "https://i.pravatar.cc/150?img=5"),
        UserInfoCellModel(name: "Иван", score: 1100, avatarUrl: "https://i.pravatar.cc/150?img=8"),
        UserInfoCellModel(name: "Елена", score: 980, avatarUrl: "https://i.pravatar.cc/150?img=12"),
        UserInfoCellModel(name: "Дмитрий", score: 850, avatarUrl: "https://i.pravatar.cc/150?img=15")
    ]
    
    @State private var selectedUser: UserInfoCellModel?
    @State private var showSortPopup: Bool = false
    
    var body: some View {
        ZStack {
            // Основной контент
            NavigationStack {
                List {
                    ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                        HStack {
                            Text("\(index+1)")
                            Button {
                                selectedUser = user
                            } label: {
                                UserInfoCell(
                                    name: user.name,
                                    score: user.score,
                                    avatarUrl: user.avatarUrl
                                )
                            }
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
                    DetailUserView(user: user)
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
            users.sort { $0.score > $1.score }
        }
        
        withAnimation(.easeInOut) {
            showSortPopup = false
        }
    }
}

//MOCK Detail View
struct DetailUserView: View {
    let user: UserInfoCellModel
    var body: some View {
        EmptyView()
    }
}

#Preview {
    StatisticsView()
}
