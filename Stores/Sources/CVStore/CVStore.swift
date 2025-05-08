import Foundation
import Networking
import Models

@MainActor
public protocol CVStoreProtocol: AnyObject, ObservableObject {
    var cvList: [Resume] { get set }
    var selected: Resume? { get set }
    func fetchCVs() async throws
    func fetchVC(id: String) async throws -> Resume?
    func create(resume: Resume) async throws -> Resume?
    func update(resume: Resume) async throws -> Resume?
    func delete(id: String) async throws
    func getImage(id: String) async throws -> URL?
}

public class CVStore: CVStoreProtocol {

    @Published public var cvList: [Resume] = []
    @Published public var selected: Resume? = nil

    private let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func fetchCVs() async throws {
        cvList = [
            .mock
        ]
        selected = nil
    }

    public func fetchVC(id: String) async throws -> Resume? {
        fatalError("not implemented")
    }

    public func create(resume: Resume) async throws -> Resume? {
        fatalError("not implemented")
    }

    public func update(resume: Resume) async throws -> Resume? {
        fatalError("not implemented")
    }

    public func delete(id: String) async throws {
        fatalError("not implemented")
    }

    public func getImage(id: String) async throws -> URL? {
        fatalError("not implemented")
    }
}

extension CVStore {

    public static var preview: CVStore {
        let store = CVStore(httpClient: DummyHTTPClient())
        store.cvList = [
            .mock
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
