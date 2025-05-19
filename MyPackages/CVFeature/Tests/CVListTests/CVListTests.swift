import Testing
import Models
import CVStore
@testable import CVList

@Suite
struct CVListTests {

    @MainActor @Test
    func testAddEventFires() {
        var triggered: CVListEvent?
        let screen = CVListScreen() { event in
            triggered = event
        }
        screen.onEvent(.add)
        #expect(triggered == .add)
    }
}
