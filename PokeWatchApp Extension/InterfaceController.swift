//
//  InterfaceController.swift
//  PokeWatchApp Extension
//
//  Created by Marco Vergaray Guerra on 7/19/16.
//  Copyright © 2016 Marco Vergaray Guerra. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var imgr: WKInterfaceImage!
    
    @IBOutlet var imgo: WKInterfaceImage!
    var session: WCSession!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if (WCSession.isSupported()) {
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func sendMessage() {
        if (WCSession.isSupported()) {
            session.sendMessage(["b":"Bye"], replyHandler: nil, errorHandler: nil)
        }
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        guard let imager = UIImage(data: (message["rival"]! as? NSData)!) else {
            return
        }
        guard let imageo = UIImage(data: (message["own"]! as? NSData)!) else {
            return
        }
        
        // throw to the main queue to upate properly
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            // update your UI here
            self!.imgr.setImage(imager)
            self!.imgo.setImage(imageo)
        }

    }
}
