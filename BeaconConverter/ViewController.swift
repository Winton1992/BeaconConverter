//
//  ViewController.swift
//  BeaconConverter
//
//  Created by LIWEIJIE on 12/7/20.
//  Copyright © 2020 weijie. All rights reserved.
//

import CoreBluetooth
import CoreLocation
import UIKit

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    var beaconRegion: CLBeaconRegion!
    var peripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    
    let beaconUUID = "39ED98FF-2900-441A-802F-9C398FC199D3"
    let localBeaconMajor: CLBeaconMajorValue = 1
    let localBeaconMinor: CLBeaconMinorValue = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBeaconRegion()
    }
    
    func setupBeaconRegion() {
        let uuid = UUID(uuidString: beaconUUID)!
        beaconRegion = CLBeaconRegion(proximityUUID: uuid,
                                     major: localBeaconMajor,
                                     minor: localBeaconMinor,
                                     identifier: "com.winton.myDeviceRegion")

        peripheralData = beaconRegion.peripheralData(withMeasuredPower: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
    
    func stopLocalBeacon() {
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        peripheralData = nil
        beaconRegion = nil
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            peripheralManager.startAdvertising(peripheralData as? [String: Any])
        } else if peripheral.state == .poweredOff {
            peripheralManager.stopAdvertising()
        }
    }
}

