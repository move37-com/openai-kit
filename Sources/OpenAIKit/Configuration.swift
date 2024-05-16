import NIOHTTP1

public struct Configuration {
    public let apiKey: String
    public let organization: String?
    public let api: API?
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        if let customHeaders = api?.requestHeaders {
            customHeaders.forEach {
                headers.add(name: $0, value: $1)
            }
        }
        headers.add(name: "Authorization", value: "Bearer \(apiKey)")

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
