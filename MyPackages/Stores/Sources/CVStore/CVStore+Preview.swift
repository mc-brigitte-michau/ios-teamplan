import Models
import Services
import SharedStore

extension CVStore {
    private static var mockCVService: MockCVService {
        var service = MockCVService()
        service.candidatesToReturn = [.mock]
        return service
    }

    public static var preview: CVStore {
        let store = CVStore(service: mockCVService)
        store.listLoadState = .loaded
        store.candidates = indexCandidates([.mock])
        store.myResume = .mock
        store.currentResume = nil
        return store
    }

    public static var previewEmpty: CVStore {
        let store = CVStore(service: MockCVService())
        store.listLoadState = .empty
        store.candidates = []
        store.currentResume = nil
        store.myResume = nil
        return store
    }

    public static var previewFailure: CVStore {
        let store = CVStore(service: MockCVService())
        store.listLoadState = .failed("Failed to load candidates")
        return store
    }

    public static var previewSelected: CVStore {
        let store = CVStore(service: MockCVService())
        store.candidates = indexCandidates([.mock])
        store.myResume = .mock
        store.currentResume = .mock
        return store
    }
}
