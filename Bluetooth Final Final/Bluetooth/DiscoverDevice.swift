//
//  DiscoverDevice.swift
//  Bluetooth Final Final
//
//  Created by Niel Patel on 2/21/25.
//

import CoreLocation

struct DiscoveredDevice: Identifiable {
    let id = UUID()
    let name: String
    let identifier: UUID
    let rssi: Int
    let location: CLLocationCoordinate2D
}
