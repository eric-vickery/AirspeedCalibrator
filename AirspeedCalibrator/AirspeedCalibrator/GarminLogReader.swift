//
//  GarminLogReader.swift
//  AirspeedCalibrator
//
//  Created by Eric Vickery on 11/30/21.
//

import Foundation

class GarminLogReader: LogFileBase {
    var logLines = [LogLine]()
    
    static func isGarminLogFile(fileContents:String) -> Bool
    {
        if fileContents.starts(with: "#airframe_info,log_version=\"1.00\"")
        {
            return true
        }
        
        return false
    }
    
    override func loadData(_ fileContents:String) -> Bool
    {
        let lines = splitLines(fileContents)
        logLines = splitColumns(lines)
        return true
    }
    

    override func loadFile(_ logFile: URL?) -> Bool
    {
        do {
            if let logFile = logFile
            {
                let fileContents = try String(contentsOf: logFile)
                let lines = splitLines(fileContents)
                logLines = splitColumns(lines)
            }
            
            return true
        }
        catch {
            print("Error loading log file")
            print(error)
            // Return an empty LogFileBase
            return false
        }
    }
    
    func splitLines(_ fileContents:String) -> [String]
    {
        var outputLines = [String]()
        
        let lines = fileContents.split(separator: "\n")
        for line in lines
        {
            if !line.starts(with: "2")
            {
                continue
            }
            outputLines.append(String(line))
        }
        return outputLines
    }
    
    func splitColumns(_ lines:[String]) -> [LogLine]
    {
        var outputColumns = [LogLine]()
        
        for line in lines
        {
            let logLine = LogLine()
            
            let columns = line.split(separator: ",", omittingEmptySubsequences: false)
            for (columnNumber, column) in columns.enumerated()
            {
                if !logLine.setField(num: columnNumber, value: String(column))
                {
                    break
                }
            }
            maxAltitude = max(maxAltitude, logLine.altitudeIndicated)
            maxWindSpeed = max(maxWindSpeed, logLine.windSpeed)
            maxGroundSpeed = max(maxGroundSpeed, logLine.groundSpeed)
            maxTrueAirSpeed = max(maxTrueAirSpeed, logLine.trueAirspeed)
            maxIndicatedAirSpeed = max(maxIndicatedAirSpeed, logLine.indicatedAirspeed)
            
            outputColumns.append(logLine)
        }
        
        return outputColumns
    }
}

class LogLine
{
    var localDate:String = ""
    var localTime:String = ""
    var UTCTime:String = ""
    var UTCOffest:String = ""
    var latitude:String = ""
    var longitude:String = ""
    var altitudeGPS:Int = 0
    var GPSFix:String = ""
    var GPS_TOW:String = ""
    var groundSpeed:Float = 0.0
    var track:Int = 0
    var heading:Float = 0.0
    var GPSSats:Int = 0
    var altitudePressure:Int = 0
    var altitudeIndicated:Int = 0
    var verticalSpeed:Int = 0
    var indicatedAirspeed:Float = 0.0
    var trueAirspeed:Int = 0
    var pitch:Float = 0.0
    var roll:Float = 0.0
    var lateralAccel:Float = 0.0
    var normalAccel:Float = 0.0
    var selectedHeading:Int = 0
    var selectedAltitude:Int = 0
    var selectedVerticalSpeed:Int = 0
    var selectedIndicatedAirspeed:Int = 0
    var barometricPressure:Float = 0.0
    var magneticVariation:Float = 0.0
    var outsideAirTemp:Float = 0.0
    var densityAltitude:Int = 0
    var AGL:Int = 0
    var windSpeed:Float = 0.0
    var windDirection:Int = 0
    
