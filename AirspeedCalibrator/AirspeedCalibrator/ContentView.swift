//
//  ContentView.swift
//  AirspeedCalibrator
//
//  Created by Eric Vickery on 11/29/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var logData:LogFileBase
    
    var body: some View {
        VStack {
            HStack {
                Text("Log File Type")
                Text(logData.logFileType)
            }
                .padding(.bottom)
            Text("Max Values")
                .padding(.bottom)
            HStack {
                Text("Altitude")
                Text(String(logData.maxAltitude))
            }
            HStack {
                Text("Ground Speed")
                Text(String(logData.maxGroundSpeed))
            }
            HStack {
                Text("Wind Speed")
                Text(String(logData.maxWindSpeed))
            }
            HStack {
                Text("Indicated Airspeed")
                Text(String(logData.maxIndicatedAirSpeed))
            }
            HStack {
                Text("True Airspeed")
                Text(String(logData.maxTrueAirSpeed))
            }
            .padding(.bottom)
//            Button("Select Log File")
//            {
//                let panel = NSOpenPanel()
//                panel.allowsMultipleSelection = false
//                panel.canChooseDirectories = false
//                if panel.runModal() == .OK
//                {
//                    logData = LogFileBase.createReader(logFile: panel.url)
//                    _ = logData.loadFile(panel.url)
//                }
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LogFileBase())
    }
}
