//  RegistrationVC.swift
//  InfyCodeJudgeTask
//  Created by Ranjeet Raushan on 20/09/20.
//  Copyright © 2020 Ranjeet Raushan. All rights reserved.

import UIKit
import Alamofire

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var txtFieldName: HoshiTextField!{
        didSet{
            txtFieldName.useUnderline()
               txtFieldName.attributedPlaceholder = NSAttributedString(string: "Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    @IBOutlet weak var txtFieldAddresse: HoshiTextField!{
        
        didSet{
            txtFieldAddresse.useUnderline()
               txtFieldAddresse.attributedPlaceholder = NSAttributedString(string: "Addresse",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    @IBOutlet weak var txtFieldEmail: HoshiTextField!{
        didSet{
            txtFieldEmail.useUnderline()
              txtFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    @IBOutlet weak var txtFieldMobileNumber: HoshiTextField!
        {
        didSet{
            txtFieldMobileNumber.useUnderline()
               txtFieldMobileNumber.attributedPlaceholder = NSAttributedString(string: "Mobile Number",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
            
        }
    }
    @IBOutlet weak var txtFieldPassword: HoshiTextField!
        {
        didSet{
            txtFieldPassword.useUnderline()
              txtFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
        }
    }
    @IBOutlet weak var txtFieldReEnterPassword: HoshiTextField!{
        didSet{
            txtFieldReEnterPassword.useUnderline()
               txtFieldReEnterPassword.attributedPlaceholder = NSAttributedString(string: "Re-enter Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    
    @IBOutlet weak var btnCreateAccount: UIButton!
    
    @IBOutlet weak var btnAlreadyMemberLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Mark:- Validiation
      func validiate() {
        guard let name = txtFieldName.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                   showMessage(bodyText: "Enter  Name",theme: .warning)
                   return
               }
        guard let addresse = txtFieldAddresse.text, !addresse.trimmingCharacters(in: .whitespaces).isEmpty else {
                   showMessage(bodyText: "Enter  Addresse",theme: .warning)
                   return
               }
        guard let email = txtFieldEmail.text?.trim() else {
            showMessage(bodyText: "Enter Email ID",theme: .warning)
            return
        }
        
        if !email.isValidEmail() {
            showMessage(bodyText: "Enter valid Email ID",theme: .warning)
            return
        }
        
        guard let mobileNumber = txtFieldMobileNumber.text, !mobileNumber.trimmingCharacters(in: .whitespaces).isEmpty else {
            showMessage(bodyText: "Enter  Mobile Number",theme: .warning)
            return
        }
        
        
        guard let pswd = txtFieldPassword.text, !pswd.trimmingCharacters(in: .whitespaces).isEmpty else {
            showMessage(bodyText: "Enter Password",theme: .warning)
            return
        }
        if pswd.count < 6
        {
            showMessage(bodyText: "Provide minimum 6 charecters for password",theme: .warning)
            return
            
        }
        
        guard let reEnterPswd = txtFieldReEnterPassword.text,  !reEnterPswd.isEmpty else {
             showMessage(bodyText: "Re-Enter Password",theme: .warning)
             return
         }
         
         if reEnterPswd.count < 6
         {
             showMessage(bodyText: "Provide minimum 6 charecters for password",theme: .warning)
             return
             
         }
         
         if pswd != reEnterPswd {
             showMessage(bodyText: "Passwords should match",theme: .warning)
             return
         }
        
        let params: [String:Any] =  [
            "name": name,
            "address": addresse,
            "mobile": mobileNumber ,
            "email": email,
            "password": pswd,
           
            ] as [String : Any]
        callService(params: params,endPoint: Endpoints.signUp)
    }
    private func callService(params: [String: Any],endPoint:String){
        if currentReachabilityStatus != .notReachable {
            hitServer(params: params,endPoint: endPoint)
        } else {
            showMessage(bodyText: "No internet",buttonTitle: "Retry",theme: .error,buttonTapHandler: {(done) in
                self.callService(params: params,endPoint: endPoint )
            })
        }
    }
        func hitServer(params: [String:Any],endPoint: String) {
            InfyTaskClient.shared.hitService(withBodyData: params, toEndPoint: endPoint, using: .post, dueToAction: "signUp"){ result in
              
                switch result {
                case let .success(json,_):
                    let msg = json["message"].stringValue
                    if json["error"].intValue == 1 {
                        showMessage(bodyText: msg,theme: .error)
                    }else {
                        showMessage(bodyText: "Registration Successful",theme: .success)
                    }
                    break
                case .failure(let error):
                    print("MyError = \(error)")
                    break
                }
            }
        }
    @IBAction func onCrateAccountBtnClk(_ sender: UIButton) {
        validiate()
    }
    
    @IBAction func onAlradyMemberLogin(_ sender: UIButton) {
        let LoginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(LoginVC, animated: false)
    }
    
}


