//
//  NetworkClientFactory.swift
//
//
//  Created by Mакс T on 04.01.2024.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public final class NetworkNewsApi {
    
    private init() { }
    
    public static func makeNewsApiClient() -> APIProtocol {
        Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
    }
}
