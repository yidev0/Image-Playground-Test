//
//  ContentView.swift
//  Image Playground Test
//
//  Created by Yuto on 2024/11/05.
//

import SwiftUI
import ImagePlayground

struct ContentView: View {
    
    @Environment(\.supportsImagePlayground) var supportsImagePlayground
    @Environment(\.openURL) var openURL
    @Environment(\.openWindow) var openWindow
    
    @State var showPlayground: Bool = false
    @State var concepts: [String] = []
    
    var body: some View {
        if supportsImagePlayground {
            form
        } else {
            Form {
                ContentUnavailableView("Image Playground not available on this device", systemImage: "apple.image.playground")
            }
            .onTapGesture {
                openURL.callAsFunction(.init(string: "https://support.apple.com/121115")!)
            }
        }
    }
    
    var form: some View {
        Form {
            Section {
                ForEach(concepts.indices, id: \.self) { index in
                    HStack {
                        TextField("Concept", text: $concepts[index])
                            .labelsHidden()
                            .onSubmit {
                                addConcept()
                            }
                        
                        Button {
                            concepts.remove(at: index)
                        } label: {
                            Image(systemName: "minus")
                        }
                    }
                }
                .onDelete(perform: deleteConcept(at:))
            } header: {
                HStack {
                    Text("Concepts")
                    Spacer()
                    Button {
                        addConcept()
                    } label: {
                        Text("Add Concept")
                    }
                    .buttonStyle(.borderless)
                }
            }
            
            Section {
                Button {
                    showPlayground = true
                } label: {
                    Text("Show Playground")
                }
            }
        }
        .formStyle(.grouped)
        .imagePlaygroundSheet(
            isPresented: $showPlayground,
            concepts: concepts.map { ImagePlaygroundConcept.text($0)
            }
        ) { url in
            openWindow.callAsFunction(id: "Image", value: url)
        }
    }
    
    func deleteConcept(at offsets: IndexSet) {
        concepts.remove(atOffsets: offsets)
    }
    
    func addConcept() {
        if concepts.last?.isEmpty == false || concepts.isEmpty {
            concepts.append("")
        }
    }
}

#Preview {
    ContentView()
}
