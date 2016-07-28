//
//  ActionViewController.swift
//  TextToAudioExtension
//
//  Created by Kamal Ahuja on 7/27/16.
//  Copyright © 2016 KamalAhuja. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ActionViewController: UIViewController {
    @IBOutlet weak var textViewOutlet: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        var textFound : Bool = false;
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var i : Int = 0;
        for item: AnyObject in self.extensionContext!.inputItems {
            i+=1
            let inputItem = item as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePlainText as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    
                    itemProvider.loadItemForTypeIdentifier(kUTTypePlainText as String, options: nil, completionHandler: { (myText, error) in
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            if let testString : String = myText as? String {
                               self.textViewOutlet.text = testString
                                let speechSynthesizer = AVSpeechSynthesizer()
                                let speechUtterance = AVSpeechUtterance(string: testString)
                                speechUtterance.rate = 0.1
                                speechSynthesizer.speakUtterance(speechUtterance)
                            } else {
                               self.textViewOutlet.text = "Could Not Find String \(i)"
                            }
                        }
                    })
                    
                    textFound = true
                    break
                }
            }
            
            if (textFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }

}
