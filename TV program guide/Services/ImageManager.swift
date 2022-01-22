//
//  ImageManager.swift
//  TV program guide
//
//  Created by Александр on 22.01.2022.
//

import Foundation

class ImageManger {
    static let shared = ImageManger()
    private init() {}
    
    func fetchImageData(from url: URL?) -> Data? {
        guard let url = url else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
