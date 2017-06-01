//
//  ViewController.swift
//  PokeWatch
//
//  Created by Marco Vergaray Guerra on 7/19/16.
//  Copyright © 2016 Marco Vergaray Guerra. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    var session: WCSession!
    var pokeList: NSArray!
    var platList: NSArray!
    var rival: Int = 1
    var own: Int = 1
    var generation: Int = 0

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var sgmGeneration: UISegmentedControl!
    
    @IBOutlet weak var pkv1: UIPickerView!
    @IBOutlet weak var pkv2: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarDatosDesdeLocal()
        pokeList  = DataBase().ejecutarSelect("select * from poketable") as NSArray
        print("\(pokeList.count )");
        // Do any additional setup after loading the view, typically from a nib.
        if (WCSession.isSupported()) {
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sendMessage(sender: AnyObject) {
        if (session.reachable) {
            let rivalImg = UIImage(named: "gbc/\(rival)-\(sgmGeneration.selectedSegmentIndex+1).png")
            let ownImg = UIImage(named: "gbc/back/\(own)-\(sgmGeneration.selectedSegmentIndex+1)-b.png")
            let datar = UIImagePNGRepresentation(rivalImg!)
            let datao = UIImagePNGRepresentation(ownImg!)
            session.sendMessage(["rival":datar!, "own":datao!], replyHandler: nil, errorHandler: nil)
        } else {
            let alertController = UIAlertController(title: "Error", message:
                "Please, open Watch app", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        self.lblMessage.text = message["b"]! as? String
    }
    
    func cargarDatosDesdeLocal(){
        DataBase.checkAndCreateDatabase()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pokeList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var result = ""
        result = (pokeList[row]["nombre"] as? String)!
        return result
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if pkv1 == pickerView {
            own = row + 1
        } else {
            rival = row + 1
        }
    }
}

