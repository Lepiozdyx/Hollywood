//
//  PictureDTO.swift
//  Hollywood
//
//  Created by Alex on 26.12.2024.
//

import Foundation

struct PicturesDTO: Codable {
    let pictures: [PictureDTO]
}

struct PictureDTO: Codable {
    let id: String
    let imageName: String
    let options: [String]
    let correctAnswer: String
    
    func toDomain() -> Picture {
        Picture(
            id: UUID(),
            imageName: imageName,
            options: options,
            correctAnswer: correctAnswer
        )
    }
}
