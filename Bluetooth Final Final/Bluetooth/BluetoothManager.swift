//
//  BluetoothManager.swift
//  Bluetooth Final Final
//
//  Created by Niel Patel on 2/21/25.
//

import Foundation
import CoreBluetooth
import Combine
import CoreLocation

class BluetoothManager: NSObject, ObservableObject {
    @Published var discoveredDevices: [DiscoveredDevice] = []
    
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        // Only start scanning if Bluetooth is powered on
        if centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func stopScanning() {
        centralManager.stopScan()
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // Check if Bluetooth is on. If yes, start scanning.
        if central.state == .poweredOn {
            startScanning()
        } else {
            // Handle other states: poweredOff, unauthorized, etc.
            stopScanning()
        }
    }
    
    // When a peripheral is discovered, create a DiscoveredDevice and add it to the list
    func centralManager(_ central: CBCentralManager,
                       didDiscover peripheral: CBPeripheral,
                       advertisementData: [String : Any],
                       rssi RSSI: NSNumber) {
        
        let deviceName = peripheral.name ?? "Unknown Device"
        let deviceIdentifier = peripheral.identifier
        let deviceRSSI = RSSI.intValue
        
        // For demonstration, using a static location (e.g., Apple Park).
        // Replace with real location data if you have it.
        let dummyLocation = CLLocationCoordinate2D(latitude: 37.334803, longitude: -122.008965)
        
        // Check if we already have this device
        if !discoveredDevices.contains(where: { $0.identifier == deviceIdentifier }) {
            let newDevice = DiscoveredDevice(
                name: deviceName,
                identifier: deviceIdentifier,
                rssi: deviceRSSI,
                location: dummyLocation
            )
            
            // Update discovered devices on the main thread
            DispatchQueue.main.async {
                self.discoveredDevices.append(newDevice)
            }
        }
    }
}
