//
//  APICaller.swift
//  Stats
//
//  Created by Asam Zaman on 12/3/21.
//


//all these api calls seem to be written properly as we don't get any build errors but they don't give anything back to the console
import Foundation
//
final class APICaller {
    static let shared = APICaller()
//}
    struct Constants {
       static let baseAPIURL = "https://api.spotify.com/v1"
   }



//NAVID
public func getFav(completion: @escaping ((Result<String, Error>) -> Void)) {
    createRequest(
        with: URL(string: Constants.baseAPIURL + "/me/top/tracks?limit=1"), type: .GET) { request in
        let task = URLSession.shared.dataTask(with: request) {data, _, error in guard let data = data, error == nil else{
            return
        }
        
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
            }
            catch{
                completion(.failure(error))
            }
    }
        return task.resume()
}
}

    public func getFavArtist(completion: @escaping ((Result<String, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me/top/artists?limit=1"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in guard let data = data, error == nil else{
                return
            }
            
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                }
                catch{
                    completion(.failure(error))
                }
        }
            return task.resume()
    }
    }
    
    public func getFavGenre(completion: @escaping ((Result<String, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me/top/genre?limit=1"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in guard let data = data, error == nil else{
                return
            }
            
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                }
                catch{
                    completion(.failure(error))
                }
        }
            return task.resume()
    }
    }
    
    

enum HTTPMethod: String {
        case GET
        case PUT
        case POST
        case DELETE
    }

private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}


