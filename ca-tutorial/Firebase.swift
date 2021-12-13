/*
 For the course of this tutorial, we assume this is some kind of big 3rd party tracking
 Framework dependency with a long compile time
 */
struct FirebaseAnalytics {
    func track(eventName: String, data: [String: String]) {
        print(eventName, data.debugDescription)
    }
}

/* uncomment for a ~1min compiler bomb
 public let __tmp0 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp1 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp2 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp3 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp4 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp5 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp6 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp7 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp8 = 2 * 2 * 2 * 2.0 / 2 + 2
 public let __tmp9 = 2 * 2 * 2 * 2.0 / 2 + 2
 */

protocol FirebaseAnalyticsProtocol {
    func track(eventName: String, data: [String: String])
}

// Wrap the 3rd party dependency in a protocol, so that we can test our analytics client
extension FirebaseAnalytics: FirebaseAnalyticsProtocol {}
