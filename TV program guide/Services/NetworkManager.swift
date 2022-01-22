//
//  NetworkManager.swift
//  TV program guide
//
//  Created by Александр on 22.01.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let limeHdApiUrl = "http://limehd.online/playlist"
    private init() {}
    
    func fetchData(completion: @escaping (Result<TVProgram, Error>) -> Void) {
        guard let url = URL(string: limeHdApiUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(ApiError.badResponse))
                return
            }
            do {
                let tvProgram = try JSONDecoder().decode(TVProgram.self, from: data)
                completion(.success(tvProgram))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum ApiError: Error {
    case badResponse
}
