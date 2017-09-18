//
//  HardwareParser.swift
//  SwiftDeviceName
//
//  Created by Damien Legrand on 18/08/2017.
//

import Foundation

internal struct Keys {
    static var identifier = "id"
    static var family = "family"
    static var releaseDate = "intro"
}

/// Helper to iterate all cases of an enum
///
/// - Parameter _: Enum to iterate
/// - Returns: Iterator to use in a for loop
func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}

/// Web pages used to get the list of devices
class WebPageGetter {
    
    enum Page: String {
        case iPhonePage = "http://www.everymac.com/systems/apple/iphone/index-iphone-specs.html"
        case iPadPage = "http://www.everymac.com/systems/apple/ipad/index-ipad-specs.html"
        case appleTVPage = "http://www.everymac.com/systems/apple/apple-tv/index-appletv.html"
        case appleWatchPage = "http://www.everymac.com/systems/apple/apple-watch/index-apple-watch-specs.html"
    }
    
    public static func getContent(ofPage page: Page) -> String? {
        return try? String(contentsOf: URL(string: page.rawValue)!)
    }
}

/// Parser to get all devices from `WebPageGetter`
class HardwareParser {
    
    /// base pathe of the file to save the generated swift file
    private let basePath: String
    
    /// listing of all devices data
    private var devices: [String : [String : Any]] = [:]
    
    /// Init HardwareParser
    ///
    /// - Parameter path: the path to the swift file to generate
    init(path: String) {
        basePath = path
    }
    
    /// Run the parsing
    func run() {
        
        var splited: [[String: [String : Any]]] = []
        var index = 0
        for page in iterateEnum(WebPageGetter.Page.self) {
            
            if let string = WebPageGetter.getContent(ofPage: page) {
                
                splited.append(getDataFromHTML(string))
                
                for line in splited[index] {
                    //print(line)
                    devices[line.key] = line.value
                }
            }
            
            index += 1
        }
        
        //iPods
        let formatter = HardwareParser.dateFormatter()
        let iPods: [String: [String: Any]] = [
            "iPod1,1": [Keys.family: "iPod Touch 1G", Keys.releaseDate : formatter.date(from: "September 5, 2007 9:41")!],
            "iPod2,1": [Keys.family: "iPod Touch 2G", Keys.releaseDate : formatter.date(from: "September 9, 2008 9:41")!],
            "iPod3,1": [Keys.family: "iPod Touch 3G", Keys.releaseDate : formatter.date(from: "September 9, 2009 9:41")!],
            "iPod4,1": [Keys.family: "iPod Touch 4G", Keys.releaseDate : formatter.date(from: "September 1, 2010 9:41")!],
            "iPod5,1": [Keys.family: "iPod Touch 5G", Keys.releaseDate : formatter.date(from: "September 12, 2012 9:41")!]
        ]
        
        splited.append(iPods)
        for iPod in iPods {
            //print(line)
            devices[iPod.key] = iPod.value
        }
        
        
        let simulator: [String: [String : Any]] = ["x86_64": [Keys.family: "Simulator"]]
        
        splited.append(simulator)
        devices[simulator.keys.first!] = simulator.values.first!
        
        let plistFile = basePath + "Assets/Devices.plist"
        let swiftFile = basePath + "Classes/DeviceFamily.swift"
        let docFile = basePath + "../Devices.md"
        
        (devices as NSDictionary).write(toFile: plistFile, atomically: true)
        try? DeviceFamilyCreator.deviceFamilySwiftContent(devices: splited).write(toFile: swiftFile, atomically: true, encoding: .utf8)
        try? DeviceFamilyCreator.deviceFamilyDocumentationContent(devices: splited).write(toFile: docFile, atomically: true, encoding: .utf8)
    }
    
    /// Date formatter to use with date from the web pages
    ///
    /// - Returns: DateFormatter
    private static func dateFormatter() -> DateFormatter {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d',' yyyy hh:mm"
        formatter.locale = Locale(identifier: "en")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return formatter
    }
    
    /// Clean value in a line of the parsed HTML
    ///
    /// - Parameter content: the line to clean
    /// - Returns: cleaned line
    private static func cleanValue(content: String) -> String {
        
        return content
            .replacingOccurrences(of: "<td>", with: "")
            .replacingOccurrences(of: "</td>", with: "")
            .replacingOccurrences(of: "</a>", with: "")
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&amp;", with: "&")
    }
    
    /// Get the data from the HTML
    ///
    /// - Parameter html: HTML from the request
    /// - Returns: list of device as a data dictionary
    private func getDataFromHTML(_ html: String) -> [String: [String: Any]] {
        
        var data: [String : [String : Any]] = [:]
        var currentItem: [String : Any] = [:]
        var currentId: String? = nil
        var nextDataToGet: String? = nil
        let formatter = HardwareParser.dateFormatter()
        
        func terminateItem() {
            
            if let id = currentId, data[id] == nil {
                data[id] = currentItem
            }
            
            currentId = nil
            currentItem.removeAll()
        }
        
        html.enumerateLines { line, _ in
            
            let content = line.trimmingCharacters(in: CharacterSet.whitespaces)
            
            if let key = nextDataToGet {
                
                nextDataToGet = nil
                var value = HardwareParser.cleanValue(content: content)
                
                if let startIndex = value.index(of: ">") {
                    
                    value = String(value[value.index(after: startIndex)..<value.endIndex])
                }
                
                if key == Keys.identifier {
                    
                    currentId = value
                    
                } else {
                    
                    if key == Keys.releaseDate {
                        
                        if let d = formatter.date(from: value + " 9:41") {
                            currentItem[key] = d
                        }
                        
                    } else {
                    
                        //quickfix
                        if value.first == "2" || value.first == "3" || value.first == "4" {
                            value = "Apple TV " + value
                        }
                        currentItem[key] = value
                    }
                }
            } else {
                
                if content == "<div id=\"contentcenter_specs_internalnav_2\">" { //in HTML `id` should be unique...
                    terminateItem()
                } else if content == "<td>Intro.</td>" {
                    nextDataToGet = Keys.releaseDate
                } else if content == "<td>Family</td>" {
                    nextDataToGet = Keys.family
                } else if content == "<td>ID</td>" {
                    nextDataToGet = Keys.identifier
                }
            }
        }
        
        terminateItem()
        
        return data
    }
}
