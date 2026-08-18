//
//  UserInfoCellModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 29.07.2026.
//
import SwiftUI

struct UserInfoCellModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let score: Int
    let avatarUrl: String
}
