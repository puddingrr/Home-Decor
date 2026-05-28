//
//  FirebaseLog.swift
//  Home Decor
//
//  Created by Dalynn on 5/28/26.

import Foundation
import FirebaseFirestore
// MARK: - Log Type

enum FirebaseLogType {
    case fetch, success, failure, cache, auth, info

    var icon: String {
        switch self {
        case .fetch:   return "📡"
        case .success: return "✅"
        case .failure: return "❌"
        case .cache:   return "💾"
        case .auth:    return "🔐"
        case .info:    return "ℹ️"
        }
    }

    var label: String {
        switch self {
        case .fetch:   return "FETCHING"
        case .success: return "SUCCESS"
        case .failure: return "FAILED"
        case .cache:   return "CACHE"
        case .auth:    return "AUTH"
        case .info:    return "INFO"
        }
    }
}

// MARK: - LogWriter

class FirebaseLog {
    static let shared = FirebaseLog()
    private let logFileName = "application.log"
    private var logFilePath: URL?
    private let isEnabled = true
    private let writeToFile = false
    private let queue = DispatchQueue(label: "log.writer.queue")

    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS zzz"
        f.timeZone = .current
        return f
    }()

    init() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            logFilePath = dir.appendingPathComponent(logFileName)
            AppInfoLogger.log()
            if writeToFile, let path = logFilePath,
               !FileManager.default.fileExists(atPath: path.path) {
                FileManager.default.createFile(atPath: path.path, contents: nil)
            }
        }
    }

    // MARK: - Read Logs

    func readLogs() -> String? {
        guard let logFilePath = logFilePath else { return nil }
        return try? String(contentsOf: logFilePath)
    }

    // MARK: - General Log

    func log(_ message: String) {
        guard isEnabled else { return }

        let timestamp = Self.formatter.string(from: Date())
        let line = "[\(timestamp)] \(message)\n"
        print(line)

        guard writeToFile, let path = logFilePath else { return }

        queue.async {
            do {
                let handle = try FileHandle(forWritingTo: path)
                defer { try? handle.close() }
                handle.seekToEndOfFile()
                handle.write(Data(line.utf8))
            } catch {
                print("Log write failed: \(error)")
            }
        }
    }

    // MARK: - Firebase Pretty Log

    func logFirebase(
        _ type: FirebaseLogType,
        collection: String,
        count: Int? = nil,
        elapsed: Double? = nil,
        extra: String? = nil
    ) {
        guard isEnabled else { return }

        let timestamp   = Self.formatter.string(from: Date())
        let divider     = String(repeating: "─", count: 52)
        let countStr    = count.map   { "📄 \($0) doc(s)"                       } ?? nil
        let elapsedStr  = elapsed.map { "⏱ \(String(format: "%.3f", $0))s"      } ?? nil
        let extraStr    = extra

        // Build detail line from non-nil parts
        let details = [countStr, elapsedStr, extraStr]
            .compactMap { $0 }
            .joined(separator: "  |  ")

        let line = """
        \(divider)
        \(type.icon)  [\(timestamp)]
           └─ Status     : \(type.label)
           └─ Collection : \(collection)\(details.isEmpty ? "" : "\n   └─ Details   : \(details)")
        \(divider)
        """

        print(line)

        guard writeToFile, let path = logFilePath else { return }

        queue.async {
            do {
                let handle = try FileHandle(forWritingTo: path)
                defer { try? handle.close() }
                handle.seekToEndOfFile()
                handle.write(Data((line + "\n").utf8))
            } catch {
                print("Firebase log write failed: \(error)")
            }
        }
    }

    // MARK: - URL Utility

    func printGroupNoFromUrl(urlString: String) -> String {
        if let urlComponents = URLComponents(string: urlString),
           let groupNo = urlComponents.queryItems?.first(where: { $0.name == "groupNo" })?.value {
            return groupNo
        }
        return urlString
    }
    
    // MARK: - Network Pretty Log

    func logRequest(
        url: String,
        headers: [String: String]? = nil,
        body: String? = nil
    ) {
        guard isEnabled else { return }

        let timestamp = Self.formatter.string(from: Date())
        let headerStr = headers.map { dict in
            dict.map { "      \"\($0.key)\": \"\($0.value)\"" }.joined(separator: ",\n")
        }

        let line = """
        [\(timestamp)]       ⚡️⚡️⚡️⚡️ Headers: [\(headerStr.map { "\n\($0)\n   " } ?? "none")]
              ⚡️⚡️⚡️⚡️ Request Body: \(body ?? "None")
        """
        print(line)
    }

    func logResponse(
        url: String,
        responseBody: String
    ) {
        guard isEnabled else { return }

        let timestamp = Self.formatter.string(from: Date())
        let line = """
        [\(timestamp)] ✅✅✅✅
        URL -->: \(url)
        Response Received -->: \(responseBody)
        ✅✅✅✅
        """
        print(line)
    }

    func logFailResponse(
        url: String,
        error: String
    ) {
        guard isEnabled else { return }

        let timestamp = Self.formatter.string(from: Date())
        let line = """
        [\(timestamp)] ❌❌❌❌
        URL -->: \(url)
        Error -->: \(error)
        ❌❌❌❌
        """
        print(line)
    }
    // MARK: - One Line Fetch

    static func fetch<T: Decodable>(
        collection: String,
        type: T.Type,
        db: Firestore = Firestore.firestore(),
        success: @escaping (T, Int) -> Void,
        failure: @escaping (String) -> Void
    ) {
        FirebaseLog.shared.logFirebase(.fetch, collection: collection)
        let start = Date()

        db.collection(collection).getDocuments { snapshot, error in
            let elapsed = Date().timeIntervalSince(start)

            if let error = error {
                FirebaseLog.shared.logFirebase(.failure, collection: collection, elapsed: elapsed, extra: error.localizedDescription)
                failure(error.localizedDescription)
                return
            }

            let docs = snapshot?.documents.map { $0.data() } ?? []

            // Pretty print response
            if let jsonData = try? JSONSerialization.data(withJSONObject: docs, options: .prettyPrinted),
               let jsonStr = String(data: jsonData, encoding: .utf8) {
                FirebaseLog.shared.logResponse(url: "firestore://\(collection)", responseBody: jsonStr)
            }

            // Decode
            guard let jsonData = try? JSONSerialization.data(withJSONObject: ["items": docs]),
                  let decoded = try? JSONDecoder().decode(T.self, from: jsonData) else {
                FirebaseLog.shared.logFirebase(.failure, collection: collection, elapsed: elapsed, extra: "Decode failed")
                failure("Decode failed")
                return
            }

            FirebaseLog.shared.logFirebase(.success, collection: collection, count: docs.count, elapsed: elapsed)
            success(decoded, docs.count)
        }
    }
}
