//
//  loginViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 02/08/22.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var mainview: UIView!
    
    
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var txt2: UITextField!
    var getdata = NSMutableData()
    var jsondata = NSDictionary()
    var status_variable = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginbtn.layer.cornerRadius = loginbtn.frame.size.height/2
        loginbtn.layer.borderWidth = 0.5
        loginbtn.layer.borderColor = UIColor.cyan.cgColor
        
        mainview.layer.cornerRadius = 10
        mainview.layer.borderWidth = 0.3
        mainview.layer.borderColor = UIColor.gray.cgColor
        
        mainview.dropShadow()
        
        
    }
    
    
    @IBAction func logaction(_ sender: Any) {
        
       let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/login&api_token=")
        var req = URLRequest(url: url!)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
        req.httpMethod = "Post"
        let poststring = "email=\(txt1.text!)&password=\(txt2.text!)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
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
                        DispatchQueue.main.async{
                            self.status_variable = self.jsondata["status"]as!String
                            switch self.status_variable{
                            case "success":
                                let stbrd = UIStoryboard(name: "Main", bundle: nil)
                                let lvc = stbrd.instantiateViewController(withIdentifier: "hvc")as!homeViewController
                                lvc.useridtemp = self.jsondata["user_id"]as!String
                                self.navigationController?.pushViewController(lvc, animated: true)
                            default:
                                print("error")
                                self.txt1.text = "Invalid email"
                                self.txt2.text = "Invalid password"
                                self.txt1.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                                self.txt2.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                                let al = UIAlertController(title: "Alert", message: "Incorrect Login Credentials", preferredStyle: .alert)
                                al.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert:UIAlertAction!) -> Void in
                                    //self.viewWillAppear(true)
                                    //self.txt1.text = ""
                                   // self.txt2.text = ""
                                    
                                    let stbrd = UIStoryboard(name: "Main", bundle: nil)
                                    let svc = stbrd.instantiateViewController(withIdentifier: "lovc")as!loginViewController
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
    
    
    @IBAction func signaction(_ sender: Any) {
        
        let stbrd = UIStoryboard(name: "Main", bundle: nil)
        let svc = stbrd.instantiateViewController(withIdentifier: "sivc")as!signupViewController
        self.navigationController?.pushViewController(svc, animated: true)
        
        
    }
    


}

extension UIView{
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}



    


