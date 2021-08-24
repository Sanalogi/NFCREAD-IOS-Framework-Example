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
        var str = ""
        str += "Soyad: " + data.lastName + "\n"
        str += "Ad: " + data.firstName + "\n"
        str += "docType: " + data.documentType + "\n"
        str += "personalNo: " + data.personalNumber + "\n"
        str += "DocNo: " + data.documentNumber + "\n"
        str += "issuingAuthority: " + data.issuingAuthority + "\n"
        str += "docExpDate: " + data.documentExpiryDate + "\n"
        str += "DateOfBirth: " + data.dateOfBirth + "\n"
        str += "Gender: " + data.gender + "\n"
        str += "Nationality: " + data.nationality + "\n"
        str += "issueDate: " + (data.issueDate ?? "") + "\n"
        str += "placeBirth: " + (data.placeOfBirth ?? "") + "\n"
        str += "Address: " + (data.address ?? "") + "\n"
        str += "Telephone: " + (data.telephone ?? "") + "\n"
        str += "Profession: " + (data.profession ?? "") + "\n"
        str += "NFC READ COMPLETED!"

        
//        nameSurname.text = data.firstName + data.lastName
//        docNo.text = data.documentNumber
//        countryCode.text = data.nationality
//        imgView.image = data.passportImage
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let alert = UIAlertController(title: "Title", message: str, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

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

