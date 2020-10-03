//
//  MrzController.swift
//  ReaderExample
//
//  Created by Sanalogi on 20.08.2020.
//  Copyright © 2020 Sanalogi. All rights reserved.
//

import UIKit
import SanalogiReader

@available(iOS 11.0, *)
class MrzController: UIViewController,MrzScannerViewDelegate {
    
    @IBOutlet weak var scannerView: MrzScannerView!
    var scanResult:MrzScanResult!

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

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func mrzScannerView(_ mrzScannerView: MrzScannerView, didFind scanResult: MrzScanResult) {
        if #available(iOS 13, *){
            self.performSegue(withIdentifier: "segueToNfcScan", sender: nil)
        }
        else{
            self.scanResult = scanResult
            self.performSegue(withIdentifier: "segueToMrzScan", sender: nil)
            
            print(scanResult.countryCode)
            print(scanResult.documentNumber)
            print(scanResult.givenNames)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMrzScan"{
            if let vc = segue.destination as? MrzResultController{
                vc.scanResult = self.scanResult
            }
        }
    }
}
