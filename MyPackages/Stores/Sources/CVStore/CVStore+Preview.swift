import Services
import Models

extension CVStore {
    public static var preview: CVStore {
        let store = CVStore(service: DummyCVService())
        store.candidates = indexCandidates([.mock])
        store.myResume = .mock
        store.selected = nil
        return store
    }

    public static var previewEmpty: CVStore {
        let store = CVStore(service: DummyCVService())
        store.candidates = []
        store.selected = nil
        store.myResume = nil
        return store
    }

    public static var previewSelected: CVStore {
        let store = CVStore(service: DummyCVService())
        store.candidates = indexCandidates([.mock])
        store.myResume = .mock
        store.selected = .mock
        return store
    }

}
