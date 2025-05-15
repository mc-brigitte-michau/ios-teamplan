import SwiftUI
import AddCV
import CVList
import CVStore
import CVDetail
import Theme

public struct CVFeatureRouter: View {

    @ObservedObject var cvStore: CVStore
    let theme: Theme

    @State private var route: CVRoute = .list
    @State private var showingAddSheet: Bool = false

    public var body: some View {
        NavigationStack {
            CVListScreen(
                onEvent: { event in
                    switch event {
                    case let .select(cv):
                        route = .detail(cv)

                    case .add:
                        route = .add
                    }
                }
            )
            .onChange(of: route) { newRoute in
                switch newRoute {
                case .list:
                    cvStore.currentResume = nil
                    showingAddSheet = false

                case .detail(let cv):
                    cvStore.currentResume = cv
                    showingAddSheet = false

                case .add:
                    cvStore.currentResume = nil
                    showingAddSheet = true
                }
            }
            .navigationDestination(
                isPresented:
                    Binding(
                        get: { cvStore.currentResume != nil },
                        set: { isPresented in
                            if !isPresented {
                                cvStore.currentResume = nil
                            }
                        }
                    )
            ) {
                   CVDetailScreen()
            }
            .sheet(isPresented: $showingAddSheet) {
                AddCVScreen()
                    .onDisappear {
                        route = .list
                    }
            }
        }
        .environmentObject(cvStore)
        .environment(\.theme, theme)
    }

    public init(
        cvStore: CVStore,
        theme: Theme
    ) {
        self.cvStore = cvStore
        self.theme = theme
    }
}
