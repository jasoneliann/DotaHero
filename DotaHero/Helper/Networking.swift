//
//  Networking.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation

class Netwroking {
    static let shared: Netwroking = Netwroking()
    let session: URLSession = URLSession.shared
    
    func request(url: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Do something...
            completion(data, error)
        })
        
        task.resume()
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    func downloadImage(url: String, completion: @escaping (Data?) -> Void) {
        guard let imageUrl = URL(string: url) else { return }
        getDataFromUrl(url: imageUrl) { data, _, _ in
            DispatchQueue.main.async() {
                completion(data)
            }
        }
    }
    
}
