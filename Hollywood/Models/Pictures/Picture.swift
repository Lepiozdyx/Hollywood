//
//  Picture.swift
//  Hollywood
//
//  Created by Alex on 26.12.2024.
//

import Foundation

struct Picture: Identifiable, Codable, Equatable, GameItem {
    let id: UUID
    let imageName: String
    let options: [String]
    let correctAnswer: String
    
    var displayContent: String {
        return imageName
    }
    
    init(id: UUID = UUID(), imageName: String, options: [String], correctAnswer: String) {
        self.id = id
        self.imageName = imageName
        self.options = options
        self.correctAnswer = correctAnswer
    }
    
    static func == (lhs: Picture, rhs: Picture) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Mock Data
extension Picture {
    static var mock: Picture {
        Picture(
            imageName: "starwars",
            options: [
                "Star Wars",
                "Star Trek",
                "Guardians of the Galaxy"
            ],
            correctAnswer: "Star Wars"
        )
    }
}
