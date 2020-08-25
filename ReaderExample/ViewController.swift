//
//  ViewController.swift
//  ReaderExample
//
//  Created by Can Samet KATKAT on 20.08.2020.
//  Copyright © 2020 Can Samet KATKAT. All rights reserved.
//

import UIKit
import SanalogiReader

class ViewController: UIViewController,NFCReaderDelegate {
    func didSuccess(data: DocumentModel) {
        print(data.lastName)
        print(data.firstName)
        
    }
    
    func didFail(message: String) {
        print(message)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NFCReader.sharedInstance.delegate = self
        
    }

    @IBAction func scan(_ sender: Any) {
        NFCReader.sharedInstance.readChip()
    }
    
}

