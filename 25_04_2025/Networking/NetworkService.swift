//
//  NetworkService.swift
//  25_04_2025
//
//  Created by User on 25.04.25.
//

import Foundation
struct NetworkService {
    func fetchCharakters(completion: @escaping ([Model.Character]) -> Void) {
        let url = URL(string: "https://bobsburgers-api.herokuapp.com/characters?hair=Blonde&id=52")!
           let request = URLRequest(url: url)
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Something went wrong in data task: \(error)")
                   return
               }
               if let data = data {
                   do {
                       let characters = try JSONDecoder().decode([Model.Character].self, from: data)
                       completion(characters)
                   } catch {
                       print("Decoding error: \(error)")
                   }
               }
           }
           task.resume()
       }
}
