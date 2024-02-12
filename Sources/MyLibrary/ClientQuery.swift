//
//  File.swift
//  
//
//  Created by Hamza Usmani on 12/02/24.
//

import Foundation
import Buy

public class ClientQuery {
    
   private static let client = Graph.Client(shopDomain: "shoes.myshopify.com", apiKey:"dGhpcyBpcyBhIHByaXZhdGUgYXBpIGtleQ", locale:Locale.current)
        
    public static func getShopDetails() {
        let query = Queries.shopQuery()
        
        client.queryGraphWith(query) { query, error in
            
        }.resume()
    }
    
    public static func getCollections(withLimit limit: Int) {
        let query = Queries.queryForCollections(withLimit: 20)
        
        client.queryGraphWith(query) { query, error in
//            let response = query?.collections.edges ?? []
//            let collections = response.map({ Collection(modelType: $0.node) })
        }.resume()
    }
    
    
}

public struct Collection {
    
    let id  : String
    let name: String
    let model: Storefront.Collection
    
    init(modelType: Storefront.Collection) {
        id      = modelType.id.rawValue
        name    = modelType.title
        model   = modelType
    }
}
