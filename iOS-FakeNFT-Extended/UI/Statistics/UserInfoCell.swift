//
//  LeaderboardCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//


import SwiftUI

struct UserInfoCell: View {
    let rank: Int
    let name: String
    let score: Int
    let avatarUrl: String // Или можно передавать имя картинки из Assets
    
    var body: some View {
        HStack(spacing: 16) {
            // 1. Место (ранг)
            Text("\(rank)")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 30) // Фиксированная ширина для выравнивания
                .multilineTextAlignment(.center)
            
            // 2. Аватар
            // В реальном приложении используйте AsyncImage для загрузки по URL
            AsyncImage(url: URL(string: avatarUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "person.crop.circle.fill") // Заглушка при ошибке
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 44, height: 44)
            .clipShape(Circle()) // Делаем картинку круглой
            
            // 3. Имя
            Text(name)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.black)
            
            // 4. Распорка (прижимает счет вправо)
            Spacer()
            
            // 5. Счет
            Text("\(score)")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(red: 0.96, green: 0.96, blue: 0.97)) // Светло-серый фон
        .cornerRadius(16) // Закругленные углы
    }
}
