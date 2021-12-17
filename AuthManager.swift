//
//  AuthManager.swift
//  Stats
//
//  Created by Asam Zaman on 12/3/21.
//

import Foundation
final class AuthManager{
    static let shared = AuthManager()
    
    struct Constants{
        static let clientID = "c1a1c330803240138a885bb251d3044a"
       
        static let clientSecret = "6da96315301849acab17d5f8667e9576"
        
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    }
    
    private init() {}
    
    public var signInUrl: URL?{
        let scopes = "user-read-private"
        let base = "https://accounts.spotify.com/authorize"
        let redirectURI = "https://www.google.com/"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn:Bool{
        return accessToken != nil
    }
    
    private var accessToken: String?{
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String?{
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date?{
        return UserDefaults.standard.string(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool{
        guard let expirationDate = tokenExpirationDate else{
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(
        code:String, completion: @escaping((Bool) -> Void)){
            guard let url = URL(string: Constants.tokenAPIURL) else{
                return
            }
            var components = URLComponents()
            components.queryItems = [
                URLQueryItem(name:"grant_type",value:"authorization_code"),
                URLQueryItem(name:"code",value:code),
                URLQueryItem(name:"redirect_uri",value:"https://www.google.com/")
            ]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = components.query?.data(using: .utf8)
            let basicToken = Constants.clientID+":"+Constants.clientSecret
            let data = basicToken.data(using: .utf8)
            guard let base64String = data?.base64EncodedString() else{
                print("Failure to get base64")
                completion(false)
                return
            }
            request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request){[weak self] data, _, error in
                guard let data = data,
                      error == nil else{
                          completion(false)
                          return
                      }
                do{
                    let result = try JSONDecoder().decode(AuthResponse.self, from:data)
                    self?.cacheToken(result:result)
                    completion(true)
                }
                catch{
                    print(error.localizedDescription)
                    completion(false)
                }
                
            }
            task.resume()
    }
    
    public func refreshIfNeeded(completion: @escaping (Bool) -> Void){
        //guard shouldRefreshToken else{
            //completion(true)
            //return
       // }
        
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
        
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name:"grant_type",value:"refresh_token"),
            URLQueryItem(name:"refresh_token",value:refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else{
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){[weak self] data, _, error in
            guard let data = data,
                  error == nil else{
                      completion(false)
                      return
                  }
            do{
                let result = try JSONDecoder().decode(AuthResponse.self, from:data)
                print("Successfully refreshed token")
                self?.cacheToken(result:result)
                completion(true)
            }
            catch{
                print(error.localizedDescription)
                completion(false)
            }
            
        }
        task.resume()
        

    }
    
    public func cacheToken(result: AuthResponse){
        UserDefaults.standard.setValue(result.access_token,forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token,forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)),forKey: "expirationDate")
        
    }
    
    
    
    //NAVID
    private var refreshingToken = false
    private var onRefreshBlocks = [((String) -> Void)]()
    public func withValidToken(completion: @escaping (String) -> Void) {
           guard !refreshingToken else {
               // Append the compleiton
               onRefreshBlocks.append(completion)
               return
           }

           if shouldRefreshToken {
               // Refresh
               refreshIfNeeded { [weak self] success in
                   if let token = self?.accessToken, success {
                       completion(token)
                   }
               }
           }
           else if let token = accessToken {
               completion(token)
           }
       }
}

