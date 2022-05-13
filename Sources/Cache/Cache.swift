import Foundation

public struct Cache {
  public struct Key<Value>: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }

    public init(_ rawValue: String) {
      self.init(rawValue: rawValue)
    }
  }

  public struct Entry {
    let value: Any
    let expirationDate: Date?

    public init<Value>(value: Value, for key: Key<Value>, expirationDate: Date?) {
      self.value = value
      self.expirationDate = expirationDate
    }
  }

  /// The lifetime of the object in the Cache, represented in seconds.
  public typealias Lifetime = TimeInterval

  var setEntry: (_ entry: Entry, _ key: String) -> Void
  var entry: (_ key: String) -> Entry?
  var remove: (_ key: String) -> Void

  public init(
    setEntry: @escaping (_ entry: Entry, _ key: String) -> Void,
    entry: @escaping (_ key: String) -> Entry?,
    remove: @escaping (_ key: String) -> Void
  ) {
    self.setEntry = setEntry
    self.entry = entry
    self.remove = remove
  }

  public func set<Value>(_ value: Value, at key: Key<Value>, lifetime: Lifetime? = nil) {
    self.setEntry(
      Entry(
        value: value,
        for: key,
        expirationDate: lifetime.map { Date().addingTimeInterval($0) }
      ),
      key.rawValue
    )
  }

  public func value<Value>(at key: Key<Value>) -> Value? {
    guard let entry = self.entry(key.rawValue) else {
      return nil
    }

    guard let value = entry.value as? Value else {
      preconditionFailure(
        "Expected value of type '\(Value.self)' for the key '\(key.rawValue)' in cache but found '\(type(of: entry.value))' instead."
      )
    }

    if let expirationDate = entry.expirationDate, Date() > expirationDate {
      remove(at: key)
      return nil
    }

    return value
  }

  public func remove<Value>(at key: Key<Value>) {
    self.remove(key.rawValue)
  }
}
