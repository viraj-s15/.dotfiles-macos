import CoreGraphics
import Foundation

@_silgen_name("DisplayServicesGetBrightness")
func getBrightness(_ display: CGDirectDisplayID, _ value: UnsafeMutablePointer<Float>) -> Int32

@_silgen_name("DisplayServicesSetBrightness")
func setBrightness(_ display: CGDirectDisplayID, _ value: Float) -> Int32

let display = CGMainDisplayID()
let arguments = CommandLine.arguments

guard arguments.count >= 2 else {
  exit(64)
}

switch arguments[1] {
case "get":
  var value: Float = 0
  guard getBrightness(display, &value) == 0 else { exit(1) }
  print(Int((value * 100).rounded()))
case "set":
  guard arguments.count == 3, let percentage = Float(arguments[2]) else { exit(64) }
  let value = min(max(percentage, 0), 100) / 100
  exit(setBrightness(display, value) == 0 ? 0 : 1)
default:
  exit(64)
}
