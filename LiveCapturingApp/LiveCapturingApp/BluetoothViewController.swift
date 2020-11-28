//
//  BluetoothViewController.swift
//  LiveCapturingApp
//
//  Created by A on 2020/10/25.
//

import UIKit
import CoreBluetooth
import Firebase
import FirebaseDatabase

struct BTConstants {
    // These are sample GATT service strings. Your accessory will need to include these services/characteristics in its GATT database
    static let sampleServiceUUID = CBUUID(string: "AAAA")
    static let sampleCharacteristicUUID = CBUUID(string: "BBBB")
}

class BluetoothViewController: UIViewController {
    var isTouched = true
    @IBAction func touchedButton(_ sender: UIButton) {
        isTouched = !isTouched
        let ref = Database.database().reference()
        let post : [String: String] = ["state": "on"]
        let post2: [String: String] = ["state": "off"]
        if isTouched {
            ref.child("led").setValue(post)
        } else {
            ref.child("led").setValue(post2)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var items = [String: [String: Any]]()
    
    var devices: Dictionary<String, CBPeripheral> = [:]
    var centralManager: CBCentralManager? // central
    var connectedDevice: CBPeripheral!
    private var txCharateristic: CBCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BluetoothViewController: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
            print("Searching for BLE Devices")
            let matchingOptions = [CBConnectionEventMatchingOption.serviceUUIDs: [BTConstants.sampleServiceUUID]]
            centralManager?.registerForConnectionEvents(options: matchingOptions)
        } else {
            print("Bluetooth switch off")
        }
    }

    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = peripheral.name {
            if(devices[name] == nil) {
                devices[name] = peripheral
                self.tableView.reloadData()
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        centralManager?.stopScan()
        print("stop Scan ...!")
        print("\(peripheral)")
        peripheral.readRSSI()
        peripheral.discoverServices([CBUUID(string: "FFE0")])
        //peripheral.setNotifyValue(<#T##enabled: Bool##Bool#>, for: <#T##CBCharacteristic#>)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("연결에 실패! \(error)")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("disconnect \(error)")
    }
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        if let name = peripheral.name {
            items[name] = [
                "name": name,
                "rssi": RSSI
            ]
        }
        print("rssi: \(RSSI)")
//        self.connectedDevice.writeValue("hhhh".data(using: .utf8)!, for: CBCharacteristic.)
        tableView.reloadData()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("discoverServices,,!")
        print("\(peripheral.services?.first?.description)")
    }
    
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        switch event {
        case .peerConnected:
            if peripheral.name == "HMSoft" {
                print("Connecting to peripheral \(peripheral)")
                centralManager?.connect(peripheral, options: nil)
                self.connectedDevice = peripheral
                centralManager?.registerForConnectionEvents(options: nil)
                peripheral.delegate = self
            }
        default:
            print("nono")
        }
    }
    
    
    
    
}

extension BluetoothViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bluetoothCell", for: indexPath) as! BluetoothCell
        
        let discoverdPeripherals = Array(devices.values)
        
        if let name = discoverdPeripherals[indexPath.row].name {
            cell.signalLabel.text = name
        }
        
        if let uuid = discoverdPeripherals[indexPath.row].services?.first?.uuid {
            cell.UUIDLabel.text = uuid.uuidString
        }
        
        cell.layer.cornerRadius = 15
        return cell
    }
}
