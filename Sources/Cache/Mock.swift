extension Cache {
  /// A dummy implementation of `Cache` that does nothing when called, can be used on `SwiftUI Previews`.
  public static var noop: Cache {
    Cache(
      setEntry: { _, _ in },
      entry: { _ in nil },
      remove: { _ in }
    )
  }

  public func override(
    setEntry: ((_ entry: Entry, _ key: String) -> Void)? = nil,
    entry: ((_ key: String) -> Entry?)? = nil,
    remove: ((_ key: String) -> Void)? = nil
  ) -> Cache {
    var copy = self

    if let setEntry = setEntry {
      copy.setEntry = setEntry
    }

    if let entry = entry {
      copy.entry = entry
    }

    if let remove = remove {
      copy.remove = remove
    }

    return copy
  }
}

#if DEBUG
  import XCTestDynamicOverlay

  extension Cache {
    /// An implementation of `Cache` that fails with a `XCTFail` call in all paths, can be used on tests.
    public static var failing: Cache {
      Cache(
        setEntry: {
          XCTFail("Cache.setEntry(\($0), \($1)) is not implemented.")
        },
        entry: {
          XCTFail("Cache.entry(\($0)) is not implemented.")
          return nil
        },
        remove: {
          XCTFail("Cache.remove(\($0)) is not implemented.")
        }
      )
    }
  }
#endif
