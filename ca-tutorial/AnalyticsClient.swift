protocol AnalyticsClientProtocol {
    func track(eventName: String, data: [String: String])
}

struct AnalyticsClient: AnalyticsClientProtocol {
    private let firebaseAnalyticsWrapper: FirebaseAnalyticsProtocol

    init(firebaseAnalyticsWrapper: FirebaseAnalyticsProtocol) {
        self.firebaseAnalyticsWrapper = firebaseAnalyticsWrapper
    }

    func track(eventName: String, data: [String : String]) {
        firebaseAnalyticsWrapper.track(eventName: eventName, data: data)
    }
}
