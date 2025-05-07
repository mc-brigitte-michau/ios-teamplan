import Foundation
import Networking

@MainActor
public protocol CVStoreProtocol: AnyObject, ObservableObject {
    var cvList: [CV] { get set }
    var selected: CV? { get set }
    func fetchCVs() async throws
}

public class CVStore: CVStoreProtocol {

    @Published public var cvList: [CV] = []
    @Published public var selected: CV? = nil

    private let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func fetchCVs() async throws {
        cvList = [
            CV(name: "A"),
            CV(name: "B"),
            CV(name: "C")
        ]
        selected = nil
    }
}

extension CVStore {

    public static var preview: CVStore {
        let store = CVStore(httpClient: DummyHTTPClient())
        store.cvList = [
            CV(name: "A"),
            CV(name: "B"),
            CV(name: "C")
        ]
        store.selected = nil
        return store
    }

    public static var previewEmpty: CVStore {
        let store = CVStore(httpClient: DummyHTTPClient())
        store.cvList = []
        store.selected = nil
        return store
    }
}
