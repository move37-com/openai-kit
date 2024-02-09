public struct EmbeddingProvider {
    
    private let requestHandler: RequestHandler
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
    }

    /**
     Create embeddings
     POST

     https://api.openai.com/v1/embeddings

     Creates an embedding vector representing the input text.
     */
    public func create(
        model: ModelID = Model.GPT3.textEmbedding3Small,
        dimensions: Int = 512,
        input: [String],
        user: String? = nil
    ) async throws -> CreateEmbeddingResponse {

        let request = try CreateEmbeddingRequest(
            model: model.id,
            dimensions: dimensions,
            input: input,
            user: user
        )

        return try await requestHandler.perform(request: request)
    }


    /**
     Create embeddings
     POST

     https://api.openai.com/v1/embeddings

     Creates an embedding vector representing the input text.
     */
    public func create(
        model: ModelID = Model.GPT3.textEmbedding3Small,
        dimensions: Int = 512,
        input: String,
        user: String? = nil
    ) async throws -> CreateEmbeddingResponse {
        try await create(model: model, dimensions: dimensions, input: [input], user: user)
    }
}
