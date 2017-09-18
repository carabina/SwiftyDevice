//
//  DeviceFamilyCreator.swift
//  HardwareParser
//
//  Created by Damien Legrand on 18/08/2017.
//

import Foundation

/// Create the DeviceFamily swif file with all cases
class DeviceFamilyCreator {
    
    private static let separator: String = "_"
    
    /// Clean the name of a device family and camel case it
    ///
    /// - Parameter family: family name to clean
    /// - Returns: cleaned family name
    private static func cleanFamily(family: String) -> String {
        
        var string = family
            .replacingOccurrences(of: " ", with: DeviceFamilyCreator.separator)
            .replacingOccurrences(of: "(", with: DeviceFamilyCreator.separator)
            .replacingOccurrences(of: ")", with: DeviceFamilyCreator.separator)
            .replacingOccurrences(of: "+", with: DeviceFamilyCreator.separator)
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "&", with: "")
            .replacingOccurrences(of: "___", with: DeviceFamilyCreator.separator)
            .replacingOccurrences(of: "__", with: DeviceFamilyCreator.separator)
        
        if string.last == "_" {
            string = String(string.dropLast())
        }
        
        return DeviceFamilyCreator.camelCaseString(originalString: string)
    }
    
    /// Convert snakecase string to camel case string
    ///
    /// - Parameter originalString: string to convert to camel case format
    /// - Returns: camelcase string
    private static func camelCaseString(originalString: String) -> String {
        
        var string = originalString.split(separator: DeviceFamilyCreator.separator[DeviceFamilyCreator.separator.startIndex]).map({ (subString) -> String in
            
            var string = String(subString)
            
            if string.count == 1 {
                return string.uppercased()
            }
            
            let firstChar = String(string[string.startIndex])
            string.remove(at: string.startIndex)
            
            return firstChar.uppercased() + string
            
        }).joined()
        
        let firstChar = String(string[string.startIndex])
        string.remove(at: string.startIndex)
        
        return firstChar.lowercased() + string
    }
    
    /// The current date to print in the swift file comment
    ///
    /// - Returns: date string
    private static func currentDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: Date())
    }
    
    /// Generate the content of the swift file
    ///
    /// - Parameter devices: list of devices
    /// - Returns: string
    static func deviceFamilySwiftContent(devices: [[String: [String : Any]]]) -> String {
        
        let spacer = "\n    "
        var cases = ""
        var done: [String] = []
        
        for deviceList in devices {
            
            if !cases.isEmpty {
                cases += spacer
            }
            
            for device in deviceList.sorted(by: { (left, right) -> Bool in
                guard let leftDevice = left.value[Keys.releaseDate] as? Date, let rightDevice = right.value[Keys.releaseDate] as? Date else { return true }
                return leftDevice < rightDevice
            }) {
            
                guard let family = device.value[Keys.family] as? String, !done.contains(family) else {
                    continue
                }
                
                done.append(family)
                
                let cleanFamily = DeviceFamilyCreator.cleanFamily(family: family)
                
                if !cases.isEmpty {
                    cases += spacer
                }
                
                cases += "case "
                cases += cleanFamily
                cases += " = \"\(family.replacingOccurrences(of: "\"", with: "\\\""))\""
            }
        }
        
        return """
        //
        //  DeviceFamily.swift
        //  SwiftyDevice
        //
        //  Genereted by HardwareParser on \(DeviceFamilyCreator.currentDate()).
        //
        
        import Foundation
        
        // All available Apple devices
        public enum DeviceFamily: String {
        
            \(cases)
        
            case unknown = "unknown"
        
        }
        
        """
    }
    
    /// Generate the content of the documentation file
    ///
    /// - Parameter devices: list of devices
    /// - Returns: string
    static func deviceFamilyDocumentationContent(devices: [[String: [String : Any]]]) -> String {
        
        let spacer = "\n"
        var cases = ""
        var done: [String] = []
        
        for deviceList in devices {
            
            for device in deviceList.sorted(by: { (left, right) -> Bool in
                guard let leftDevice = left.value[Keys.releaseDate] as? Date, let rightDevice = right.value[Keys.releaseDate] as? Date else { return true }
                return leftDevice < rightDevice
            }) {
                
                guard let family = device.value[Keys.family] as? String, !done.contains(family) else {
                    continue
                }
                
                done.append(family)
                
                let cleanFamily = DeviceFamilyCreator.cleanFamily(family: family)
                
                if !cases.isEmpty {
                    cases += spacer
                }
                
                cases += "`\(cleanFamily)` | \(family)"
            }
        }
        
        return """
        # Supported Devices
        
        DeviceFamily | .rawValue
        ------------ | -------------
        \(cases)
        
        """
    }
}
