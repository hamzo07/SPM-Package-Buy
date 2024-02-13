//
//  File.swift
//  
//
//  Created by Hamza Usmani on 12/02/24.
//

import Foundation
import Buy
import OSLog

public final class ClientQuery {
    
    private var client                  : Graph.Client!
    private static var configDetails    : (apiKey: String, shopDomain: String)?
    
    public static let manager           = ClientQuery()
    fileprivate var logger              = Logger(subsystem: "com.nxl.app", category: "ClientQuery")
    
    
    private init() {
        guard let _ = ClientQuery.configDetails else { fatalError("Api key and shop domain not provided before using client query functionality") }
        client      = .init(shopDomain: ClientQuery.configDetails!.shopDomain, apiKey: ClientQuery.configDetails!.apiKey)
    }
    
    
    /// This function is used to initalise Graph.Client object for queries and mutation of BUY sdk
    /// - Parameter configuration: This tuple accept first parameter for apikey and second for shopDomain
    static public func configureWith(_ configuration: (apiKey: String, shopDomain: String)) {
        configDetails = configuration
    }
    
    
    /// This query function gets the Shop details
    /// - Returns: return the name of the shop
    public func queryForShopName() async -> String {
        let query = Queries.shopQuery()
        return await withCheckedContinuation { continuation in
            client.queryGraphWith(query) { response, error in
                let name = response?.shop.name ?? ""
                self.logger.debug("\(name)")
                continuation.resume(returning: name)
            }.resume()
        }
    }
    
    /// This method get all the collection available on the shopify store
    /// - Parameter limit: You can specify the number of collection you want to access from the shopify store
    /// - Returns: return an array of collections fetched from the store
    public func getCollections(withLimit limit: Int32) async -> [Collection] {
        let query = Queries.queryForCollections(withLimit: limit)
        return await withCheckedContinuation { continuation in
            client.queryGraphWith(query) { response, error in
                let collections = response?.collections.edges.map { Collection(modelType: $0.node) }
                self.logger.debug("Collection \(collections?.count ?? 0, align: .right(columns: 5))")
                continuation.resume(returning: collections ?? [])
            }.resume()
        }
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
