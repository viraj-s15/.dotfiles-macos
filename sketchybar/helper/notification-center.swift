import CoreGraphics
import Foundation

private let nKey: CGKeyCode = 45
private let source = CGEventSource(stateID: .hidSystemState)

guard
    let keyDown = CGEvent(keyboardEventSource: source, virtualKey: nKey, keyDown: true),
    let keyUp = CGEvent(keyboardEventSource: source, virtualKey: nKey, keyDown: false)
else {
    exit(1)
}

keyDown.flags = .maskSecondaryFn
keyDown.post(tap: .cghidEventTap)
usleep(30_000)
keyUp.post(tap: .cghidEventTap)
