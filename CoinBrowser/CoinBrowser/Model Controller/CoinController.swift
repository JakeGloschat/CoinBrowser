//
//  CoinController.swift
//  CoinBrowser
//
//  Created by Jake Gloschat on 2/20/23.
//

import Foundation

class CoinController {
    
    static func fetchCoins(completion: @escaping (Coin?) -> Void) {
        
        guard let baseURL = URL(string: Constants.CoinWars.baseURL) else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.CoinWars.coinPath)
        
        guard let finalURL = urlComponents?.url else { return }
        print("Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { return }
            
            do {
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                    let coins = Coin(dictionary: topLevel)
                    completion(coins)
                }
            } catch {
                print("Error in Do/Try/Catch: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    } // end of func
} // End of Class
