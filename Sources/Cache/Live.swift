import Foundation

extension Cache {

  /// Returns a live implementation of `Cache` that uses a `NSCache` internally.
  public static func live() -> Cache {
    let nsCache = NSCache<NSString, WrappedEntry>()

    return Cache(
      setValue: { value, key, lifetime in
        let expirationDate = lifetime.map { Date().addingTimeInterval($0) }
        nsCache.setObject(
          WrappedEntry(value, expirationDate: expirationDate), forKey: key as NSString)
      },
      value: { key in
        guard let entry = nsCache.object(forKey: key as NSString) else {
          return nil
        }

        if let expirationDate = entry.expirationDate, Date() > expirationDate {
          nsCache.removeObject(forKey: key as NSString)
          return nil
        }

        return entry.value
      },
      remove: { key in
        nsCache.removeObject(forKey: key as NSString)
      }
    )
  }
}

private final class WrappedEntry: NSObject {
  var value: Any
  var expirationDate: Date?

  init(_ value: Any, expirationDate: Date?) {
    self.value = value
    self.expirationDate = expirationDate
  }
}
