//
//  AirspeedCalibratorApp.swift
//  AirspeedCalibrator
//
//  Created by Eric Vickery on 11/29/21.
//

import SwiftUI

@main
struct AirspeedCalibratorApp: App {
    @StateObject private var logFile = LogFileBase.loadLogFile(logFile: "/Users/ericvickery/Downloads/log_test.csv")
//    @StateObject private var logFile:LogFileBase = GarminLogReader()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(logFile)
        }
    }
}
