//
//  GameItem.swift
//  Hollywood
//
//  Created by Alex on 26.12.2024.
//

import Foundation

protocol GameItem: Identifiable, Codable, Equatable {
    var id: UUID { get }
    var options: [String] { get }
    var correctAnswer: String { get }
    var displayContent: String { get }
}

extension GameItem {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
