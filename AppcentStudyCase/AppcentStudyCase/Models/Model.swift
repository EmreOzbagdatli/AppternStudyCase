//
//  Model.swift
//  AppcentStudyCase
//
//  Created by Emre Özbağdatlı on 15.05.2023.
//

import Foundation


class Model {
    
    static let shared = Model()
    
    
    func getGenreInfo(completion: @escaping ([Genre]?, Error?) -> Void) {
        let url = URL(string: "http://api.deezer.com/genre")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error var \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                print("error var \(error?.localizedDescription)")
                      completion(nil, NSError(domain: "Invalid Response", code: 0, userInfo: nil))
                      return
                  }
            
            do {
                let genres = try JSONDecoder().decode([Genre].self, from: data)
                print("error var \(error?.localizedDescription)")
                completion(genres, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}




struct Genre: Codable {
    let name: String
    let picture: String
}
