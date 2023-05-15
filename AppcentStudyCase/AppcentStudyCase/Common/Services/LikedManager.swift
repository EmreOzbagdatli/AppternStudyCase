//
//  LikedManager.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 15.05.2023.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()

    private let favoritesKey = "favorites"

    func addFavorite(_ track: AlbumTrack) {
        var favorites = self.getFavorites()
        if !favorites.contains(where: { $0.id == track.id }) {
            favorites.append(track)
            self.setFavorites(favorites)
        }
    }

    func removeFavorite(_ track: AlbumTrack) {
        var favorites = self.getFavorites()
        if let index = favorites.firstIndex(where: { $0.id == track.id }) {
            favorites.remove(at: index)
            self.setFavorites(favorites)
        }
    }

    func isFavorite(_ track: AlbumTrack) -> Bool {
        let favorites = self.getFavorites()
        return favorites.contains(where: { $0.id == track.id })
    }

    func getFavorites() -> [AlbumTrack] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([AlbumTrack].self, from: data) else {
            return []
        }
        return favorites
    }

    private func setFavorites(_ favorites: [AlbumTrack]) {
        guard let data = try? JSONEncoder().encode(favorites) else {
            return
        }
        UserDefaults.standard.set(data, forKey: favoritesKey)
    }
}
