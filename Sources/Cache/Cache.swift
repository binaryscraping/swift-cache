import Foundation

public struct CacheKey<Value>: RawRepresentable {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  public init(_ rawValue: String) {
    self.init(rawValue: rawValue)
  }
}

public struct Cache {

  /// The lifetime of the object in the Cache, represented in seconds.
  public typealias Lifetime = TimeInterval

  var setValue: (_ value: Any, _ key: String, _ lifetime: Lifetime?) -> Void
  var value: (_ key: String) -> Any?
  var remove: (_ key: String) -> Void

  public init(
    setValue: @escaping (_ value: Any, _ key: String, _ lifetime: Lifetime?) -> Void,
    value: @escaping (_ key: String) -> Any?,
    remove: @escaping (_ key: String) -> Void
  ) {
    self.setValue = setValue
    self.value = value
    self.remove = remove
  }

  public func set<Value>(_ value: Value, at key: CacheKey<Value>, lifetime: Lifetime? = nil) {
    self.setValue(value, key.rawValue, lifetime)
  }

  public func value<Value>(at key: CacheKey<Value>) -> Value? {
    guard let untypedValue = self.value(key.rawValue) else {
      return nil
    }

    guard let value = untypedValue as? Value else {
      preconditionFailure(
        "Expected value of type '\(Value.self)' for the key '\(key.rawValue)' in cache but found '\(type(of: untypedValue))' instead."
      )
    }

    return value
  }

  public func remove<Value>(at key: CacheKey<Value>) {
    self.remove(key.rawValue)
  }
}
