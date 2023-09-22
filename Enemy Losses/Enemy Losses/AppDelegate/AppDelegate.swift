//
//  AppDelegate.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 21.08.2023.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    var mainWindow: NSWindow!
    var listWindow: NSWindow!
    var mainMenu: NSMenu!
    
    var mainView = MainAppScreenView()
    var mainListView = MainLossesListView()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        configureMenus()
        configureMainWindow()
        configureListWindow()
    }
    
    private func configureMenus() {
        let mainMenuFileItem = NSMenuItem(title: "Enemy Losses", action: nil, keyEquivalent: "")
        let fileMenu = NSMenu(title: "Enemy Losses")
        
        fileMenu.addItem(withTitle: "About", action: #selector(aboutScreenAction), keyEquivalent: "A")
        fileMenu.addItem(NSMenuItem.separator())
        fileMenu.addItem(withTitle: "Quit", action: #selector(quitAction), keyEquivalent: "q")
        
        mainMenuFileItem.submenu = fileMenu
        
        mainMenu = NSMenu()
        mainMenu.addItem(mainMenuFileItem)
        
        NSApp.mainMenu = mainMenu
    }
    @objc private func quitAction() {
        URLCache.shared.removeAllCachedResponses()
        DispatchQueue.main.async {
            NSApplication.shared.terminate(nil)
        }
    }
    
    @objc private func aboutScreenAction() {
        NotificationCenter.default.post(name: .shouldToggleAboutWindow, object: nil)
    }
    
    private func configureMainWindow() {
        mainWindow = MainWindow(
            contentRect: NSRect(x: 0,
                                y: 0,
                                width: ViewConstants.defaultWindowWidth,
                                height: ViewConstants.defaultWindowHeight),
            styleMask: [.closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        
        mainWindow.contentView = NSHostingView(rootView: mainView)
        mainWindow.titleVisibility = .hidden
        mainWindow.backgroundColor = .clear
        mainWindow.isMovableByWindowBackground = true
        mainWindow.titlebarAppearsTransparent = true
        mainWindow.titlebarSeparatorStyle = .none
        mainWindow.center()
        mainWindow.makeKeyAndOrderFront(nil)
        
    }
    
    private func configureListWindow() {
        listWindow = ListWindow(
            contentRect: NSRect(x: mainWindow.frame.origin.x - ViewConstants.listWindowOffserX,
                                y: mainWindow.frame.origin.y + ViewConstants.listWindowOffserY,
                                width: ViewConstants.listWindowWidth,
                                height: ViewConstants.listWindowHeight),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        listWindow.collectionBehavior = [.fullScreenNone, .managed, .primary]
        listWindow.contentView = NSHostingView(rootView: mainListView)
        listWindow.titleVisibility = .hidden
        listWindow.backgroundColor = .clear
        listWindow.isMovableByWindowBackground = false
        listWindow.titlebarAppearsTransparent = true
        listWindow.titlebarSeparatorStyle = .none
        listWindow.makeKeyAndOrderFront(nil)
        listWindow.isMovable = false
        mainWindow.addChildWindow(listWindow, ordered: .above)
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {}
    
}

class MainWindow: NSWindow {
    override var canBecomeMain: Bool {
        return false
    }
    override var canBecomeKey: Bool {
        return true
    }
}
class ListWindow: NSWindow {
    override var canBecomeMain: Bool {
        return true
    }
    override var canBecomeKey: Bool {
        return false
    }
}
