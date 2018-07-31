import Foundation

struct CSPUrl {
    
    public var url: URL
    
    public init(url: URL) { self.url = url }
    public func getFileName() -> String? { return url.isFileURL ? self.url.lastPathComponent : nil }
    
    public func getFileExtension() -> String? {
        if let fileName = self.getFileName() {
            let potentialFileExtension = fileName.components(separatedBy: ".")
            
            if (potentialFileExtension.count > 1) {
                return potentialFileExtension[potentialFileExtension.count - 1]
            }
        }
        
        return nil
    }
    
    public func getFilePath() -> String {
        var filePath: String = String(self.url.absoluteString.suffix(self.url.absoluteString.count))
        
        if let fileName: String = self.getFileName() {
            filePath = String(filePath.prefix(filePath.count - (fileName.count + 1)))
        }
        
        return filePath
    }
    
    public func containsString(requestedString: String) -> Int {
        if (requestedString != "") {
            var currentInstance: String = ""
            var instanceCounter: Int = 0
            
            for character in self.url.absoluteString {
                if (currentInstance.count > 0) {
                    if (currentInstance.count == requestedString.count) {
                        if (currentInstance == requestedString) {
                            instanceCounter = instanceCounter + 1
                        }
                        
                        currentInstance = ""
                    } else if (String(character) == String(requestedString.dropFirst(currentInstance.count).dropLast(requestedString.count - currentInstance.count))) {
                        currentInstance.append(character)
                    } else {
                        currentInstance = ""
                    }
                } else {
                    if (character == requestedString.first!) {
                        currentInstance.append(character)
                    }
                }
            }
            
            return instanceCounter
        }
        
        return 0
    }
}
