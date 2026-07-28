//
//  StatisticsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//
import SwiftUI

struct StatisticsView: View {
    var body: some View {
        VStack(spacing: 0) {
            UserInfoCell(rank: 1, name: "Alex", score: 112, avatarUrl: "https://i.pravatar.cc/150?img=11")
                .padding(.horizontal)
                .padding(.top, 20)
            
            Rectangle()
                .fill(Color.purple)
                .frame(height: 4)
                .padding(.top, 20)
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    StatisticsView()
}
