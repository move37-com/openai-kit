import AsyncHTTPClient
import NIOHTTP1
import Foundation

struct CreateEmbeddingRequest: Request {
    let method: HTTPMethod = .POST
    let path = "/v1/embeddings"
    let body: Data?
    
    init(
        model: String,
        dimensions: Int,
        input: [String],
        user: String?
    ) throws {
        
        let body = Body(
            model: model,
            dimensions: dimensions,
            input: input,
            user: user
        )
                
        self.body = try Self.encoder.encode(body)
    }
}

extension CreateEmbeddingRequest {
    struct Body: Encodable {
        let model: String
        let dimensions: Int
        let input: [String]
        let user: String?
    }
}
