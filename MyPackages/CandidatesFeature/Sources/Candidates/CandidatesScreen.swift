import SwiftUI
import CVStore
import Presentation
import Models

public struct CandidatesScreen: View {

    @EnvironmentObject private var store: CVStore
    @Environment(\.theme) private var theme
    @State private var loadState: LoadState
    @State private var searchText = ""

    public var body: some View {
        NavigationStack {
            ZStack {
                theme.backgroundColor
                    .ignoresSafeArea()
                VStack {
                    contentView
                }
            }
            .navigationTitle(String(localized: "title", bundle: .module))
            .toolbarBackground(theme.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                if loadState == .idle {
                    Task {
                        await loadCandidates()
                    }
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
            Text(candidate.fullName)
                .listRowBackground(theme.backgroundColor) 
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(theme.backgroundColor)
        .searchable(text: $searchText)
    }

    public init(loadState: LoadState = .idle) {
        self._loadState = State(initialValue: loadState)
    }
}

private extension CandidatesScreen {
    func loadCandidates() async {
        loadState = .loading
        do {
            try await store.fetchResumes()
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
            return store.candidates.filter { candidate in
                candidate.searchIndex.contains(lowercasedSearch)
            }
        }
    }
}

struct CandidatesScreen_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CandidatesScreen(loadState: .loaded)
                .environmentObject(CVStore.preview)
                .previewDisplayName("Loaded with candidates")

            CandidatesScreen(loadState: .empty)
                .environmentObject(CVStore.previewEmpty)
                .previewDisplayName("Empty state")

            CandidatesScreen(loadState: .failed("Network error"))
                .environmentObject(CVStore.previewEmpty)
                .previewDisplayName("Failed state")
        }
    }
}
