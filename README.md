# NFCREAD FRAMEWORK SAMPLE PROJECT!
-Please Visit More Details | Github; https://github.com/Sanalogi/NFCREAD-IOS-Framework-Example

NFC Read is a tool designed for reading and verifying the official documents such as identity cards or passports. An example use case can be a police officer performing ID checks on the street, where NFC Read can be used with ease via an Android or an IOS smartphone to scan and verify the presented official document. The application does not require any specialised equipment or additional training.

- There is no additional training required for the personal to detect the fraudulent identity cards.

- It is a mobile solution that does not require any specialised hardware.

- No manual data entries are required: NFC Read automatically creates entries for data without any errors.

- A face match is automatically performed by obtaining the high resolution biometric image stored inside the NFC chip of the identity document

## Installation of the Framework

```
DO NOT FORGET
NFC operation works on devices with iOS13 and higher
OCR scanning works iOS11 and higher versions
Project deployment version must be iOS11 or higher
```

## 1: Add frameworks to your project

```
You can download framework files from: https://login.nfcread.com/files/V1-1-8-SanalogiReader.zip and 
https://login.nfcread.com/files/SideFrameworks.zip
Extract zips and embed&sign below frameworks

1. SanalogiReader.xcframework 
2. ACSSmartCardIO.xcframework
3. SmartCardIO.xcframework
4. Libtesseract.xcframework
```

```
Go to "General -> Frameworks, Libraries and Embedded Content" and make the added frameworks "Embed & Sign"

Be sure that when adding frameworks: General->Frameworks,Libraries and Embedded content
```

## 2: Simply add the following line to your Podfile:

```ruby
pod 'OpenSSL-Universal/Framework'
```

## 3: Permissions

```xml
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
<string>A0000002471001</string>
<string>00000000000000</string>
</array>

<key>NSCameraUsageDescription</key>
<string> We need to access camera.</string>
	
<key>NFCReaderUsageDescription</key>
<string> We need to access NFC for scan passport.</string>
	
<key>NSBluetoothPeripheralUsageDescription</key>
<string>$(PRODUCT_NAME) would like to use Bluetooth to connect NFC readers.</string>
	
<key>NSBluetoothAlwaysUsageDescription</key>
<string>$(PRODUCT_NAME) would like to use Bluetooth to connect NFC readers.</string>
 
```
## 4: You must add the api key to the plist.([How can i get licence key?](https://nfcread.com))

```xml
  <key>SanalogiReaderToken</key>
  <string>LICENCEKEY</string>
```

## 5: Include NFC in your project
Select "Signing & Capabilities -> Capability-> Near Field Communication Tag Reading" and then remove the first item from the "entitlements" file created under the project.
```
DELETE “Item 0 (Near Field Communication Tag Reading Session Format) - NFC Data Exchange Format “
```
Only the item listed below should remain.
```
Item 1 (Near Field Communication Tag Reading Session Format) - NFC tag-specific data protocol

After doing that open entitlement as source code and add this line <string>NDEF</string> after <string>TAG</string> line.
```

## 6: To read from the camera

```
1. Create a viewcontroller in the storyboard and add a view inside
2. Write "MrzScannerView" in the Class field in the Custom Class part of the View and "SanalogiReader" in the Module.
3. Cover the page by giving constraits.
```
You can review the sample code for the controls.
```swift
import UIKit
import SanalogiReader

class MrzController: UIViewController,NFCReaderDelegate {
    
    func resultScanner(didFind result: MrzScanResult) {
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
         NFCReader.sharedInstance.delegate = self

        NFCReader.sharedInstance.description = "NFCREAD-CameraScan"
	//NFCReader.sharedInstance.lang = "tr" or
	//NFCReader.sharedInstance.lang = "en" default tr
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
     @IBAction func btnOPen(_ sender: Any) {
        NFCReader.sharedInstance.passportMode = passportmode
        NFCReader.sharedInstance.showScannerView()
    }
    
     
}

```
## 7: To read from the NFC

You can review the sample code to start reading from NFC.

Getting image from iPad with external card reader can take time you can enable or disable to get image from iPad before readChip

```swift
    NFCReader.sharedInstance.getImageFromIpad = true//false
```
```swift
import UIKit
#if canImport(CoreNFC)
import SanalogiReader
#endif

@available(iOS 13, *)

class ViewController: UIViewController,NFCReaderDelegate {
    func didSuccess(data: DocumentModel) {
        //print(data.lastName)
        //print(data.firstName)
        
    }
    
    func didFail(message: String) {
        //print(message)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NFCReader.sharedInstance.delegate = self
    }

    @IBAction func scan(_ sender: Any) {
        
	//start nfc reading
        NFCReader.sharedInstance.readChip()
    }
    
}

```
## 8. Add RunScript To BuildPhase
```
rm -rf "$(find $CODESIGNING_FOLDER_PATH -name 'libtesseract.framework')"
```

## For ENABLE_BITCODE issue

```
Build Settings (All selected) -> Enable Bitcode = no
```

OCR ID Card Result Model

```swift
public class MrzScanResult {
     public let documentImage: UIImage
    public let signImage: UIImage
    public let ghostImage: UIImage
    public let flagImage: UIImage
    public let faceFrontImage: UIImage
    public let frontCard: UIImage
    public let upperChipset:UIImage
    public let backCard: UIImage
    public let barCode: UIImage
    public let hologram: UIImage
    public let documentType: String
    public let countryCode: String
    public let surnames: String
    public let givenNames: String
    public let documentNumber: String
    public let nationality: String
    public let birthDate: Date?
    public let sex: String?
    public let expiryDate: Date?
    public let personalNumber: String
    public let personalNumber2: String?
    public let mrzString: String
}
```

OCR Passport Result Model
```swift
    public let documentImage: UIImage
    public let documentType: String
    public let countryCode: String
    public let surnames: String
    public let givenNames: String
    public let documentNumber: String
    public let nationality: String
    public let birthDate: Date?
    public let sex: String?
    public let expiryDate: Date?
    public let personalNumber: String
    public let personalNumber2: String?
    public let mrzString: String
```

NFC Scan result Model
```swift
public class DocumentModel{
    public private(set) lazy var documentType : String =
    public private(set) lazy var documentSubType : String
    public private(set) lazy var personalNumber : String
    public private(set) lazy var documentNumber : String
    public private(set) lazy var issuingAuthority : String
    public private(set) lazy var documentExpiryDate : String
    public private(set) lazy var dateOfBirth : String
    public private(set) lazy var gender : String
    public private(set) lazy var nationality : String
    public lazy var lastName : String
    public lazy var firstName : String
    public var passportImage : UIImage
    public var issueDate:String?
    public var placeOfBirth:String?
    public var address:String?    
    public var telephone:String? 
    public var profession:String? 
}
```
