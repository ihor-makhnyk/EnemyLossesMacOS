//
//  main.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import Cocoa

let app = NSApplication.shared
let controller = AppDelegate()
NSApp.setActivationPolicy(.regular)
app.delegate = controller
app.activate(ignoringOtherApps: true)
app.run()
