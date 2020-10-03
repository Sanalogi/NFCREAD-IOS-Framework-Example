//
//  MrzResultController.swift
//  ReaderExample
//
//  Created by Faruk on 2.10.2020.
//  Copyright © 2020 Sanalogi. All rights reserved.
//

import UIKit
import SanalogiReader

class MrzResultController: UIViewController {

    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var docNo: UILabel!
    @IBOutlet weak var countryCode: UILabel!
    
    var scanResult:MrzScanResult!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameSurname.text = scanResult.givenNames + " " + scanResult.surnames
        docNo.text = scanResult.documentNumber
        countryCode.text = scanResult.countryCode
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
