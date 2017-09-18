//
//  DeviceFamily.swift
//  SwiftyDevice
//
//  Genereted by HardwareParser on 18/09/2017.
//

import Foundation

// All available Apple devices
public enum DeviceFamily: String {

    case iPhoneOriginal = "iPhone (Original)"
    case iPhone3G = "iPhone 3G"
    case iPhone3GS = "iPhone 3GS"
    case iPhone4 = "iPhone 4"
    case iPhone4CDMA = "iPhone 4 CDMA"
    case iPhone4S4s = "iPhone 4S (4s)"
    case iPhone5 = "iPhone 5"
    case iPhone5s = "iPhone 5s"
    case iPhone5c = "iPhone 5c"
    case iPhone6 = "iPhone 6"
    case iPhone6Plus = "iPhone 6 Plus"
    case iPhone6s = "iPhone 6s"
    case iPhone6sPlus = "iPhone 6s Plus"
    case iPhoneSE = "iPhone SE"
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"
    case iPhone8 = "iPhone 8"
    
    case iPadOriginal = "iPad (Original)"
    case iPad23GVerizon = "iPad 2 3G (Verizon)"
    case iPad2 = "iPad 2"
    case iPad23GATT = "iPad 2 3G (AT&T)"
    case iPad3rdGen = "iPad 3rd Gen"
    case iPad3rdGenWiFiCellular = "iPad 3rd Gen (Wi-Fi + Cellular)"
    case iPad3rdGenWiFiCellularVZ = "iPad 3rd Gen (Wi-Fi + Cellular VZ)"
    case iPad4thGenWiFiCellularMM = "iPad 4th Gen (Wi-Fi + Cellular MM)"
    case iPadMiniWiFiCellular = "iPad mini (Wi-Fi + Cellular)"
    case iPad4thGenWiFiCellular = "iPad 4th Gen (Wi-Fi + Cellular)"
    case iPad4thGenWiFi = "iPad 4th Gen (Wi-Fi)"
    case iPadMiniWiFi = "iPad mini (Wi-Fi)"
    case iPadMiniWiFiCellularMM = "iPad mini (Wi-Fi + Cellular MM)"
    case iPadMiniRetinaWiFi = "iPad mini Retina (Wi-Fi)"
    case iPadMiniRetinaWiFiCellular = "iPad mini Retina (Wi-Fi + Cellular)"
    case iPadAirWiFiCellular = "iPad Air (Wi-Fi + Cellular)"
    case iPadAirWiFi = "iPad Air (Wi-Fi)"
    case iPadAirWiFiCellularCN = "iPad Air (Wi-Fi + Cellular CN)"
    case iPadMiniRetinaWiFiCellularCN = "iPad mini Retina (Wi-Fi + Cellular CN)"
    case iPadMini3WiFiCellular = "iPad mini 3 (Wi-Fi + Cellular)"
    case iPadAir2WiFi = "iPad Air 2 (Wi-Fi)"
    case iPadMini3WiFiCellularChina = "iPad mini 3 (Wi-Fi + Cellular, China)"
    case iPadMini3WiFi = "iPad mini 3 (Wi-Fi)"
    case iPadAir2WiFiCellular = "iPad Air 2 (Wi-Fi + Cellular)"
    case iPadProWiFiCellular = "iPad Pro (Wi-Fi + Cellular)"
    case iPadMini4WiFi = "iPad mini 4 (Wi-Fi)"
    case iPadProWiFi = "iPad Pro (Wi-Fi)"
    case iPadMini4WiFiCellular = "iPad mini 4 (Wi-Fi + Cellular)"
    case iPadPro97WiFiCellular = "iPad Pro 9.7\" (Wi-Fi + Cellular)"
    case iPadPro97WiFi = "iPad Pro 9.7\" (Wi-Fi)"
    case iPad5thGenWiFiCellular = "iPad 5th Gen (Wi-Fi + Cellular)"
    case iPad5thGenWiFi = "iPad 5th Gen (Wi-Fi)"
    case iPadPro1292ndGenWiFiCell = "iPad Pro 12.9\" (2nd Gen - Wi-Fi+Cell)"
    case iPadPro105WiFiCellular = "iPad Pro 10.5\" (Wi-Fi + Cellular)"
    case iPadPro105WiFi = "iPad Pro 10.5\" (Wi-Fi)"
    case iPadPro1292ndGenWiFi = "iPad Pro 12.9\" (2nd Gen - Wi-Fi)"
    
    case appleTV = "Apple TV"
    case appleTV2ndGen = "Apple TV 2nd Gen"
    case appleTV3rdGen = "Apple TV 3rd Gen"
    case appleTV4thGen = "Apple TV 4th Gen"
    case appleTV4K = "Apple TV 4K"
    
    case watchStandard42mm = "Watch Standard 42mm"
    case watchStandard38mm = "Watch Standard 38mm"
    case watchSeries138mm = "Watch Series 1 38mm"
    case watchSeries238mm = "Watch Series 2 38mm"
    case watchSeries242mm = "Watch Series 2 42mm"
    case watchSeries142mm = "Watch Series 1 42mm"
    
    case iPodTouch1G = "iPod Touch 1G"
    case iPodTouch2G = "iPod Touch 2G"
    case iPodTouch3G = "iPod Touch 3G"
    case iPodTouch4G = "iPod Touch 4G"
    case iPodTouch5G = "iPod Touch 5G"
    
    case simulator = "Simulator"

    case unknown = "unknown"

}
