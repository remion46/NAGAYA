//
//  LoginViewController.swift
//  NAGAYA
//
//  Created by 船越廉 on 2021/02/11.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var emailextfield: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
    @IBOutlet weak var nicknametextfield: UITextField!
    
    @IBOutlet weak var registerbutton: UIButton!
    
    
    @IBAction func tappedregister(_ sender: Any) {
        
        handleAuthToFirebase()
        
    }
    
    private func handleAuthToFirebase(){
        
        guard let email = emailextfield.text else { return  }
        guard let password = passwordtextfield.text else { return  }
        
        Auth.auth().createUser(withEmail: email, password: password) { (ress, err) in
            if let err = err {
                
                print("認証情報の保存に失敗しました\(err)")
                return
            }
        
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            guard let name = self.nicknametextfield.text else { return }
            
            let docdata = ["email": email,"name": name ,"createdAt": Timestamp()] as [String : Any ]
            Firestore.firestore().collection("users").document(uid).setData(docdata) { (err) in
                if let err = err {
                    
                    print("Firestoreの保存に失敗しました\(err)")
                    return
                }
            
            print("Firestoreの保存に成功しました")
            return
                                                                            
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerbutton.isEnabled = false
        registerbutton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 187)
        emailextfield.delegate = self
        passwordtextfield.delegate = self
        nicknametextfield.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(showkeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidekeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func showkeyboard(notification: Notification){
        
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard  let keyboardFrameMinY = keyboardFrame?.minY else {return}
        let registerbuttonMaxY = registerbutton.frame.maxX
        let distance = registerbuttonMaxY - keyboardFrameMinY + 20
        
        let transform = CGAffineTransform(translationX: 0, y: distance)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {self.view.transform = transform})
    }
    
    @objc func hidekeyboard(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {self.view.transform = .identity})
        
    }

    
   

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let emailIsEmpty = emailextfield.text?.isEmpty ?? true
        let passwordIsEmpty = emailextfield.text?.isEmpty ?? true
        let nicknameIsEmpty = emailextfield.text?.isEmpty ?? true
        
        if emailIsEmpty || passwordIsEmpty || nicknameIsEmpty{registerbutton.isEnabled = false
            registerbutton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 187)
        } else {
            registerbutton.isEnabled = true
            registerbutton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 0)
        }
            
        }
        
    }

