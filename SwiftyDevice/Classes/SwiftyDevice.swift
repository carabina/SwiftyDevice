import Foundation
import UIKit

// MARK: - Helper to find the plist file

fileprivate extension Bundle {
    
    /// The current framework
    static var frameworkBundle: Bundle? {
        
        return Bundle(for: type(of: SwiftyDevice.shared))
    }
    
    /// Get the data from the SwiftyDevice plist
    static var devicesList: [String : [String: Any]] {
        
        guard let bundleURL = self.frameworkBundle?.url(forResource: "SwiftyDevice", withExtension: "bundle"),
            let bundle = Bundle(url: bundleURL),
            let path = bundle.path(forResource: "Devices", ofType: "plist") else {
            
                return [String: [String: Any]]()
        }

        return NSDictionary(contentsOfFile: String(path)) as? [String : [String: Any]] ?? [String: [String: Any]]()
    }
}

// MARK: - SwiftyDevice

public extension DeviceFamily {
    
    /// The device version (i.e. `iPhone 7` Plus will return `7 Plus`)
    public func hardwareVersion() -> String {
        return self.removeHardwareType(fromFamilyName: self.rawValue)
    }
    
    private func removeHardwareType(fromFamilyName familyName: String) -> String {
        
        return familyName
            .replacingOccurrences(of: "iPhone", with: "")
            .replacingOccurrences(of: "iPod Touch", with: "")
            .replacingOccurrences(of: "iPad", with: "")
            .replacingOccurrences(of: "Apple Watch", with: "")
            .replacingOccurrences(of: "Apple TV", with: "")
            .replacingOccurrences(of: "Simulator", with: "")
            .trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
}

/// Represent a device with his family and release date
public struct Device {
    
    public let family: DeviceFamily
    public let releaseDate: Date?
    
    /// Device information for the current device
    public static var currentDevice: Device {
        
        return Device(family: SwiftyDevice.shared.deviceFamily,
                      releaseDate: SwiftyDevice.shared.deviceReleaseDate)
    }
    
    /// Device information for a device codename
    ///
    /// - Parameter codename: string
    /// - Returns: Device
    public static func device(with codename: String) -> Device {
        
        return Device(family: SwiftyDevice.shared.deviceFamily(for: codename),
                      releaseDate: SwiftyDevice.shared.deviceReleaseDate(for: codename))
    }
}

/// SwiftyDevice
///
/// ## Note
///
/// All devices information (name & release date) are from the website www.everymac.com
public class SwiftyDevice {
    
    /// Singleton
    public static var shared = SwiftyDevice()
    
    /// List of all available devices
    private var _devices: [String : [String: Any]]?
    
    /// List of all available devices
    public var devices: [String : [String: Any]]? {
        
        if let d = _devices {
            return d
        }
        
        _devices = Bundle.devicesList
        return _devices
    }
    
    /// Get the current device codename (i.e iPhone9,4 ...)
    public var deviceCodename: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    /// Get the current device family
    public var deviceFamily: DeviceFamily {
        
        return self.deviceFamily(for: self.deviceCodename)
    }
    
    /// Get a device family from a codename
    ///
    /// - Parameter codename: string
    /// - Returns: the device family
    public func deviceFamily(for codename: String) -> DeviceFamily {
        
        let family = self.devices?[codename]?[Keys.family] as? String ?? "unknown"
        return DeviceFamily(rawValue: family) ?? .unknown
    }
    
    /// Get the current device release date
    public var deviceReleaseDate: Date? {
        
        return self.deviceReleaseDate(for: self.deviceCodename)
    }
    
    /// Get the release date from a device codename
    ///
    /// - Parameter codename: string
    /// - Returns: the release date
    public func deviceReleaseDate(for codename: String) -> Date? {
        
        return self.devices?[codename]?[Keys.releaseDate] as? Date
    }
}
