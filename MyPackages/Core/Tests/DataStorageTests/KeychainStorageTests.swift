import Testing
import Foundation
@testable import DataStorage

@Suite
struct KeychainStorageTests {

    struct DummyUser: Codable, Equatable {
        let id: Int
        let name: String
    }

    @Test
    func saveAndRetrieveValue() throws {
        let storage = MockKeychainStorage()
        let user = DummyUser(id: 1, name: "Alice")

        try storage.save(value: user, for: .authUser)
        let retrieved: DummyUser? = try storage.retrieve(type: DummyUser.self, for: .authUser)

        #expect(retrieved == user)
    }

    @Test
    func retrieveNilValue() throws {
        let storage = MockKeychainStorage()

        let retrieved: DummyUser? = try storage.retrieve(type: DummyUser.self, for: .authUser)
        #expect(retrieved == nil)
    }

    @Test
    func clearAllData() throws {
        let storage = MockKeychainStorage()
        let user = DummyUser(id: 2, name: "Bob")

        try storage.save(value: user, for: .authUser)
        try storage.clearAll()
        let retrieved: DummyUser? = try storage.retrieve(type: DummyUser.self, for: .authUser)

        #expect(retrieved == nil)
    }

    @Test
    func storeRetrieveCookie() {
        let storage = MockKeychainStorage()

        let properties: [HTTPCookiePropertyKey: Any] = [
            .name: "session",
            .value: "abc123",
            .domain: "example.com",
            .path: "/",
            .version: 0
        ]

        guard let cookie = HTTPCookie(properties: properties) else {
            fatalError("Failed to create cookie")
        }

        storage.storeCookieToKeychain(cookie)
        let retrieved = storage.retrieveCookieFromKeychain(named: "session")

        #expect(retrieved?.value == "abc123")
        #expect(retrieved?.domain == "example.com")
    }
}
