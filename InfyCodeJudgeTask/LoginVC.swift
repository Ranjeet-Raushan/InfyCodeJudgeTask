//  LoginVC.swift
//  InfyCodeJudgeTask
//  Created by Ranjeet Raushan on 20/09/20.
//  Copyright © 2020 Ranjeet Raushan. All rights reserved.


import UIKit
import  Alamofire

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var txtFiledEmail: HoshiTextField!{
        didSet{
            txtFiledEmail.useUnderline()
            txtFiledEmail.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    @IBOutlet weak var txtFieldPassword: HoshiTextField!
        {
        didSet{
            txtFieldPassword.useUnderline()
            txtFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnNoAcontYetCratOne: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginBtnClk(_ sender: UIButton) {
        validiateInputFields()
        hideKeyBoard()
    }
    fileprivate func validiateInputFields(){
        guard let email = txtFiledEmail.text?.trim() else {
            showMessage(bodyText: "Enter Email ID",theme: .warning)
            return
        }
        if !email.isValidEmail() {
            showMessage(bodyText: "Enter valid Email ID",theme: .warning)
            return
        }
        guard let pwd = txtFieldPassword.text, !pwd.trimmingCharacters(in: .whitespaces).isEmpty else {
            showMessage(bodyText: "Enter Password",theme: .warning)
            return
        }
        if pwd.count < 6
              {
                  showMessage(bodyText: "Provide minimum 6 charecters for password",theme: .warning)
                  return
                  
              }
        
        let params:[String:Any] = ["email":email,"password": pwd ]
        callService(params: params)
    }    
    
    fileprivate func hideKeyBoard(){
        txtFiledEmail.resignFirstResponder()
        txtFieldPassword.resignFirstResponder()
    }
    
    @IBAction func onNoAccountYetCreateOne(_ sender: UIButton) {
        let RegistrationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        navigationController?.pushViewController(RegistrationVC, animated: false)
        
    }
    
    private func callService(params: [String: Any]){
        if currentReachabilityStatus != .notReachable {
            self.hitServer(params:params ,action: "signIn" )
        } else {
            showMessage(bodyText: "No internet",buttonTitle: "Retry",theme: .error,buttonTapHandler: {(done) in
                self.callService(params: params)
            })
        }
    }
    
    private func hitServer(params: [String:Any],action: String) {
        
        InfyTaskClient.shared.hitService(withBodyData: params, toEndPoint: Endpoints.signIn, using: .post, dueToAction: action){ result in
            
            switch result {
            case let .success(json,_):
                let msg = json["message"].stringValue
                if json["error"].intValue == 1 {
                    showMessage(bodyText: msg,theme: .error)
                }else {
                    showMessage(bodyText: "Logged In Successfully",theme: .success)
                }
                break
            case .failure(let error):
                print("MyError = \(error)")
                break
            }
        }
    }
    
}
