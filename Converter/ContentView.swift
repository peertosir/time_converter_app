//
//  ContentView.swift
//  Converter
//
//  Created by Ilya Danilov on 07.06.2020.
//  Copyright © 2020 Ilya Danilov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var unitsFrom = 0
    @State private var inputFrom = ""
    @State private var unitsFor = 1
    let units = ["seconds": 1.0, "minutes": 60.0, "hours": 3600.0, "days": 86400.0]
    var unitsKeyArray: [String] {
        return Array(units.keys).sorted()
    }
    
    var calculations: (userVal: Double, result: Double) {
        let userInput = Double(inputFrom) ?? 0
        let multiplier: Double! = units[unitsKeyArray[unitsFrom]]
        let divider: Double! = units[unitsKeyArray[unitsFor]]
        let secFromInput = userInput != 0.0 ? userInput * multiplier : 0
        let result = secFromInput / divider
        return (userVal: userInput, result: result)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Units from: ")) {

                    Picker("Pick units of time", selection: $unitsFrom) {
                        ForEach(0 ..< unitsKeyArray.count) {
                            Text("\(self.unitsKeyArray[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("Enter the value", text: $inputFrom)
                }
                Section(header: Text("Units for: ")) {

                    Picker("Pick units of time", selection: $unitsFor) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.unitsKeyArray[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Result:")) {
                    Text("\(calculations.userVal, specifier: "%.2f") \(unitsKeyArray[unitsFrom]) is \(calculations.result, specifier: "%.2f") \(unitsKeyArray[unitsFor])")
                  }
            }
        .navigationBarTitle("Time converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
