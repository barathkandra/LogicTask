//
//  DocumentPicker.swift
//  BuildSmart
//
//  Created by apple on 11/04/25.
//

import SwiftUI
import UniformTypeIdentifiers
import PDFKit

struct DocumentPicker: UIViewControllerRepresentable {
    var didPickDocuments: ([URL]) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(didPickDocuments: didPickDocuments)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let supportedTypes: [UTType] = [.pdf, .plainText, .rtf, .item, .data]
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let didPickDocuments: ([URL]) -> Void

        init(didPickDocuments: @escaping ([URL]) -> Void) {
            self.didPickDocuments = didPickDocuments
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            didPickDocuments(urls)
        }
    }
}

struct PDFViewer: View {
    let url: URL

    var body: some View {
        PDFKitView(url: url)
            .navigationTitle(url.lastPathComponent)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        if let document = PDFDocument(url: url) {
            pdfView.document = document
        }
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Nothing needed here
    }
}
