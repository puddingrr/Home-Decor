//
//  Utiize.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import Foundation

class LogWriter {
    static let shared = LogWriter()

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
    
    
    /// Read all logs from the file
    func readLogs() -> String? {
        guard let logFilePath = logFilePath else {
            return nil
        }
        
        return try? String(contentsOf: logFilePath)
    }
    
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
    func printGroupNoFromUrl(urlString: String) -> String {
        if let urlComponents = URLComponents(string: urlString) {
            if let queryItems = urlComponents.queryItems {
                if let groupNo = queryItems.first(where: { $0.name == "groupNo" })?.value {
                    return(groupNo) // Output: 1-101-mb810-16
                }
            }
        }
        return "\(urlString)"
    }
}

