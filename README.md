# swift-cache

A type-safe swifty wrapper around [`NSCache`](https://developer.apple.com/documentation/foundation/nscache).


## Getting Started

Add `swift-cache` as a dependency to your project using SPM.

```swift
.package(url: "https://github.com/binaryscraping/swift-cache", from: "0.1.0"),
```

And in your application/target, add `"Cache"` to your `"dependencies"`.

```swift
.target(
  name: "YourTarget",
  dependencies: [
    .product(name: "Cache", package: "swift-cache"),
  ]
)
```

## Usage

`Cache` is accessed through a `CacheKey` type, so start by defining your keys.

```swift
extension CacheKey where Value == String {
  // A key that stores a string value.
  static let myKey = CacheKey("my_key")
}

```

Instantiate a live implementation of the cache type.

```swift
let cache = Cache.live()
```

### Insert

```swift
cache.set("string value", at: .myKey)
```

You can provide an optional lifetime in seconds for the entry.

```swift
cache.set("string value", at: .myKey, lifetime: 60)
```

### Retrieve

```swift
let value = cache.retrieve(at: .myKey)
```

### Remove
```swift
cache.remove(at: .myKey)
```
