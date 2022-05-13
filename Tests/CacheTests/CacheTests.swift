import XCTest

@testable import Cache

extension CacheKey where Value == Int {
  static let counter = CacheKey(rawValue: "counter")
}

final class CacheTests: XCTestCase {
  func testLiveCache() throws {
    let cache = Cache.live()

    cache.set(0, at: .counter)
    cache.set(1, at: .counter)

    XCTAssertEqual(cache.value(at: .counter), 1)

    cache.remove(at: .counter)
    XCTAssertNil(cache.value(at: .counter))
  }
}
