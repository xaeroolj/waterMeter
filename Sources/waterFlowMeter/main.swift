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
var gp = gpios[.P26]!

gp.onFalling{
    gpio in
    print("tick")
    saveLog()
}
RunLoop.main.run()
