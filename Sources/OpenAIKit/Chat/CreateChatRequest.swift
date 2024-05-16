import AsyncHTTPClient
import NIOHTTP1
import Foundation

struct CreateChatRequest: Request {
    let method: HTTPMethod = .POST
    let body: Data?
    let pathOverride: String?
    var path: String {
        pathOverride ?? "/v1/chat/completions"
    }
    
    init(
        path: String? = nil,
        model: String,
        messages: [Chat.Message],
        responseFormat: ResponseFormat = .text,
        temperature: Double,
        topP: Double,
        n: Int,
        stream: Bool,
        stops: [String],
        maxTokens: Int?,
        presencePenalty: Double,
        frequencyPenalty: Double,
        logitBias: [String: Int],
        user: String?,
        anthropic: Bool
    ) throws {
        // For Anthropic compatibility: top-level system prompt instead of "system" message
        var messages = messages
        var system: String?
        if anthropic {
            let sysMessages = messages.filter { m in
                if case .system(_) = m { return true }
                return false
            }
            system = sysMessages.map(\.content).joined(separator: "\n")
            messages = messages.filter { m in
                if case .system(_) = m { return false }
                return true
            }
        }
        
        let body = Body(
            model: model,
            messages: messages,
            responseFormat: responseFormat,
            temperature: temperature,
            topP: topP,
            n: n,
            stream: stream,
            stops: stops,
            maxTokens: maxTokens,
            presencePenalty: presencePenalty,
            frequencyPenalty: frequencyPenalty,
            logitBias: logitBias,
            user: user,
            system: system
        )
                
        self.body = try Self.encoder.encode(body)
        self.pathOverride = path
    }
}

extension CreateChatRequest {
    struct Body: Encodable {
        let model: String
        let messages: [Chat.Message]
        let responseFormat: ResponseFormat
        let temperature: Double
        let topP: Double
        let n: Int
        let stream: Bool
        let stops: [String]
        let maxTokens: Int?
        let presencePenalty: Double
        let frequencyPenalty: Double
        let logitBias: [String: Int]
        let user: String?
        let system: String? // For Anthropic compatibility: top-level system prompt instead of message
            
        enum CodingKeys: CodingKey {
            case model
            case messages
            case responseFormat
            case temperature
            case topP
            case n
            case stream
            case stop
            case maxTokens
            case presencePenalty
            case frequencyPenalty
            case logitBias
            case user
            case system
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(model, forKey: .model)
            
            if !messages.isEmpty {
                try container.encode(messages, forKey: .messages)
            }

            try container.encode(responseFormat, forKey: .responseFormat)
            try container.encode(temperature, forKey: .temperature)
            try container.encode(topP, forKey: .topP)
            try container.encode(n, forKey: .n)
            try container.encode(stream, forKey: .stream)
            
            if !stops.isEmpty {
                try container.encode(stops, forKey: .stop)
            }
            
            if let maxTokens {
                try container.encode(maxTokens, forKey: .maxTokens)
            }
            
            try container.encode(presencePenalty, forKey: .presencePenalty)
            try container.encode(frequencyPenalty, forKey: .frequencyPenalty)
            
            if !logitBias.isEmpty {
                try container.encode(logitBias, forKey: .logitBias)
            }
            
            try container.encodeIfPresent(user, forKey: .user)
            
            if let system {
                try container.encode(system, forKey: .system)
            }
        }
    }
}
