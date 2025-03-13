//
//  Network.swift
//  LodgeLink
//
//  Created by Jim Niemann on 3/4/22.
//

import Foundation
import Network
import Apollo
import DomainLayer

enum NetworkError: LocalizedError {
    case clientSetupError
    
    var errorDescription: String? {
        switch self {
        case .clientSetupError:
            return NSLocalizedString("errorMessage.clientSetupError", comment: "")
        }
    }
}

enum LodgeLinkHeader: String {
    case authorization = "Authorization"
    case platformType = "platform-type"
    case platformLocale = "platform-locale"
}

class Network {
    private let getAuthenticationToken: () -> AuthenticationToken?
    private let infoDictionary: [String: Any]?
    private(set) lazy var client: ApolloClient? = getApolloClient()
    private(set) lazy var store: ApolloStore = ApolloStore(cache: InMemoryNormalizedCache())
    
    init(
        infoDictionary: [String: Any]?,
        getAuthenticationToken: @escaping () -> AuthenticationToken?
    ) {
        self.infoDictionary = infoDictionary
        self.getAuthenticationToken = getAuthenticationToken
    }
    
    func resetStore() {
        store = ApolloStore(cache: InMemoryNormalizedCache())
    }
    
    func getApolloClient(
        configuration: URLSessionConfiguration = .default
    ) -> ApolloClient? {
        
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120

        if let authToken = getAuthenticationToken()?.value {
            let authPayloads = [
                LodgeLinkHeader.authorization.rawValue: "Bearer \(authToken)",
                LodgeLinkHeader.platformType.rawValue: "Ios",
                LodgeLinkHeader.platformLocale.rawValue: Locale.current.identifier
            ]
            
            configuration.httpAdditionalHeaders = authPayloads
        }
        
        let sessionClient = URLSessionClient(
            sessionConfiguration: configuration,
            callbackQueue: nil
        )
        let provider = NetworkInterceptorProvider(
            client: sessionClient,
            shouldInvalidateClientOnDeinit: true,
            store: store,
            getAuthenticationToken: getAuthenticationToken
        )
        
        guard let infoDictionary,
              let baseUrlString = infoDictionary["API Base Url"] as? String,
              let baseUrl = URL(string: baseUrlString)
        else {
            return nil
        }
        
        let requestChainTransport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: baseUrl
        )
        
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
    }
}

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    let getAuthenticationToken: () -> AuthenticationToken?
    
    init(
        client: URLSessionClient,
        shouldInvalidateClientOnDeinit: Bool,
        store: ApolloStore,
        getAuthenticationToken: @escaping () -> AuthenticationToken?
    ) {
        self.getAuthenticationToken = getAuthenticationToken
        
        super.init(
            client: client,
            shouldInvalidateClientOnDeinit: shouldInvalidateClientOnDeinit,
            store: store
        )
    }
    
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        let interceptor = CustomInterceptor(getAuthenticationToken: getAuthenticationToken)
        
        interceptors.insert(interceptor, at: 0)
        
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    let getAuthenticationToken: () -> AuthenticationToken?
    
    init(
        getAuthenticationToken: @escaping () -> AuthenticationToken?
    ) {
        self.getAuthenticationToken = getAuthenticationToken
    }
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            if let authToken = getAuthenticationToken()?.value {
                request.addHeader(name: LodgeLinkHeader.authorization.rawValue, value: "Bearer \(authToken)")
                request.addHeader(name: LodgeLinkHeader.platformType.rawValue, value: "Ios")
                request.addHeader(name: LodgeLinkHeader.platformLocale.rawValue, value: Locale.current.identifier)
            }
            
            let startTime = DispatchTime.now().uptimeNanoseconds
            
            chain.proceedAsync(request: request, response: response) { result in
                if let urlRequest = try? request.toURLRequest(),
                   let bodyData = urlRequest.httpBody,
                   let object = try? JSONSerialization.jsonObject(with: bodyData, options: .fragmentsAllowed),
                   let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) ,
                   let string = NSString(data: prettyPrintedData, encoding: String.Encoding.utf8.rawValue) {
                    
                    var urlString, headersJSONString: String?
                    let requestJSONString: String = string as String
                    
                    if let url = urlRequest.url {
                        urlString = url.absoluteString
                    }
                    
                    if let headers = urlRequest.allHTTPHeaderFields,
                       let jsonData = try? JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted),
                       let headersJSON = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                        
                        headersJSONString = headersJSON as String
                    }
                    
                    let requestJSON = [urlString, headersJSONString, requestJSONString]
                        .compactMap { $0 }
                        .joined(separator: "\n")
                    
                    Debug.log(.request(requestJSON))
                }
                
                switch result {
                case .success(let success):
                    guard let object = success.data?.jsonObject,
                          let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
                          let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    else { break }
                    
                    let elapsedTime = DispatchTime.now().uptimeNanoseconds - startTime
                    
                    Debug.log(.response("Response time: \(TimeInterval(elapsedTime) / 1e9) seconds"))
                    Debug.log(.response(string as String))
                    
                case .failure(let failure):
                    Debug.log(.error(failure))
                }
                
                completion(result)
            }
        }
}
