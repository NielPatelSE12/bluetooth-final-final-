import SwiftUI

struct ContentView: View {
    @ObservedObject var bluetoothManager = BluetoothManager()

    var body: some View {
        NavigationView {
            List(bluetoothManager.discoveredDevices) { device in
                NavigationLink(destination: DeviceDetailView(device: device)) {
                    VStack(alignment: .leading) {
                        Text(device.name)
                            .font(.headline)
                        Text("RSSI: \(device.rssi)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Bluetooth Devices")
            .onAppear {
                bluetoothManager.startScanning()
            }
            .onDisappear {
                bluetoothManager.stopScanning()
            }
        }
    }
}

