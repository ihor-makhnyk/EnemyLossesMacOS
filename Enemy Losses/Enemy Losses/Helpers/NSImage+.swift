//
//  NSImage+.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 26.08.2023.
//

import AppKit

extension NSImage {
    func pngData() -> Data? {
        guard let tiffData = self.tiffRepresentation,
              let bitmapImageRep = NSBitmapImageRep(data: tiffData),
              let pngData = bitmapImageRep.representation(using: .png, properties: [:])
        else {
            return nil
        }
        
        return pngData
    }
    
    func jpegData(compressionQuality: CGFloat) -> Data? {
        guard let tiffData = self.tiffRepresentation,
              let bitmapImageRep = NSBitmapImageRep(data: tiffData),
              let jpegData = bitmapImageRep.representation(using: .jpeg, properties: [.compressionFactor: compressionQuality])
        else {
            return nil
        }
        
        return jpegData
    }

    func tiffData() -> Data? {
        guard let tiffData = self.tiffRepresentation else {
            return nil
        }
        
        return tiffData
    }
    
}
