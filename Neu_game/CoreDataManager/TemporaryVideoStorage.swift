//
//  TemporaryVideoStorage.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 12/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation

class TemporaryVideoStorage {
    private let path: URL
    private let _queue = DispatchQueue(label: "com.github.kean.Nuke.TemporaryVideoStorage.Queue")

    // Ignoring error handling for simplicity.
    static let shared = try! TemporaryVideoStorage()

    init() throws {
        guard let root = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        self.path = root.appendingPathComponent("com.github.kean.Nuke.TemporaryVideoStorage", isDirectory: true)
        // Clear the contents that could potentially was left from the previous session.
        try? FileManager.default.removeItem(at: path)
        try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
    }

    func storeData(_ data: Data, _ completion: @escaping (URL) -> Void) {
        _queue.async {
            let url = self.path.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
            try? data.write(to: url) // Ignore that write may fail in some cases
            DispatchQueue.main.async {
                completion(url)
            }
        }
    }

    func removeData(for url: URL) {
        _queue.async {
            try? FileManager.default.removeItem(at: url)
        }
    }

    func removeAll() {
        _queue.async {
            // Clear the contents that could potentially was left from the previous session.
            try? FileManager.default.removeItem(at: self.path)
            try? FileManager.default.createDirectory(at: self.path, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
