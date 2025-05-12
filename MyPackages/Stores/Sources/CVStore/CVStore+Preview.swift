import Services
import Models

extension CVStore {

    private static var mockCVService: MockCVService {
        var service = MockCVService()
        service.candidatesToReturn = [.mock]
        return service
    }

    public static var preview: CVStore {
        let store = CVStore(service: mockCVService)
        store.candidates = indexCandidates([.mock])
        store.myResume = .mock
        store.selected = nil
        return store
    }

    public static var previewEmpty: CVStore {
        let store = CVStore(service: MockCVService())
        store.candidates = []
        store.selected = nil
        store.myResume = nil
        return store
    }

    public static var previewSelected: CVStore {
        let store = CVStore(service: mockCVService)
        store.candidates = indexCandidates([.mock])
        store.myResume = .mock
        store.selected = .mock
        return store
    }

}
