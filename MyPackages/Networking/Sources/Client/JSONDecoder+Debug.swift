import Foundation
import Logging

extension JSONDecoder {
    func decodeDebug<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        do {
            return try self.decode(T.self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            AppLogger.network.debug("❌ Key '\(key.stringValue)' not found: \(context.debugDescription)")
            AppLogger.network.debug("📍 codingPath: \(context.codingPath)")
        } catch let DecodingError.typeMismatch(expectedType, context) {
            AppLogger.network.debug("❌ Type mismatch for \(expectedType): \(context.debugDescription)")
            AppLogger.network.debug("📍 codingPath: \(context.codingPath)")
        } catch let DecodingError.valueNotFound(value, context) {
            AppLogger.network.debug("❌ Value '\(value)' not found: \(context.debugDescription)")
            AppLogger.network.debug("📍 codingPath: \(context.codingPath)")
        } catch let DecodingError.dataCorrupted(context) {
            AppLogger.network.debug("❌ Data corrupted: \(context.debugDescription)")
            AppLogger.network.debug("📍 codingPath: \(context.codingPath)")
        } catch {
            AppLogger.network.debug("❌ Other decoding error: \(error.localizedDescription)")
        }
        return nil
    }
}
