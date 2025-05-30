import Testing
import Models
import Services
@testable import CVStore

@Suite
struct CVStoreTests {

    @Test
    @MainActor
    func fetchResumesPopulatesCandidates() async throws {
        // Given
        var mockService = MockCVService()
        mockService.candidatesToReturn = [ .mock ]
        let store = CVStore(service: mockService)

        // When
        try await store.fetchResumes()

        // Then
        #expect(store.candidates.count == 1)
        #expect(store.candidates.first?.fullName == Candidate.mock.fullName)
        #expect(store.candidates.first?.searchIndex == "barabar cave swift swiftui")
    }

    @Test
    @MainActor
    func fetchCVsFailure() async {
        // Given
        var mockService = MockCVService()
        mockService.fetchCVsError = .decodingError
        let store = CVStore(service: mockService)

        // When
        do {
            try await store.fetchResumes()
        } catch {
            // Then
            #expect((error as? HTTPClientError) == .decodingError)
        }
    }

    @Test
    @MainActor
    func fetchResumeWithIdPopulatesCandidate() async throws {

        // Given
        var mockService = MockCVService()
        mockService.candidateToReturn = .mock
        let store = CVStore(service: mockService)

        // When
        try await store.fetchResume(for: "barabar.cave@mooncascade.com")

        // Then
        #expect(store.currentCandidate?.fullName == Candidate.mock.fullName)
        #expect(store.currentCandidate?.resumes?.count == 1)
    }

    @Test
    @MainActor
    func fetchResumeByIdFailure() async {
        // Given
        var mockService = MockCVService()
        mockService.fetchVCError = .timedOut
        let store = CVStore(service: mockService)

        // When
        do {
            _ = try await store.fetchResume(for: "barabar.cave@mooncascade.com")
        } catch {
            // Then
            #expect((error as? HTTPClientError) == .timedOut)
        }
    }

    @Test
    @MainActor
    func createResumeSuccess() async throws {
        // Given
        var mockService = MockCVService()
        let createResume: CreateResume = .mock
        let createdCandidate = Candidate(from: createResume)
        mockService.createdCandidate = createdCandidate
        let store = CVStore(service: mockService)

        // When
        try await store.createResume(resume: createResume)

        // Then
        #expect(store.currentCandidate?.fullName == createResume.fullName)
    }

    @Test
    @MainActor
    func createResumeFailure() async {
        // Given
        var mockService = MockCVService()
        let clientError: HTTPClientError = .serverError(statusCode: 500, body: "Internal Server Error")
        mockService.createError = clientError
        let store = CVStore(service: mockService)

        // When
        do {
            try await store.createResume(resume: .mock)
        } catch {
            // Then
            #expect((error as? HTTPClientError) == clientError)
        }
    }

    @Test
    @MainActor
    func updateResumeSuccess() async throws {
        // Given
        var mockService = MockCVService()
        mockService.updatedCandidate = .mock
        let store = CVStore(service: mockService)

        // When
        try await store.updateResume(resume: .mock)

        // Then
        #expect(store.currentCandidate?.fullName == Candidate.mock.fullName)
    }

    @Test
    @MainActor
    func updateResumeFailure() async {
        // Given
        var mockService = MockCVService()
        mockService.updateError = .invalidResponse
        let store = CVStore(service: mockService)

        // When
        do {
            _ = try await store.updateResume(resume: .mock)
        } catch {
            // Then
            #expect((error as? HTTPClientError) == .invalidResponse)
        }
    }

    @Test
    @MainActor
    func deleteResumeSuccess() async throws {
        // Given
        let id = "barabar.cave@mooncascade.com"
        var mockService = MockCVService()
        mockService.deleteID = id
        let store = CVStore(service: mockService)
        
        // When

        try await store.deleteResume(for: id)

        // Then
        #expect(mockService.deleteID == id)
    }

    @Test
    @MainActor
    func deleteResumeFailure() async {
        // Given
        var mockService = MockCVService()
        mockService.deleteError = .generalError
        let store = CVStore(service: mockService)

        // When
        do {
            _ = try await store.deleteResume(for: "missing")
        } catch {
            // Then
            #expect((error as? HTTPClientError) == .generalError)
        }
    }

}
