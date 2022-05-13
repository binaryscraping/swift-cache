# swift-cache
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbinaryscraping%2Fswift-cache%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/binaryscraping/swift-cache)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbinaryscraping%2Fswift-cache%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/binaryscraping/swift-cache)

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

### Usage in tests

This library provides some helpers for easy usage on tests such as:

#### Noop

An implementation of `Cache` that does nothing when called.

```swift
let cache = Cache.noop
```


#### Failing

An implementation of `Cache` that fails with an `XCTFail` call.

```swift
var setEntryCalled = false

let cache = Cache.failing
  .override(
    setEntry: { entry, key in 
      setEntryCalled = true
    }
  )
  
cache.set("string value", at: .myKey)
  
XCTAssertTrue(setEntryCalled)
```

At the code snipped above all calls to a method that wasn't overriden will terminate with a `XCTFail`.
