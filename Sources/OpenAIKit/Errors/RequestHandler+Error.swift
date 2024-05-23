enum RequestHandlerError: Error {
    case invalidURLGenerated
    case responseBodyMissing
    case unknown(String)
}
