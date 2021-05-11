//
//  ApiService.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/8/21.
//

import UIKit

class ApiService {
    
    private let baseURL = "https://picsum.photos/"
    
    func getListOfPictures(page : Int, limit : Int = 100, completed : @escaping (Result<[ImageDetail],MatchError>) -> Void) {
       
        let endPoint  = baseURL + "v2/list?page=\(page)&limit=\(limit)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            //Decode data to the model
            do {
                let images = try JSONDecoder().decode([ImageDetail].self, from: data)
                completed(.success(images))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
}
