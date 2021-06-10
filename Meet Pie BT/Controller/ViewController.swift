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
        MessageStructure.Main(mN: 0,a: 0,t: 0,nT: 0, f: 0, tT: 0),
        MessageStructure.Main(mN: 0,a: 0,t: 0,nT: 0, f: 0,tT: 0),
        MessageStructure.Main(mN: 0,a: 0,t: 0,nT: 0, f: 0,tT: 0),
        MessageStructure.Main(mN: 0,a: 0,t: 0,nT: 0, f: 0, tT: 0),
        MessageStructure.Main(mN: 0,a: 0,t: 0,nT: 0, f: 0,tT: 0),
        MessageStructure.Main(mN: 0,a: 0,t: 0,nT: 0, f: 0,tT: 0)
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
            
            meetingTimeLabel.text = String(Message.tMT)
            
            for index in 0..<Message.m.count {
                blueTableData[index].mN = Message.m[index].mN
                blueTableData[index].a = Message.m[index].a
                blueTableData[index].t = Message.m[index].t
                blueTableData[index].f = Message.m[index].f
                blueTableData[index].nT = Message.m[index].nT
                blueTableData[index].tT = Message.m[index].tT

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
        cell.cellMemNum.text = String(blueTableData[indexPath.row].mN)
        cell.cellAngle.text = String(blueTableData[indexPath.row].a)
        cell.cellTalking.text = String(blueTableData[indexPath.row].t)
        cell.cellNumTurns.text = String(blueTableData[indexPath.row].nT)
        cell.cellFreq.text = String(blueTableData[indexPath.row].f)
        cell.cellTotalTalk.text = String(blueTableData[indexPath.row].tT)
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
    }
    }
