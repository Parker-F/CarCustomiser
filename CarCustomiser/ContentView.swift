//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Parker, Fred (DMT) on 18/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet {
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var enginePackage = false
    @State private var gearsPackage = false
    @State private var remainingFunds = 1000
    
    var exhaustPackageEnabled: Bool {
        if exhaustPackage == false && remainingFunds < 500 {
            return false
        } else {
            return true
        }
    }
    var tiresPackageEnabled: Bool {
        if tiresPackage == false && remainingFunds < 500 {
            return false
        } else {
            return true
        }
    }
    var enginePackageEnabled: Bool {
        if enginePackage == false && remainingFunds < 1000 {
            return false
        } else {
            return true
        }
    }
    var gearsPackageEnabled: Bool {
        if gearsPackage == false && remainingFunds < 750 {
            return false
        } else {
            return true
        }
    }

    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get : { self.exhaustPackage },
            set : { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500

                }
            }
        )
        let tiresPackageBinding = Binding<Bool> (
            get : { self.tiresPackage },
            set : { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500

                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500

                }
            }
        )
        
        let enginePackageBinding = Binding<Bool> (
            get : { self.enginePackage },
            set : { newValue in
                self.enginePackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 10
                    starterCars.cars[selectedCar].acceleration -= 0.6
                    remainingFunds -= 1000

                } else {
                    starterCars.cars[selectedCar].topSpeed -= 10
                    starterCars.cars[selectedCar].acceleration += 0.6
                    remainingFunds += 1000

                }
            }
        )
        let gearsPackageBinding = Binding<Bool> (
            get : { self.gearsPackage },
            set : { newValue in
                self.gearsPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 1.2
                    remainingFunds -= 750
                } else {
                    starterCars.cars[selectedCar].acceleration += 1.2
                    remainingFunds += 750

                }
            }
        )
        VStack {
            Form {
                VStack(alignment: .leading, spacing: 20){
                    Text("\(StarterCars.cars[selectedCar].displayStats())")
                    Button("Random Car", action: {
                        selectedCar += 1
                        resetDisplay()
                    })
                }
                Section{
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(!exhaustPackageEnabled)
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(!tiresPackageEnabled)
                    Toggle("Engine Package (Cost: 1000)", isOn: enginePackageBinding)
                        .disabled(!enginePackageEnabled)
                    Toggle("Gears Package (Cost: 750)", isOn: gearsPackageBinding)                        .disabled(!gearsPackageEnabled)
                }
            }
            Text("Remaining Funds: \(remainingFunds)")
                .foregroundColor(.red)
                .baselineOffset(20)
            
        }
    }
    
    func resetDisplay() {
        
    }
}
 
#Preview {
    ContentView()
}
