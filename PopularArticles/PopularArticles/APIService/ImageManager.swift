//
//  ImageManager.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    private func store(image: UIImage, forKey key: String) {
        if let pngRepresentation = image.pngData() {
            UserDefaults.standard.set(pngRepresentation, forKey: key)
            
        }
    }
    
    private func getImage(forKey key: String) -> UIImage? {
        if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
           let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    func getImage(_ urlString: String) {
        if let storedImage = getImage(forKey: urlString) {
            image = storedImage
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        self.store(image: downloadedImage, forKey: urlString)
                        self.image = downloadedImage
                    }
                }
            }
        }).resume()
    }    
}
