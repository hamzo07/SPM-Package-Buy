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
    
    private var client              : Graph.Client!
    static let manager              = ClientQuery()
    private static var configDetails: (apiKey: String, shopDomain: String)?
    fileprivate var logger  = Logger(subsystem: "com.nxl.app", category: "ClientQuery")
    
    
    private init() {
        guard let _ = ClientQuery.configDetails else { fatalError("ApiKey and shop domain not provided before accessing ClientQuery functions") }
        client      = .init(shopDomain: ClientQuery.configDetails!.shopDomain, apiKey: ClientQuery.configDetails!.apiKey)
    }
    
    
    /// This function is used to initalise Graph.Client object for queries and mutation of BUY sdk
    /// - Parameter configuration: This tuple accept first parameter for apikey and second for shopDomain
    static func configureWith(_ configuration: (apiKey: String, shopDomain: String)) {
        configDetails = configuration
    }
    
    
    func queryForShopName() {
        let query = Queries.shopQuery()
        client.queryGraphWith(query) { response, error in
            let name = response?.shop.name ?? ""
            self.logger.debug("\(name)")
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
