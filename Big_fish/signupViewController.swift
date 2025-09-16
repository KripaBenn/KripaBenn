//
//  signupViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 02/08/22.
//

import UIKit

class signupViewController: UIViewController {

    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var txt2: UITextField!
    
    
    @IBOutlet weak var txt3: UITextField!
    
    
    @IBOutlet weak var txt4: UITextField!
    
    
    @IBOutlet weak var txt5: UITextField!
    
    @IBOutlet weak var txt6: UITextField!
    var getdata = NSMutableData()
    var status_variable = ""
    var jsondata = NSDictionary()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let aString1 =  NSMutableAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        let aString2 =  NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        aString1.append(aString2)
        txt1.attributedPlaceholder = aString1
        
        
        let aString3 =  NSMutableAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        let aString4 =  NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        aString3.append(aString4)
        txt2.attributedPlaceholder = aString3
        
        
        
        let aString5 =  NSMutableAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        let aString6 =  NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        aString5.append(aString6)
        txt3.attributedPlaceholder = aString5
        
        
        
        let aString7 =  NSMutableAttributedString(string: "Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        let aString8 =  NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        aString7.append(aString8)
        txt4.attributedPlaceholder = aString7
        
        
        let aString9 =  NSMutableAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        let aString10 =  NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        aString9.append(aString10)
        txt5.attributedPlaceholder = aString9
        
        
        let aString11 =  NSMutableAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        let aString12 =  NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        aString11.append(aString12)
        txt6.attributedPlaceholder = aString11
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func backaction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    @IBAction func registerbutton(_ sender: Any) {
        
        let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/register&api_token=")
        var req = URLRequest(url: url!)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
        req.httpMethod = "Post"
        let poststring = "firstname=\(txt1.text!)&lastname=\(txt2.text!)&email=\(txt3.text!)&telephone=\(txt4.text!)&password=\(txt5.text!)&type=\("0")&referal_code=\("") &key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
        print("poststring---->",poststring)
        req.httpBody = poststring.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req){(data,response,error)in
            
            let mydata = data
            do{
                print("mydata--->",mydata!)
                do{
                    self.getdata.append(mydata!)
                    
                    self.jsondata = try JSONSerialization.jsonObject(with: self.getdata as Data, options: [])as!NSDictionary
                    print("jsondata---->",self.jsondata)
                    do{
                        DispatchQueue.main.async {
                            
                            self.status_variable = self.jsondata["status"]as!String
                            switch self.status_variable{
                            case "success":
                                let al = UIAlertController(title: "Alert", message: "Registered Successfully", preferredStyle: .alert)
                                al.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert:UIAlertAction!) -> Void in
                                    
                                    
                                    let stbrd = UIStoryboard(name: "Main", bundle: nil)
                                    let svc = stbrd.instantiateViewController(withIdentifier: "lovc")as!loginViewController
                                    self.navigationController?.pushViewController(svc, animated: true)
                                }))
                                self.present(al, animated: true, completion: nil)
                            default:
                                
                                let al = UIAlertController(title: "Alert", message: "Registration Failed.Try Again", preferredStyle: .alert)
                                al.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert:UIAlertAction!) -> Void in
                                    
                                    
                                    let stbrd = UIStoryboard(name: "Main", bundle: nil)
                                    let svc = stbrd.instantiateViewController(withIdentifier: "sivc")as!signupViewController
                                    self.navigationController?.pushViewController(svc, animated: true)
                                }))
                                self.present(al, animated: true, completion: nil)
                        }
                    }
                }
                                                           
            }
            }
            catch{
                print("error--->",error.localizedDescription)
            }
        }
        task.resume()
        
        
        
        
        
        
        
    }
    
    
  
    
    
    
    
}