    func setField(num:Int, value:String) -> Bool
    {
        // CHeck for blank lines and just return
        if num < 64 && value.isEmpty
        {
            return true
        }
        
        switch(num)
        {
        case 0:
            localDate = value

        case 1:
            localTime = value
            
        case 2:
            UTCTime = value
            
        case 3:
            UTCOffest = value
            
        case 4:
            latitude = value
            
        case 5:
            longitude = value
            
        case 6:
            guard let intValue = Int(value) else
            {
                print("Could not convert GPS altitude")
                return true
            }
            altitudeGPS = intValue

        case 7:
            GPSFix = value
            
        case 8:
            GPS_TOW = value
            
        case 9:
            guard let floatValue = Float(value) else
            {
                print("Could not convert ground speed")
                return true
            }
            groundSpeed = floatValue
            
        case 10:
            guard let intValue = Int(value) else
            {
                print("Could not convert track")
                return true
            }
            track = intValue
            
        case 11:
            break

        case 12:
            break
            
        case 13:
            break
            
        case 14:
            guard let floatValue = Float(value) else
            {
                print("Could not convert heading")
                return true
            }
            heading = floatValue
            
        case 15:
            break
            
        case 16:
            guard let intValue = Int(value) else
            {
                print("Could not convert number of GPS sats")
                return true
            }
            GPSSats = intValue
            
        case 17:
            guard let intValue = Int(value) else
            {
                print("Could not convert pressure altitude")
                return true
            }
            altitudePressure = intValue
            
        case 18:
            guard let intValue = Int(value) else
            {
                print("Could not convert indicated altitude")
                return true
            }
            altitudeIndicated = intValue
            
        case 19:
            guard let intValue = Int(value) else
            {
                print("Could not convert vertical speed")
                return true
            }
            verticalSpeed = intValue
            
        case 20:
            guard let floatValue = Float(value) else
            {
                print("Could not convert indicated airspeed")
                return true
            }
            indicatedAirspeed = floatValue
            
        case 21:
            guard let intValue = Int(value) else
            {
                print("Could not convert true airspeed")
                return true
            }
            trueAirspeed = intValue
            
        case 22:
            guard let floatValue = Float(value) else
            {
                print("Could not convert pitch")
                return true
            }
            pitch = floatValue
            
        case 23:
            guard let floatValue = Float(value) else
            {
                print("Could not convert roll")
                return true
            }
            roll = floatValue
            
        case 24:
            guard let floatValue = Float(value) else
            {
                print("Could not convert lateral acceleration")
                return true
            }
            lateralAccel = floatValue
            
        case 25:
            guard let floatValue = Float(value) else
            {
                print("Could not convert normal acceleration")
                return true
            }
            normalAccel = floatValue
            
        case 26:
            guard let intValue = Int(value) else
            {
                print("Could not convert selected heading")
                return true
            }
            selectedHeading = intValue
            
        case 27:
            guard let intValue = Int(value) else
            {
                print("Could not convert selected altitude")
                return true
            }
            selectedAltitude = intValue
            
        case 28:
            guard let intValue = Int(value) else
            {
                print("Could not convert selected vertical speed")
                return true
            }
            selectedVerticalSpeed = intValue
            
        case 29:
            guard let intValue = Int(value) else
            {
                print("Could not convert selected indicated airspeed")
                return true
            }
            selectedIndicatedAirspeed = intValue
            
        case 30:
            guard let floatValue = Float(value) else
            {
                print("Could not convert barometric pressure")
                return true
            }
            barometricPressure = floatValue

        case 58:
            guard let floatValue = Float(value) else
            {
                print("Could not convert magnetic variation")
                return true
            }
            magneticVariation = floatValue
            
        case 59:
            guard let floatValue = Float(value) else
            {
                print("Could not convert outside air temperature")
                return true
            }
            outsideAirTemp = floatValue
            
        case 60:
            guard let intValue = Int(value) else
            {
                print("Could not convert density altitude")
                return true
            }
            densityAltitude = intValue
            
        case 61:
            guard let intValue = Int(value) else
            {
                print("Could not convert AGL")
                return true
            }
            AGL = intValue
            
        case 62:
            guard let floatValue = Float(value) else
            {
                print("Could not convert wind speed")
                return true
            }
            windSpeed = floatValue
            
        case 63:
            guard let intValue = Int(value) else
            {
                print("Could not convert wind direction")
                return true
            }
            windDirection = intValue
            
        case 64:
            return false
            
        default:
            return true
        }

        return true
    }
}
