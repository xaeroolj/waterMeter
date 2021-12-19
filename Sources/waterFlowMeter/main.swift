import Foundation
import SwiftyGPIO

print("Start")
let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPiPlusZero)
var gp = gpios[.P26]!


gp.onRaising{
    gpio in
    print("Transition to 1, current value:" + String(gpio.value))
}
gp.onFalling{
    gpio in
    print("Transition to 0, current value:" + String(gpio.value))
}
gp.onChange{
    gpio in
//    gpio.clearListeners()
    print("The value changed, current value:" + String(gpio.value))
}  

RunLoop.main.run()
