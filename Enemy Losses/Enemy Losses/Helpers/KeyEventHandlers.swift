//
//  KeyEventHandlers.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 24.08.2023.
//

import SwiftUI

struct KeyEventHandler: NSViewRepresentable {
    var action: (() -> Void)
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    class KeyView: NSView {
        var action: (() -> Void)?
        override var acceptsFirstResponder: Bool { true }
        override func keyDown(with event: NSEvent) {
            if event.keyCode == 0x35, let action = action {
                action()
                
            }
        }
        init(frame frameRect: NSRect, action: @escaping () -> Void) {
            super.init(frame:frameRect)
            self.action = action
        }
        
        override init(frame frameRect: NSRect) {
            super.init(frame:frameRect);
        }
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    
    func makeNSView(context: Context) -> NSView {
        let view = KeyView(frame: NSRect(), action: action)
        DispatchQueue.main.async { view.window?.makeFirstResponder(view) }
        return view
    }
    func updateNSView(_ nsView: NSView, context: Context) {}
}

