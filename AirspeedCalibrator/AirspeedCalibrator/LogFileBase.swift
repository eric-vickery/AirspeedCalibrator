//
//  LogFileBase.swift
//  AirspeedCalibrator
//
//  Created by Eric Vickery on 11/30/21.
//

import Foundation

class LogFileBase: ObservableObject {
    @Published var logFileType:String = "Unknown"
    @Published var maxAltitude:Int = 0
    @Published var maxGroundSpeed:Float = 0.0
    @Published var maxIndicatedAirSpeed:Float = 0.0
    @Published var maxTrueAirSpeed:Int = 0
    @Published var maxWindSpeed:Float = 0.0
    
    static func loadLogFile(logFile:String) -> LogFileBase
    {
        var logReader = LogFileBase()
        
        do {
            let logFileURL = URL(fileURLWithPath: logFile)
            let fileContents = try String(contentsOf: logFileURL)
            
            logReader = getCorrectLogReader(fileContents)
            
            return logReader
        }
        catch {
            print("Error loading log file")
            print(error)
            // Return an empty LogFileBase
            return logReader
        }
    }
    
    static func getCorrectLogReader(_ fileContents:String) -> LogFileBase
    {
        var logReader = LogFileBase()
        
        // Check to see if it is Garmin
        if GarminLogReader.isGarminLogFile(fileContents: fileContents)
        {
            logReader = GarminLogReader()
            logReader.logFileType = "Garmin"
            if !logReader.loadData(fileContents)
            {
                print("Did not load contents")
            }
        }
        
        return logReader
    }
    
    func loadData(_ fileContents:String) -> Bool
    {
        return false
    }
    
    func loadFile(_ logFile:URL?) -> Bool
    {
        return false
    }
}
