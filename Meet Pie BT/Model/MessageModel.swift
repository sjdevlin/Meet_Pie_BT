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
    // make sure delegate for received data is there
    weak var delegate: MessageModelDelegate?
    
    override init(){
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
//            central.scanForPeripherals(withServices: , options: nil)
        }
        else {
            print("Something wrong with BLE")
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
                print("\(characteristic.uuid): has notify")
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case K.MeetPieDataCBUUID:
   //         peripheral.readValue(for: characteristic)
            let chardata = characteristic.value!
            print ("char data:")
//            print (chardata)
            //let ASCIIstring = NSString(data: chardata, encoding: String.Encoding.utf8.rawValue)
            let str = String(decoding: characteristic.value!, as: UTF8.self)
            print (str)
            let decoder = JSONDecoder()
            
            do{
                let decodedData = try decoder.decode(MessageStructure.self, from: chardata)
//                meetingData.timeStamp = decodedData.timeStamp
                meetingData.tMT = decodedData.tMT
                for index in 0..<decodedData.m.count {
                    if index + 1 > meetingData.m.count {
                        meetingData.m.append(MessageStructure.Main())
                    }
                    meetingData.m[index].mN = decodedData.m[index].mN
                    meetingData.m[index].a = decodedData.m[index].a
                    meetingData.m[index].t = decodedData.m[index].t
                    meetingData.m[index].nT = decodedData.m[index].nT
                    meetingData.m[index].f = decodedData.m[index].f
                    meetingData.m[index].tT = decodedData.m[index].tT
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

