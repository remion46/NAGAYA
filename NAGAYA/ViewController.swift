//
//  ViewController.swift
//  NAGAYA
//
//  Created by 船越廉 on 2021/02/11.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let welcomelabel = UILabel()
        welcomelabel.frame = CGRect(x: 0, y : self.view.frame.height/5, width: self.view.frame.width, height: self.view.frame.height/3)
        welcomelabel.text = "Welcome to"
          self.view.addSubview(welcomelabel)
        welcomelabel.textColor = UIColor.black
        welcomelabel.font = UIFont.systemFont(ofSize: 30)
        welcomelabel.textAlignment = NSTextAlignment.center
        
        let applabel = UILabel()
        applabel.frame = CGRect(x: 0, y : self.view.frame.height - self.view.frame.height/3, width: self.view.frame.width, height: self.view.frame.height/3)
        applabel.text = "NAGAYA"
          self.view.addSubview(applabel)
        applabel.textColor = UIColor.black
        applabel.font = UIFont.systemFont(ofSize: 30)
        applabel.textAlignment = NSTextAlignment.center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "Signup", sender: nil)
            
        }


    }




}
