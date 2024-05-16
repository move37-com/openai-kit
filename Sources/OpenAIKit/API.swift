import Foundation

public struct API {
    public let scheme: Scheme
    public let host: String
    public let path: String?
    public let anthropic: Bool
    
    public init(
        scheme: API.Scheme,
        host: String,
        path: String? = nil,
        anthropicCompatible: Bool = false
    ) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.anthropic = anthropicCompatible
    }
}

extension API {
    public enum Scheme {
        case http
        case https
        case custom(String)
        
        var value: String {
            switch self {
            case .http:
                return "http"
            case .https:
                return "https"
            case .custom(let scheme):
                return scheme
            }
        }
    }
}
