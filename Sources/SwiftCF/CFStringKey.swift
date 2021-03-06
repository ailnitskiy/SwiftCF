import Foundation
import CoreFoundation

public protocol CFStringKey: RawRepresentable, ReferenceConvertible, ExpressibleByStringLiteral, _CoreFoundationBridgeable where RawValue == CFString, ReferenceType == NSString, BridgedCFType == CFString {
    init(_ key: CFString)
}

public extension CFStringKey {
    
    init(rawValue: CFString) {
        self.init(rawValue)
    }
    
    init(stringLiteral value: String) {
        self.init(value._bridgeToCoreFoundation())
    }
    
    var description: String {
        return String._bridgeFromCoreFoundation(rawValue)
    }
    
    var debugDescription: String {
        return description
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue.cfEqual(to: rhs.rawValue)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue.cfHash)
    }
    
    func _bridgeToObjectiveC() -> NSString {
        return rawValue._bridgeToNS()
    }
    
    static func _forceBridgeFromObjectiveC(_ source: NSString, result: inout Self?) {
        result = Self(CFString._bridgeFromNS(source))
    }
    
    static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Self?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Self {
        var result: Self?
        _forceBridgeFromObjectiveC(source!, result: &result)
        return result!
    }
    
    func _bridgeToCoreFoundation() -> CFString {
        return rawValue
    }
    
    static func _bridgeFromCoreFoundation(_ source: CFString) -> Self {
        return self.init(source)
    }
}
