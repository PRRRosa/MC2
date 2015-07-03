//
//  GlanceController.swift
//  amoebaProject WatchKit Extension
//
//  Created by Camilla Schmidt on 30/06/15.
//  Copyright (c) 2015 Paulo Ricardo Ramos da Rosa. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet weak var lblScore: WKInterfaceLabel!
    @IBOutlet weak var tinta: WKInterfaceGroup!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        tinta.setBackgroundImageNamed("Tinta_")
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        self.tinta.startAnimatingWithImagesInRange(NSMakeRange(0, 45), duration: 2, repeatCount: 1)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
