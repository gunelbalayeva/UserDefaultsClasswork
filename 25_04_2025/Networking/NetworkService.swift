//
//  NetworkService.swift
//  25_04_2025
//
//  Created by User on 25.04.25.
//

import Foundation
struct NetworkService {
    func fetchCharacters(completion: @escaping ([Model]?) -> Void) {
        guard let url = URL(string: "https://bobsburgers-api.herokuapp.com/characters") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Something went wrong in data task: \(error)")
                completion(nil)
                return
            }
            if let data = data {
                do {
                    let characters = try JSONDecoder().decode([Model].self, from: data)
                    DispatchQueue.main.async {
                        completion(characters)
                    }
                } catch {
                    print("Decoding error: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
