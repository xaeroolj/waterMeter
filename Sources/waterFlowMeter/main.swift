import Foundation
import SwiftyGPIO

print("Start")

func saveLog() {
    let fileManager = FileManager.default
    let filePath = fileManager.currentDirectoryPath.appending("/logFile.txt")
    print(filePath)
    let url = URL(fileURLWithPath: filePath)
    do {
        if !fileManager.fileExists(atPath: filePath) {
            fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
        let fileHandle = try FileHandle(forWritingTo: url)
        fileHandle.seekToEndOfFile()
        // convert your string to data or load it from another resource
        let str = "\(Date()) +1\n"
        let textData = Data(str.utf8)
        // append your text to your text file
        fileHandle.write(textData)
        // close it when done
        fileHandle.closeFile()
        print("success")
    } catch {
        print("error")
    }
    
}

let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPiPlusZero)
var gp26 = gpios[.P26]!
var gp19 = gpios[.P19]!

gp26.pull = .up
gp26.direction = .IN
gp26.bounceTime = 0.5

gp19.direction = .OUT
gp19.value = 1

gp26.onFalling{
    gpio in
    print("tick")
    gp19.value = gp19.value == 0 ? 1 : 0
    saveLog()
}
RunLoop.main.run()
