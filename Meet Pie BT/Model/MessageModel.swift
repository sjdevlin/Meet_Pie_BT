//
//  MessageModel.swift
//  Meet Pie BT
//
//  Created by Stephen Devlin on 09/02/2021.
//

import Foundation
import CoreBluetooth

protocol MessageModelDelegate: class {
    func dataReceived(Message: MessageStructure)
}


class BTData: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    var myPeripheral: CBPeripheral!
    var meetingData: MessageStructure = MessageStructure()
    // make sure delegate for receioved data is there
    weak var delegate: MessageModelDelegate?
    
    override init(){
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            print("BLE powered on")
            // Turned on
            central.scanForPeripherals(withServices: [K.MeetPieCBUUID], options: nil)
        }
        else {
            print("Something wrong with BLE")
            // Not on, but can have different issues
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let pname = peripheral.name {
            print (pname)
            if pname == K.BTServiceName {
                self.centralManager.stopScan()
                self.myPeripheral = peripheral
                self.myPeripheral.delegate = self
                self.centralManager.connect(peripheral, options: nil)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        peripheral.discoverServices([K.MeetPieCBUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid): properties contains .notify")
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case K.MeetPieDataNotifyCBUUID:
            let data = characteristic.value!
            let str = String(decoding: characteristic.value!, as: UTF8.self)
            print (str)
            let decoder = JSONDecoder()
            
            do{
                let decodedData = try decoder.decode(MessageStructure.self, from: data)
                meetingData.timeStamp = decodedData.timeStamp
                meetingData.totalMeetingTime = decodedData.totalMeetingTime
                for index in 0..<decodedData.message.count {
                    if index + 1 > meetingData.message.count {
                        meetingData.message.append(MessageStructure.Main())
                    }
                    meetingData.message[index].memNum = decodedData.message[index].memNum
                    meetingData.message[index].angle = decodedData.message[index].angle
                    meetingData.message[index].talking = decodedData.message[index].talking
                    meetingData.message[index].numTurns = decodedData.message[index].numTurns
                    meetingData.message[index].freq = decodedData.message[index].freq
                    meetingData.message[index].totalTalk = decodedData.message[index].totalTalk
                }
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            
            // end of decode
            // now call the delegate in the View Controller
            
            
            
            default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
        delegate?.dataReceived(Message: meetingData)

    }
    
}

