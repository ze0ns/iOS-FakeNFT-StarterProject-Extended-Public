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
    @State private var isSortedAscending = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                    
                    HStack(){
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
                    // Кнопка сортировки
                    Button {
                        isSortedAscending.toggle() // Меняем направление
                        sortUsers()
                    } label: {
                        // Иконка меняется в зависимости от направления сортировки
                        Image(systemName: isSortedAscending ? "arrow.up" : "arrow.down")
                    }
                }
            }
            .navigationDestination(item: $selectedUser) { user in
                DetailUserView(user: user)
            }
        }
    }
    //MOCK sort by name
    private func sortUsers() {
        if isSortedAscending {
            users.sort { $0.score < $1.score }
        } else {
            users.sort { $0.score > $1.score }
        }
    }
}
//MOCK Detail View
struct DetailUserView: View{
    let user: UserInfoCellModel
    var body: some View{
        
    }
}


#Preview {
    StatisticsView()
}
