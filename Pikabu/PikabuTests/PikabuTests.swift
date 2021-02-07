import XCTest
@testable import Pikabu

class PikabuTests: XCTestCase {
    
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }
    
    func testAPI() throws {
        API.get(to: URLS.feed) { (result: Result<[Feed]?,Error>) in
            do {
                let feed = try result.get()
                XCTAssertNotNil(feed, "FEED NIL")
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testPerformanceExample() throws {
        self.measure { }
    }
}
