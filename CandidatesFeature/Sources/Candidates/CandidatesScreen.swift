// TODO: Add search logic for name, skill, tech 

import SwiftUI
import CandidateStore
import Presentation

public struct CandidatesScreen: View {

    @EnvironmentObject private var store: CandidateStore
    @State private var loadState: LoadState
    @State private var searchText = ""

    public var body: some View {
        NavigationStack {
            VStack {
                contentView
            }
            .navigationTitle(String(localized: "title", bundle: .module))
            .task(id: loadState) {
                if loadState == .idle {
                    await loadCandidates()
                }
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch loadState {
        case .idle, .loading:
            LoadingView(text: "Loading Candidates...")

        case .loaded:
            candidatesList

        case .empty:
            Text("No candidates found.")

        case .failed(let error):
            Text("Failed to load candidates: \(error)")
        }
    }

    private var candidatesList: some View {
        List(filteredCandidates) { candidate in
            Text(candidate.name)
        }
        .searchable(text: $searchText)
        .refreshable {
            await loadCandidates()
        }
    }

    public init(loadState: LoadState = .idle) {
        self._loadState = State(initialValue: loadState)
    }
}

private extension CandidatesScreen {
    func loadCandidates() async {
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

    private var filteredCandidates: [Candidate] {
        if searchText.isEmpty {
            return store.candidates
        } else {
            let lowercasedSearch = searchText.lowercased()
            return store.candidates.filter {
                $0.name.lowercased().contains(lowercasedSearch)
            }
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
