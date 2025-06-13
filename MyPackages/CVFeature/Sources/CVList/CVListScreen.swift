import CVStore
import Models
import Presentation
import SwiftUI
import ViewState

public struct CVListScreen: View {
    @EnvironmentObject private var cvStore: CVStore
    @Environment(\.theme)
    private var theme
    public var onEvent: (CVListEvent) -> Void

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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onEvent(.add)
                    } label: {
                        Image(systemName: "plus")
                            .accessibilityLabel("Add")
                    }
                }
            }
            .onAppear {
                if cvStore.listLoadState == .idle {
                    Task {
                        try await cvStore.fetchResumes()
                    }
                }
            }
        }
    }

    @ViewBuilder private var contentView: some View {
        switch cvStore.listLoadState {
        case .idle,
                .loading:
            LoadingView(text: "Loading CVs...")

        case .loaded:
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text(cvStore.myResume?.fullName ?? "No Name")
                    Text(cvStore.myResume?.id ?? "No email")
                }
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.sm)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(theme.backgroundColor)

                List(cvStore.myResume?.resumes ?? [], id: \.id) { resume in
                    HStack {
                        Text(resume.resumeName)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onEvent(.select(resume))
                    }
                    .accessibilityAddTraits(.isButton)
                    .listRowBackground(theme.backgroundColor)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .background(theme.backgroundColor)

        case .empty:
            Text("No resume found. Please add one.")

        case .failed(let error):
            Text("Failed to load resume: \(error)")
        }
    }

    public init(
        onEvent: @escaping (CVListEvent) -> Void
    ) {
        self.onEvent = onEvent
    }
}

struct CandidatesScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CVListScreen { _ in }
            .environmentObject(CVStore.preview)
            .previewDisplayName("Loaded with candidates")

            CVListScreen { _ in }
            .environmentObject(CVStore.previewEmpty)
            .previewDisplayName("Empty state")

            CVListScreen { _ in }
            .environmentObject(CVStore.previewFailure)
            .previewDisplayName("Failed state")
        }
    }
}
