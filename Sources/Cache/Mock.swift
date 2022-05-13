#if DEBUG
  extension Cache {
    public func override(
      setValue: ((_ value: Any, _ key: String, _ lifetime: Lifetime?) -> Void)? = nil,
      value: ((_ key: String) -> Any?)? = nil,
      remove: ((_ key: String) -> Void)? = nil
    ) -> Cache {
      var copy = self
      if let setValue = setValue {
        copy.setValue = setValue
      }

      if let value = value {
        copy.value = value
      }

      if let remove = remove {
        copy.remove = remove
      }

      return copy
    }
  }
#endif
