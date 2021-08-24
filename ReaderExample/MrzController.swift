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
        NFCReader.sharedInstance.lang = "tr"
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let birthDate = dateFormatter.string(from: scanResult.birthDate ?? Date())
        let expDate = dateFormatter.string(from: scanResult.expiryDate ?? Date())
        
        
        var str = ""
        str += "Ad: " + scanResult.givenNames + "\n"
        str += "Soyad: " + scanResult.surnames + "\n"
        str += "mrz: " + scanResult.mrzString + "\n"
        str += "docNumber: " + scanResult.documentNumber + "\n"
        str += "birthDate: " + birthDate + "\n"
        
        str += "countryCode: " + scanResult.countryCode + "\n"
        str += "docType: " + scanResult.documentType + "\n"
        str += "Nationality: " + scanResult.nationality + "\n"
        str += "expDate: " + expDate + "\n"
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let alert = UIAlertController(title: "Title", message: str, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK",
                            style: .default,
                            handler: { _ in
                                if #available(iOS 13, *){
                                    self.scanResult = scanResult
                                    self.performSegue(withIdentifier: "segueToNfcScan", sender: nil)
                                   
                                }
                                else{
                                    self.scanResult = scanResult
                                    self.performSegue(withIdentifier: "segueToMrzScan", sender: nil)
                                    
                                    print(scanResult.countryCode)
                                    print(scanResult.documentNumber)
                                    print(scanResult.givenNames)
                                }
                                
            }))
            self.present(alert, animated: true, completion: nil)
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
