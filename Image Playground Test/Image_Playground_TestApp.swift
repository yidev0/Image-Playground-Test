//
//  Image_Playground_TestApp.swift
//  Image Playground Test
//
//  Created by Yuto on 2024/11/05.
//

import SwiftUI

@main
struct Image_Playground_TestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(.init(width: 400, height: 300))
        
        WindowGroup("Result", id: "Image", for: URL.self) { url in
            ZStack {
                if let url = url.wrappedValue {
#if canImport(AppKit)
                    if let image = NSImage(data: .init(try! Data(contentsOf: url))) {
                        Image(nsImage: image)
                            .resizable()
                    }
#else
                    if let image = UIImage(data: .init(try! Data(contentsOf: url))) {
                        Image(uiImage: image)
                            .resizable()
                    }
#endif
                } else {
                    ContentUnavailableView("Image not available", systemImage: "photo")
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .aspectRatio(1, contentMode: .fit)
        }
        .defaultSize(.init(width: 300, height: 300))
        .windowIdealSize(.fitToContent)
        .windowResizability(.contentMinSize)
    }
}
