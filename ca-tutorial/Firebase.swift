/*
 For the course of this tutorial, we assume this is some kind of big 3rd party tracking
 Framework dependency with a long compile time
 */
struct FirebaseAnalytics {
    func track(eventName: String, data: [String: String]) {
        print(eventName, data.debugDescription)
    }
}

protocol FirebaseAnalyticsProtocol {
    func track(eventName: String, data: [String: String])
}

// Wrap the 3rd party dependency in a protocol, so that we can test our analytics client
extension FirebaseAnalytics: FirebaseAnalyticsProtocol {}

// Compiler bomb:
/*
import Darwin
public func a1(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func a2(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func a3(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func a4(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func a5(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func a6(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func a7(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func a8(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func a9(x: Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b1(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b2(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b3(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b4(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b5(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b6(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b7(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b8(x:Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
public func b9(x: Double) -> Double {
    return 1 - abs(x * 6 - floor(x * 3) * 2 - 1)
}
*/
