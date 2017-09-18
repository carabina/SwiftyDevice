# SwiftyDevice

[![Version](https://img.shields.io/cocoapods/v/SwiftyDevice.svg?style=flat)](http://cocoapods.org/pods/SwiftyDevice)
[![License](https://img.shields.io/cocoapods/l/SwiftyDevice.svg?style=flat)](http://cocoapods.org/pods/SwiftyDevice)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyDevice.svg?style=flat)](http://cocoapods.org/pods/SwiftyDevice)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Tested on:

* Xcode 9
* Swift 4

## Installation

SwiftyDevice is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyDevice'
```

## Usage

To use **SwiftyDevice** import it :

```
import SwiftyDevice
```

And in the code :

``` swift
/// Get information about the current device

let device = Device.currentDevice

print("Device family name : \(device.family.rawValue)") // Device family name : iPad Pro 10.5" (Wi-Fi)
print("Device release date : \(device.releaseDate)") // Device release date : 06/05/2017

/// Or get information about another device with the codename

let otherDevice = Device.device(with: "iPhone9,4") // otherDevice.family = DeviceFamily.iPhone7Plus
```

See the list of supported devices : [Supported Devices](Devices.md)

## Development

The `Devices.plist` and `DeviceFamily.swift` enum are generated automatically from another target in the project, `HardwareParser`.
To add new devices in the project, simply run the `HardwareParser` scheme on the mac, and the two files will be updated with the data from www.everymac.com.

## Author

Damien Legrand

## License

SwiftyDevice is available under the MIT license. See the LICENSE file for more info.
