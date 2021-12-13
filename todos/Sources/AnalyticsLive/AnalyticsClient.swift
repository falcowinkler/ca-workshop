import Analytics

public struct AnalyticsClient: AnalyticsClientProtocol {
    private let firebaseAnalyticsWrapper: FirebaseAnalyticsProtocol

    public init(firebaseAnalyticsWrapper: FirebaseAnalyticsProtocol) {
        self.firebaseAnalyticsWrapper = firebaseAnalyticsWrapper
    }

    public func track(eventName: String, data: [String : String]) {
        firebaseAnalyticsWrapper.track(eventName: eventName, data: data)
    }
}
