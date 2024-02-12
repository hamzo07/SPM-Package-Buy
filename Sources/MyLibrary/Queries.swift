//
//  File.swift
//
//
//  Created by Hamza Usmani on 12/02/24.
//

import Buy

public class Queries {
    
    private init() {}
    
    public static func shopQuery() -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
            .shop { $0
                .name()
            }
        }
    }
    
    public static func queryForCollections(withLimit limit: Int32) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
            .collections(first: limit) { $0
                .edges { $0
                    .node { $0
                        .id()
                        .title()
                        .image { $0
                            .id()
                            .url()
                            .height()
                            .width()
                        }
                    }
                }
            }
        }
    }
    
    
    
    
}
