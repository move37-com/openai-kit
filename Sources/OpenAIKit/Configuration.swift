import NIOHTTP1

public struct Configuration {
    public let apiKey: String
    public let organization: String?
    public let api: API?
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        if api?.anthropic == true {
            // Anthropic API requires different headers
            headers.add(name: "x-api-key", value: apiKey)
            headers.add(name: "anthropic-version", value: "2023-06-01")
        } else {
            headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        }

        if let organization = organization {
            headers.add(name: "OpenAI-Organization", value: organization)
        }
        
        return headers
    }
    
    public init(
        apiKey: String,
        organization: String? = nil,
        api: API? = nil
    ) {
        self.apiKey = apiKey
        self.organization = organization
        self.api = api
    }
    
}


extension Configuration: Equatable {
    
    public static func == (lhs: Configuration, rhs: Configuration) -> Bool {
        lhs.apiKey == rhs.apiKey &&
        lhs.organization == rhs.organization &&
        lhs.api == rhs.api
    }
    
}
