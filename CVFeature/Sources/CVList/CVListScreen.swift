import SwiftUI
import ViewState
import CVStore
import Presentation

public struct CVListScreen: View {
    
    @EnvironmentObject private var cvStore: CVStore
    @State private var loadState: LoadState
    public var onEvent: (CVListEvent) -> Void
    
    public var body: some View {
        NavigationStack {
            VStack {
                contentView
            }
            .navigationTitle(String(localized: "title", bundle: .module))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onEvent(.add)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .task(id: loadState) {
                if loadState == .idle {
                    await loadCVs()
                }
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch loadState {
        case .idle, .loading:
            LoadingView(text: "Loading CVs...")

        case .loaded:
            List(cvStore.cvList) { cv in
                Text(cv.name)
                    .onTapGesture {
                        onEvent(.select(cv))
                    }
            }

        case .empty:
            Text("No candidates found.")

        case .failed(let error):
            Text("Failed to load candidates: \(error)")
        }
    }

    public init(
        loadState: LoadState = .idle,
        onEvent: @escaping (CVListEvent) -> Void
    ) {
        self.loadState = loadState
        self.onEvent = onEvent
    }
}

private extension CVListScreen {
    func loadCVs() async {
        loadState = .loading
        do {
            try await cvStore.fetchCVs()
            if cvStore.cvList.isEmpty {
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
            CVListScreen(
                loadState: .loaded,
                onEvent: { _ in }
            )
            .environmentObject(CVStore.preview)
            .previewDisplayName("Loaded with candidates")

            CVListScreen(
                loadState: .empty,
                onEvent: { _ in }
            )
            .environmentObject(CVStore.previewEmpty)
            .previewDisplayName("Empty state")

            CVListScreen(
                loadState: .failed("Network error"),
                onEvent: { _ in }
            )
            .environmentObject(CVStore.previewEmpty)
            .previewDisplayName("Failed state")
        }
    }
}
