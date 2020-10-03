//
//  ViewController.swift
//  ReaderExample
//
//  Created by Sanalogi on 20.08.2020.
//  Copyright © 2020 Sanalogi. All rights reserved.
//

import UIKit
#if canImport(CoreNFC)
import SanalogiReader
#endif

@available(iOS 13, *)
class ViewController: UIViewController,NFCReaderDelegate {
    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var docNo: UILabel!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func didSuccess(data: DocumentModel) {
        
        print(data.lastName)
        print(data.firstName)
        nameSurname.text = data.firstName + data.lastName
        docNo.text = data.documentNumber
        countryCode.text = data.nationality
        imgView.image = data.passportImage
    }
    
    func didFail(message: String) {
        print(message)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NFCReader.sharedInstance.delegate = self
        NFCReader.sharedInstance.getImageFromIpad = true
        
    }

    @IBAction func scan(_ sender: Any) {
        NFCReader.sharedInstance.readChip()
    }
    
}

