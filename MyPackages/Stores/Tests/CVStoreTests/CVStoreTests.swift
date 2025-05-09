import Testing
import Models
import Services
@testable import CVStore

@Suite
struct CVStoreTests {

    @Test
    @MainActor
    func testFetchResumesPopulatesCandidates() async throws {
        // Given
        var mockService = MockCVService()
        mockService.candidatesToReturn = [
            .mock
        ]
        let store = CVStore(service: mockService)

        // When
        try await store.fetchResumes()

        // Then
        #expect(store.candidates.count == 1)
        #expect(store.candidates.first?.fullName == Candidate.mock.fullName)
        #expect(store.candidates.first?.searchIndex == "barabar cave swift swiftui")
    }
}
