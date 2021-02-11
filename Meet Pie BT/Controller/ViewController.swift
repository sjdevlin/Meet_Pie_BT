//
//  ViewController.swift
//  Meet Pie BT
//
//  Created by Stephen Devlin on 09/02/2021.
//
import UIKit
import Charts

class ViewController: UIViewController {

    var bData : BTData!
    @IBOutlet weak var meetingTimeLabel: UILabel!
    @IBOutlet weak var MeetTableView: UITableView!

    var blueTableData : [MessageStructure.Main] = [
        MessageStructure.Main(memNum: 0,angle: 0,talking: 0,numTurns: 0, freq: 0, totalTalk: 0),
        MessageStructure.Main(memNum: 0,angle: 0,talking: 0,numTurns: 0, freq: 0,totalTalk: 0),
        MessageStructure.Main(memNum: 0,angle: 0,talking: 0,numTurns: 0, freq: 0,totalTalk: 0),
        MessageStructure.Main(memNum: 0,angle: 0,talking: 0,numTurns: 0, freq: 0, totalTalk: 0),
        MessageStructure.Main(memNum: 0,angle: 0,talking: 0,numTurns: 0, freq: 0,totalTalk: 0),
        MessageStructure.Main(memNum: 0,angle: 0,talking: 0,numTurns: 0, freq: 0,totalTalk: 0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bData = BTData()
        bData.delegate = self

        MeetTableView.delegate = self
        MeetTableView.dataSource = self

        // register the custom cell we created for the table
        
        MeetTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
    }
}
    extension ViewController: MessageModelDelegate {

        func dataReceived(Message: MessageStructure) {


            // hide the activity monitor?
            // or message saying waiting for message

            // this where we update the chart
            
            meetingTimeLabel.text = String(Message.totalMeetingTime)
            
            for index in 0..<Message.message.count {
                blueTableData[index].memNum = Message.message[index].memNum
                blueTableData[index].angle = Message.message[index].angle
                blueTableData[index].talking = Message.message[index].talking
                blueTableData[index].freq = Message.message[index].freq
                blueTableData[index].numTurns = Message.message[index].numTurns
                blueTableData[index].totalTalk = Message.message[index].totalTalk

        }
      DispatchQueue.main.async {
           self.MeetTableView.reloadData()

      }

    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blueTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! BlueCell
        cell.cellMemNum.text = String(blueTableData[indexPath.row].memNum)
        cell.cellAngle.text = String(blueTableData[indexPath.row].angle)
        cell.cellTalking.text = String(blueTableData[indexPath.row].talking)
        cell.cellNumTurns.text = String(blueTableData[indexPath.row].numTurns)
        cell.cellFreq.text = String(blueTableData[indexPath.row].freq)
        cell.cellTotalTalk.text = String(blueTableData[indexPath.row].totalTalk)
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
    }
    }
