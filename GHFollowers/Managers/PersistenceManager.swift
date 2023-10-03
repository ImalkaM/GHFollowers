//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-08-19.
//

import Foundation

enum persistenceActionType{
    case add,remove
}

enum PersistenceManager{
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite:Follower,actionType:persistenceActionType,completed: @escaping(GFErrorMessage?) -> Void){
        retrieveFavourites { result in
            switch result{
            case .success(var favorites):
                switch actionType{
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completed(save(favourites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavourites(completed: @escaping(Result<[Follower],GFErrorMessage>) -> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))        }catch{
            completed(.failure(.unabaleToFavourites))
        }
    }
    
    static func save(favourites:[Follower]) -> GFErrorMessage?{
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favourites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
            
        }catch{
            return .unabaleToFavourites
        }
    }
}
