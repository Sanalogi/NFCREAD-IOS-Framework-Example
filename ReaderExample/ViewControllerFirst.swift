//
//  ViewControllerFirst.swift
//  ApplicationTest
//
//  Created by Abbas amini on 5/25/22.
//  Copyright © 2022 Can Samet KATKAT. All rights reserved.
//

import UIKit
import SanalogiReader


class ViewControllerFirst: UIViewController ,NFCReaderDelegate  {
    var passportmode = false

    func resultScanner(didFind result: MrzScanResult) {
        imgFace.image = nil
        imgSign.image = nil
        imgFlag.image = nil
        imgGhost.image = nil
        imgChipset.image = nil
        imgBarcode.image = nil
        imgBack.image = nil
        imgFront.image = nil
        imgHologram.image = nil
        btnNfcOut.isHidden = false
        imgFace.image = result.faceFrontImage
        imgSign.image = result.signImage
        imgFlag.image = result.flagImage
        imgGhost.image = result.ghostImage
        imgChipset.image = result.upperChipset
        imgBarcode.image = result.barCode
        imgBack.image = result.backCard
        imgFront.image = result.frontCard
        imgHologram.image = result.hologram
        let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "MM-dd-yyyy"
             let birthDate = dateFormatter.string(from: result.birthDate ?? Date())
             let expDate = dateFormatter.string(from: result.expiryDate ?? Date())
             
             
             var str = ""
             str += "Ad: " + result.givenNames + "\n"
             str += "Soyad: " + result.surnames + "\n"
             str += "mrz: " + result.mrzString + "\n"
             str += "docNumber: " + result.documentNumber + "\n"
             str += "birthDate: " + birthDate + "\n"
             
             str += "countryCode: " + result.countryCode + "\n"
             str += "docType: " + result.documentType + "\n"
             str += "Nationality: " + result.nationality + "\n"
             str += "expDate: " + expDate + "\n"
             
        textResult.text = str
        navigationController?.popViewController(animated: true)
    }
    
    func resultPassportData(didFind result: MrzScanPassportResult) {
        btnNfcOut.isHidden = false

        let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "MM-dd-yyyy"
             let birthDate = dateFormatter.string(from: result.birthDate ?? Date())
             let expDate = dateFormatter.string(from: result.expiryDate ?? Date())
             
             
             var str = ""
             str += "Ad: " + result.givenNames + "\n"
             str += "Soyad: " + result.surnames + "\n"
             str += "mrz: " + result.mrzString + "\n"
             str += "docNumber: " + result.documentNumber + "\n"
             str += "birthDate: " + birthDate + "\n"
             
             str += "countryCode: " + result.countryCode + "\n"
             str += "docType: " + result.documentType + "\n"
             str += "Nationality: " + result.nationality + "\n"
             str += "expDate: " + expDate + "\n"
             
        textResult.text = str
        imgFront.image = result.documentImage
    }
    
    @available(iOS 13, *)
    func didSuccess(data: DocumentModel) {
        var str = ""
               str += "Soyad: " + data.lastName + "\n"
               str += "Ad: " + data.firstName + "\n"
               str += "docType: " + data.documentType + "\n"
               str += "personalNo: " + data.personalNumber + "\n"
               str += "DocNo: " + data.documentNumber + "\n"
               str += "issuingAuthority: " + data.issuingAuthority + "\n"
               str += "docExpDate: " + data.documentExpiryDate + "\n"
        str += "DateOfBirth: " + data.dateOfBirth! + "\n"
               str += "Gender: " + data.gender + "\n"
               str += "Nationality: " + data.nationality + "\n"
               str += "issueDate: " + (data.issueDate ?? "") + "\n"
               str += "placeBirth: " + (data.placeOfBirth ?? "") + "\n"
               str += "Address: " + (data.address ?? "") + "\n"
               str += "Telephone: " + (data.telephone ?? "") + "\n"
               str += "Profession: " + (data.profession ?? "") + "\n"
               str += "NFC READ COMPLETED!"
        imgFace.image = data.passportImage
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.textResult.text = str

        }
    }
    
    @IBAction func btnReadNFC(_ sender: Any) {
        if #available(iOS 13, *) {
            NFCReader.sharedInstance.readChip()
        } else {
            // Fallback on earlier versions
        }
    }
    func didFail(message: String) {
        
    }
    
    @IBOutlet weak var imgFace: UIImageView!
    
    @IBAction func swMode(_ sender: Any) {
        if ((sender as AnyObject).isOn == true) {
                btnScanOut.setTitle("Scan Passport", for: .normal)
                passportmode = true
           }else{
               passportmode = false
               btnScanOut.setTitle("Scan Kimlik", for: .normal)
        }
    }
    @IBOutlet weak var textResult: UITextView!
    @IBOutlet weak var imgBarcode: UIImageView!
   
    @IBOutlet weak var btnNfcOut: UIButton!
    @IBOutlet weak var btnScanOut: UIButton!
    @IBOutlet weak var textMRZ: UITextView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgFront: UIImageView!
    @IBOutlet weak var imgChipset: UIImageView!
    @IBOutlet weak var imgBracode: UIImageView!
    @IBOutlet weak var imgHologram: UIImageView!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var imgGhost: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var imgSign: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NFCReader.sharedInstance.delegate = self
        btnNfcOut.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func btnOPen(_ sender: Any) {
        imgFace.image = nil
        imgFront.image = nil
        imgBack.image = nil
        imgSign.image = nil
        imgGhost.image = nil
        imgFlag.image = nil
        imgHologram.image = nil
        imgBarcode.image = nil
        imgChipset.image = nil
        NFCReader.sharedInstance.passportMode = passportmode
   
        NFCReader.sharedInstance.showScannerView()
    }
    
    override func viewWillLayoutSubviews(){
    super.viewWillLayoutSubviews()
        scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1200)
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1200)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
