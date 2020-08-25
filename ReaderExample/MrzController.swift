//
//  MrzController.swift
//  ReaderExample
//
//  Created by Can Samet KATKAT on 20.08.2020.
//  Copyright © 2020 Can Samet KATKAT. All rights reserved.
//

import UIKit
import SanalogiReader

class MrzController: UIViewController,MrzScannerViewDelegate {
    
    @IBOutlet weak var scannerView: MrzScannerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scannerView.delegate = self
        NFCReader.sharedInstance.description = "NFCREAD-CameraScan"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scannerView.startScanning()
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        scannerView.stopScanning()
    }

    func mrzScannerView(_ mrzScannerView: MrzScannerView, didFind scanResult: MrzScanResult) {
         performSegue(withIdentifier: "segue1", sender: nil)
    }
     
}
