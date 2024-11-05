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
    
    @State var isPresented: Bool = false
    @State var isPresentedWithConcept: Bool = false
    
    @State var text: String = ""
    @State var resultURL: URL?
    
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
                Button {
                    isPresented = true
                } label: {
                    Text("Show Playground")
                }
            }
            
            Section {
                TextField("Concept", text: $text)
                Button {
                    isPresentedWithConcept = true
                } label: {
                    Text("Show Playground")
                }
                .disabled(text.isEmpty)
            }
            
            if let url = resultURL {
                Section {
#if canImport(AppKit)
                    if let image = NSImage(data: .init(try! Data(contentsOf: url))) {
                        Image(nsImage: image)
                    }
#else
                    if let image = UIImage(data: .init(try! Data(contentsOf: url))) {
                        Image(uiImage: image)
                    }
#endif
                }
            }
        }
        .formStyle(.grouped)
        .imagePlaygroundSheet(isPresented: $isPresented) { url in
            
        }
        .imagePlaygroundSheet(isPresented: $isPresentedWithConcept, concept: text) { url in
            
        }
    }
}

#Preview {
    ContentView()
}
