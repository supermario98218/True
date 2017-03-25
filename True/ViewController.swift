//
//  ViewController.swift
//  True
//
//  Created by Mario Garcia on 3/17/17.
//  Copyright © 2017 Mario Garcia. All rights reserved.
//

//log in
import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!{
        didSet {
            signUpButton.layer.cornerRadius = 15
            signUpButton.layer.borderWidth = 0
            
            
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!{
        didSet {
            emailTextField.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName: UIColor.black])
            emailTextField.delegate = self
            emailTextField.layer.cornerRadius = 15
            emailTextField.layer.borderWidth = 3
            emailTextField.layer.borderColor = UIColor.white.cgColor
            let imageView = UIImageView()
            let image = UIImage(named: "emailicon")
            imageView.image = image
            imageView.frame = CGRect (x: 10, y: 5, width: 20, height: 20)
            emailTextField.addSubview(imageView)
            let leftView = UIView.init(frame: CGRect(x: 10,y: 0,width: 30, height: 30))
            emailTextField.leftView = leftView
            emailTextField.leftViewMode = UITextFieldViewMode.always
            
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet {
            passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName: UIColor.black])
            passwordTextField.delegate = self
            passwordTextField.layer.cornerRadius = 15
            passwordTextField.layer.borderWidth = 3
            passwordTextField.layer.borderColor = UIColor.white.cgColor
            let imageView2 = UIImageView()
            let image2 = UIImage(named: "passwordicon")
            imageView2.image = image2
            imageView2.frame = CGRect (x: 10, y: 5, width: 20, height: 20)
            passwordTextField.addSubview(imageView2)
            let lView = UIView.init(frame: CGRect(x: 10,y: 0,width: 30, height: 30))
            passwordTextField.leftView = lView
            passwordTextField.leftViewMode = UITextFieldViewMode.always
            
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 15
            loginButton.layer.borderWidth = 0
            loginButton.layer.backgroundColor = UIColor(red:0.75, green:0.11, blue:0.12, alpha:1.0).cgColor
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestureRecognizersToDismissKeyboard()
    }
    
    
//    @IBAction func resetPasswordAction(sender: UIButton) {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "forgotPassword") as! forgotPassViewController
//        UIApplication.shared.keyWindow?.rootViewController = viewController
//        // let forgotPass = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "forgotPassword")
//        // self.present(forgotPass, animated:true, completion:nil)
//    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "signInMenu") as! SignUpViewController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    var authentication = Authentication()
    
    @IBAction func loginAction(sender: UIButton) {
        self.view.endEditing(true)
        
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!
        
        if finalEmail.characters.count < 8 || finalEmail.isEmpty || password.isEmpty {
            
            let alertController = UIAlertController(title: "Error", message: "Incorrect Username or Password", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            
        }else {
            
            authentication.logIn(email: finalEmail, password: password)
        }
        
        
    }
    
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Extension of LoginViewController that provides gestures

extension ViewController: UITextFieldDelegate  {
    
    // Dismissing the Keyboard with the Return Keyboard Button
    func dismissKeyboard(gesture: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // Dismissing the Keyboard with the Return Keyboard Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    // Moving the View down after the Keyboard appears
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateView(up: true, moveValue: 20)
    }
    
    // Moving the View down after the Keyboard disappears
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateView(up: false, moveValue: 20)
    }
    
    
    // Move the View Up & Down when the Keyboard appears
    func animateView(up: Bool, moveValue: CGFloat){
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
        
    }
    
    func setGestureRecognizersToDismissKeyboard(){
        // Creating Tap Gesture to dismiss Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        // Creating Swipe Gesture to dismiss Keyboard
        let swipDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard(gesture:)))
        swipDown.direction = .down
        view.addGestureRecognizer(swipDown)
    }
    
}


