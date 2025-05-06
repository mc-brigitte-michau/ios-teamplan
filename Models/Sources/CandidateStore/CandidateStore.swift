import Foundation
import Networking

@MainActor
public protocol CandidateStoreProtocol: AnyObject, ObservableObject {
    var candidates: [Candidate] { get set }
    func fetchCandidates() async throws
}

public class CandidateStore: CandidateStoreProtocol {

    @Published public var candidates: [Candidate] = []
    private let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func fetchCandidates() async throws {
        candidates = []
    }
}

extension CandidateStore {

    public static var preview: CandidateStore {
        let store = CandidateStore(httpClient: DummyHTTPClient())
        store.candidates = [
            Candidate(name: "Alice"),
            Candidate(name: "Bob"),
            Candidate(name: "Charlie")
        ]
        return store
    }

    public static var previewEmpty: CandidateStore {
        let store = CandidateStore(httpClient: DummyHTTPClient())
           store.candidates = []
           return store
    }

    struct DummyHTTPClient: HTTPClient {}
}
