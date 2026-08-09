//
//  UserCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 01.08.2026.
//


import SwiftUI

struct UserCardView: View {
    
    let userInfo: UserModelElement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Основное содержимое
            VStack(alignment: .leading, spacing: 16) {
                
                // Карточка пользователя
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: userInfo.avatar)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        
                        Text(userInfo.name)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.black)
                        
                    }
                    
                    // Описание
                    Text(userInfo.description ?? " ")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .lineSpacing(4)
                    
                    
                }
                .padding(.top,40)
                
                
                Button(action: {
                    print("Показать все NFT")
                }) {
                    Text("Перейти на сайт пользователя")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                }
                .padding(.bottom, 20)
                
                
                
                HStack() {
                    Button(action: {
                        print("Коллекция NFT ")
                    }) {
                        HStack {
                            Text("Коллекция NFT " + "(\(userInfo.nfts.count))")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    let userInfo = UserModelElement(name: "Алексей Бузикин",
                                            avatar: "https://i.pravatar.cc/150?img=1",
                                            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                                            website: "https://practicum.yandex.ru/devops/",
                                            nfts: [
                                                "ca34d35a-4507-47d9-9312-5ea7053994c0",
                                                "1464520d-1659-4055-8a79-4593b9569e48"
                                            ],
                                            rating: "1543",
                                            id: "7057c681-037f-4391-8ba5-4268d1a9d2b0")
    UserCardView(userInfo: userInfo)
}
