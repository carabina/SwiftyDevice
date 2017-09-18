//
//  main.swift
//  HardwareParser
//
//  Created by Damien Legrand on 18/08/2017.
//

import Foundation

guard let path = CommandLine.arguments.dropFirst().first else {
    print("No Path given")
    exit(EXIT_FAILURE)
}

let parser = HardwareParser(path: path)
parser.run()
