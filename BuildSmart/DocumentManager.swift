//
//  DocumentManager.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct UploadedDocument: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let url: URL
}

class DocumentManager: ObservableObject {
    @Published var documents: [UploadedDocument] = []

    private let documentsDirectory: URL = {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }()

    init() {
        loadDocuments()
    }

    func addDocument(from url: URL) {
        let destination = documentsDirectory.appendingPathComponent(url.lastPathComponent)

        do {
            if FileManager.default.fileExists(atPath: destination.path) == false {
                try FileManager.default.copyItem(at: url, to: destination)
            }
            documents.append(UploadedDocument(name: url.lastPathComponent, url: destination))
        } catch {
            print("Failed to copy document: \(error)")
        }
    }

    func deleteDocument(_ document: UploadedDocument) {
        do {
            try FileManager.default.removeItem(at: document.url)
            documents.removeAll { $0.id == document.id }
        } catch {
            print("Failed to delete document: \(error)")
        }
    }

    private func loadDocuments() {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            documents = fileURLs.map { UploadedDocument(name: $0.lastPathComponent, url: $0) }
        } catch {
            print("Failed to load documents: \(error)")
        }
    }
}
