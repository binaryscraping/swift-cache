import Foundation

extension Cache {
  /// Returns a live implementation of `Cache` that uses a `NSCache` internally.
  public static func live() -> Cache {
    let nsCache = NSCache<NSString, WrappedEntry>()

    return Cache(
      setEntry: { entry, key in nsCache.setObject(WrappedEntry(entry), forKey: key as NSString) },
      entry: { key in nsCache.object(forKey: key as NSString)?.entry },
      remove: { key in nsCache.removeObject(forKey: key as NSString) }
    )
  }
}

private final class WrappedEntry: NSObject {
  var entry: Cache.Entry

  init(_ entry: Cache.Entry) {
    self.entry = entry
  }
}
