# NFCREAD FRAMEWORK SAMPLE PROJECT!

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
1. SanalogiReader.xcframework 
2. ACSSmartCardIO.xcframework
3. SmartCardIO.xcframework
4. Libtesseract.xcframework
```

```
Go to "General -> Frameworks, Libraries and Embedded Content" and make the added frameworks "Embed & Sign"
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

class MrzController: UIViewController,MrzScannerViewDelegate {
    
    @IBOutlet weak var scannerView: MrzScannerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scannerView.delegate = self
        NFCReader.sharedInstance.description = "NFCREAD-CameraScan"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

   //Start scanning
        scannerView.startScanning()
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

	//Stop scanning
        scannerView.stopScanning()
    }

    func mrzScannerView(_ mrzScannerView: MrzScannerView, didFind scanResult: MrzScanResult) {
                //print(scanResult.surnames)
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
## For ENABLE_BITCODE issue

```
Build Settings (All selected) -> Enable Bitcode = no
```

OCR Result Model

```swift
public class MrzScanResult {
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
}
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
}
```