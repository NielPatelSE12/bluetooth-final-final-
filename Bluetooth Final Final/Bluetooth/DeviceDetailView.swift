//
//  DeviceDetailView.swift
//  Bluetooth Final Final
//
//  Created by Niel Patel on 2/21/25.
//

import SwiftUI
import MapKit

struct DeviceDetailView: View {
    let device: DiscoveredDevice
    
    // To control the visible region of the map
    @State private var region: MKCoordinateRegion
    
    init(device: DiscoveredDevice) {
        self.device = device
        _region = State(initialValue: MKCoordinateRegion(
            center: device.location,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(device.name)
                .font(.largeTitle)
                .padding(.top)
            
            Text("Identifier: \(device.identifier)")
                .font(.body)
            
            Text("RSSI: \(device.rssi)")
                .font(.body)
            
            Divider()
            
            Text("Location on Map")
                .font(.headline)
            
            Map(coordinateRegion: $region, annotationItems: [device]) { item in
                MapMarker(coordinate: item.location, tint: .blue)
            }
            .frame(height: 300)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Device Details")
    }
}
