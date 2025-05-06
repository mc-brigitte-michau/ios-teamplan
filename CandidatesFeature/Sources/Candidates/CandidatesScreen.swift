import SwiftUI
import CandidateStore
import Presentation

public struct CandidatesScreen: View {

    @EnvironmentObject private var store: CandidateStore
    @State private var loadState: LoadState

    public var body: some View {
        VStack {
            Text(String(localized: "title", bundle: .module))

            switch loadState {
            case .idle, .loading:
                LoadingView(text: "Loading Candidates...")
                    .task {
                        await loadCandidates()
                    }

            case .loaded:
                if store.candidates.isEmpty {
                    Text("No candidates found.")
                } else {
                    List(store.candidates) { candidate in
                        Text(candidate.name)
                    }
                }

            case .empty:
                Text("No candidates found.")

            case .failed(let error):
                Text("Failed to load candidates: \(error)")
            }
        }
    }

    public init(loadState: LoadState = .idle) {
        self._loadState = State(initialValue: loadState)
    }

    private func loadCandidates() async {
        loadState = .loading
        do {
            try await store.fetchCandidates()
            if store.candidates.isEmpty {
                loadState = .empty
            } else {
                loadState = .loaded
            }
        } catch {
            loadState = .failed(error.localizedDescription)
        }
    }

}

struct CandidatesScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CandidatesScreen(loadState: .loaded)
                .environmentObject(CandidateStore.preview)
                .previewDisplayName("Loaded with candidates")

            CandidatesScreen(loadState: .empty)
                .environmentObject(CandidateStore.previewEmpty)
                .previewDisplayName("Empty state")

            CandidatesScreen(loadState: .failed("Network error"))
                .environmentObject(CandidateStore.previewEmpty)
                .previewDisplayName("Failed state")
        }
    }
}
