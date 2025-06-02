//
//  UserDefaultsManager.swift
//  25_04_2025
//
//  Created by User on 28.04.25.
//
import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let favoritesKey = "favoritesKey"

    func toggleFavorite(id: Int) {
        var favorites = getFavorites()
        if favorites.contains(id) {
            favorites.removeAll(where: { $0 == id })
        } else {
            favorites.append(id)
        }
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }

    func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }

    func isFavorite(id: Int) -> Bool {
        return getFavorites().contains(id)
    }
}
