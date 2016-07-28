//
//  ViewController.swift
//  TextToSpeechAppDemo
//
//  Created by Kamal Ahuja on 7/27/16.
//  Copyright © 2016 KamalAhuja. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    

    @IBOutlet weak var textReadButton: UIButton!
    @IBOutlet weak var textViewOutlet: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func submitYourTextTobeRead(sender: AnyObject) {
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [textViewOutlet.text], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceRect = self.textReadButton.frame
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

