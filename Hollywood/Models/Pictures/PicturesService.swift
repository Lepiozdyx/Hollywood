//
//  PicturesService.swift
//  Hollywood
//
//  Created by Alex on 26.12.2024.
//

import Foundation

protocol PicturesServiceProtocol {
    func loadPictures() async throws -> [Picture]
    func getRandomPicture(excluding: Set<UUID>) async throws -> Picture?
    func isPictureAnswered(id: UUID, answeredPictures: Set<UUID>) -> Bool
}

final class PicturesService: PicturesServiceProtocol {
    private var allPictures: [Picture] = []
    
    func loadPictures() async throws -> [Picture] {
        if allPictures.isEmpty {
            guard let url = Bundle.main.url(forResource: "pictures", withExtension: "json") else {
                throw PicturesError.fileNotFound
            }
            
            let data = try Data(contentsOf: url)
            let picturesDTO = try JSONDecoder().decode(PicturesDTO.self, from: data)
            
            allPictures = picturesDTO.pictures.map { dto in
                var options = dto.options
                options.shuffle() // Перемешиваем варианты ответов
                return Picture(
                    id: UUID(),
                    imageName: dto.imageName,
                    options: options,
                    correctAnswer: dto.correctAnswer
                )
            }
        }
        
        return allPictures
    }
    
    func getRandomPicture(excluding answeredPictures: Set<UUID>) async throws -> Picture? {
        let pictures = try await loadPictures()
        let availablePictures = pictures.filter { !answeredPictures.contains($0.id) }
        return availablePictures.randomElement()
    }
    
    func isPictureAnswered(id: UUID, answeredPictures: Set<UUID>) -> Bool {
        answeredPictures.contains(id)
    }
}

// MARK: - Errors
extension PicturesService {
    enum PicturesError: Error {
        case fileNotFound
        case noAvailablePictures
    }
}
