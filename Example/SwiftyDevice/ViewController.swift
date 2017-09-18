//
//  ViewController.swift
//  SwiftyDevice
//
//  Created by legranddamien on 09/18/2017.
//  Copyright (c) 2017 legranddamien. All rights reserved.
//

import UIKit
import SwiftyDevice

extension Device : CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    
    public var description: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        var date = "unknown"
        if let d = self.releaseDate {
            date = formatter.string(from: d)
        }
        
        return "\(family.rawValue), release date: \(date)"
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(self.deviceView(Device.currentDevice, title: "Current Device"))
        
        for item in SwiftyDevice.shared.devices!.keys.sorted(by: >) {
            stackView.addArrangedSubview(self.deviceView(Device.device(with: item), title: item))
        }
    }
    
    private func deviceView(_ device: Device, title: String) -> UIView {
        
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0.0
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        view.addArrangedSubview(titleLabel)
        
        let textLabel = UILabel()
        textLabel.text = "\(device)"
        textLabel.font = UIFont.systemFont(ofSize: 17.0)
        textLabel.numberOfLines = 0
        view.addArrangedSubview(textLabel)
        
        return view
    }

}

