import AddCV
import CVDetail
import CVList
import CVStore
import SwiftUI
import Theme

public struct CVFeatureRouter: View {
    @ObservedObject var cvStore: CVStore
    let theme: Theme

    @State private var route: CVRoute = .list
    @State private var showingAddSheet: Bool = false

    public var body: some View {
        NavigationStack {
            CVListScreen(onEvent: handleEvent)
                .onChange(of: route, perform: handleRouteChange)
                .navigationDestination(isPresented: isDetailPresentedBinding) {
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

private extension CVFeatureRouter {
    var isDetailPresentedBinding: Binding<Bool> {
        Binding(
            get: { cvStore.currentResume != nil },
            set: { isPresented in
                if !isPresented {
                    cvStore.currentResume = nil
                }
            }
        )
    }

    func handleEvent(_ event: CVListEvent) {
        switch event {
        case let .select(cv):
            route = .detail(cv)
        case .add:
            route = .add
        }
    }

    func handleRouteChange(_ newRoute: CVRoute) {
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
}
