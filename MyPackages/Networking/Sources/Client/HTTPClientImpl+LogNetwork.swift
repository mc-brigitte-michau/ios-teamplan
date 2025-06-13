import Foundation
import Logging

#if DEBUG
extension HTTPClientImpl {
    func logNetwork(_ method: String, endpoint: String, data: Data?) -> String {
    ("""
    🕒 \(Date())
    🔁 \(method) \(endpoint)
    📦 JSON:
    \(prettyPrintedJSON(from: data) ?? "⚠️ Invalid or empty data")

    """)
    }

    private func prettyPrintedJSON(from data: Data?) -> String? {
        guard let data else { return nil }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            return String(data: prettyData, encoding: .utf8)
        } catch {
            AppLogger.network.debug("❌ Failed to pretty-print JSON:, \(error)")
            return nil
        }
    }
}
#endif
