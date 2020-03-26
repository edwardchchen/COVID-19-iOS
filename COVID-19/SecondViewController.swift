//
//  SecondViewController.swift
//  COVID-19
//
//  Created by Edward Chen on 2020-03-12.
//  Copyright © 2020 Edward Chen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var howVirusSpreadLabel: UILabel!
    @IBOutlet weak var preventionLabel: UILabel!
    
    @IBOutlet weak var howVirusSpreadsTextView: UITextView!
    @IBOutlet weak var socialDIstaceTextView: UITextView!
    @IBOutlet weak var selfIsoLateTextView: UITextView!
    @IBOutlet weak var maskTextView: UITextView!
    @IBOutlet weak var hygieneTextView: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUp()
        
        
    }
    func setUp(){
        howVirusSpreadsTextView.text="1. Respiratory droplets generated when you cough or sneeze\n2. Close, prolonged personal contact, such as touching or shaking hands\n3. Touching something with the virus on it, then touching your mouth, nose or eyes before washing your hands"
        
        selfIsoLateTextView.text = "Self-monitor\nSelf-monitor:monitor yourself for 14 days for symptoms of respiratory illness, such as cough, fever and difficulty breathing avoid crowded places and increase your personal space from others whenever possible."
        
        socialDIstaceTextView.text="1. Avoiding crowded places and non-essential gatherings\n2. Avoiding common greetings, such as handshakes\n3. Limiting contact with people at higher risk like older adults and those in poor health\n4. Keeping a distance of at least 2 arms-length (approximately 2 metres) from others"
        
        hygieneTextView.text="1. Wash your hands often with soap and water for at least 20 seconds, especially after using the washroom and when preparing food\n2. Cough or sneeze into a tissue or the bend of your arm, not your hand"

    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
    }


}

