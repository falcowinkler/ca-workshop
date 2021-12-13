public protocol AnalyticsClientProtocol {
    func track(eventName: String, data: [String: String])
}

public struct NoopAnalyticsClient: AnalyticsClientProtocol {
    public init() {}
    public func track(eventName: String, data: [String: String]) {
    }
}
