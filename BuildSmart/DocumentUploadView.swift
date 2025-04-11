//
//  DocumentUploadView.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import SwiftUI

struct DocumentUploadView: View {
    @StateObject private var documentManager = DocumentManager()
    @State private var showDocumentPicker = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("gray")
                VStack {
                    if documentManager.documents.isEmpty {
                        Text("No documents uploaded yet.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ScrollView {
                            ForEach(documentManager.documents) { doc in
                                HStack {
                                    Text(doc.name)
                                        .lineLimit(1)

                                    Spacer()
                                    
                                    NavigationLink(destination: QuickLookPreview(url: doc.url)) {
                                        Image(systemName: "eye")
                                    }
                                    
                                    Button(role: .destructive) {
                                        documentManager.deleteDocument(doc)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .frame(minHeight: 100)
                                .cornerRadius(10)
                            }
                        }
                    }

                    Button(action: {
                        showDocumentPicker.toggle()
                    }) {
                        Label("Upload Document", systemImage: "doc.badge.plus")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                // Left image
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("nav_logo")
                        .resizable()
                        .frame(width: 80, height: 40)
                        .padding(.trailing, 8)
                }
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker { urls in
                    for url in urls {
                        documentManager.addDocument(from: url)
                        // TODO: Index the document content for chatbot reference
                    }
                }
            }
        }
    }

    func openDocument(_ url: URL) {
        // You can integrate QLPreviewController here for previewing files
        // Or open with external apps
        UIApplication.shared.open(url)
    }
}

#Preview {
    DocumentUploadView()
}
