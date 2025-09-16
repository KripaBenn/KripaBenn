//
//  editprofileViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 03/08/22.
//

import UIKit

class editprofileViewController: UIViewController {
    
    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var txt2: UITextField!
    
    @IBOutlet weak var sview: UIView!
    
    @IBOutlet weak var fview: UIView!
    
    @IBOutlet weak var txt3: UITextField!
    
    @IBOutlet weak var txt4: UITextField!
    
    
    var editprofileuserid = ""
    var getdata = NSMutableData()
    var jsondata = NSDictionary()
    var status_variable = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let aString1 =  NSMutableAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        let aString2 =  NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        aString1.append(aString2)
        txt1.attributedPlaceholder = aString1
        
        
        let aString3 =  NSMutableAttributedString(string: "Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        let aString4 =  NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        aString3.append(aString4)
        txt2.attributedPlaceholder = aString3
        
        sview.dropShadow1()
        fview.dropShadow1()
        
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
    
    
    @IBAction func updatebutton(_ sender: Any) {
        
        let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/completeapi/updateProfile&api_token")
        var req = URLRequest(url: url!)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
        req.httpMethod = "Post"
        let poststring = "user_id=\(editprofileuserid)&firstname=\(txt1.text!)&lastname=\(txt3.text!)&email=\(txt4.text!)&telephone=\(txt2.text!)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
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
                                let al = UIAlertController(title: "Alert", message: "Updated Successfully", preferredStyle: .alert)
                                al.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert:UIAlertAction!) -> Void in
                                    
                                    
                                    let stbrd = UIStoryboard(name: "Main", bundle: nil)
                                    let svc = stbrd.instantiateViewController(withIdentifier: "lovc")as!loginViewController
                                    self.navigationController?.pushViewController(svc, animated: true)
                                }))
                                self.present(al, animated: true, completion: nil)
                            default:
                                
                                let al = UIAlertController(title: "Alert", message: "Updation Failed.Try Again", preferredStyle: .alert)
                                al.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert:UIAlertAction!) -> Void in
                                    
                                    
                                    let stbrd = UIStoryboard(name: "Main", bundle: nil)
                                    let svc = stbrd.instantiateViewController(withIdentifier: "evc")as!editprofileViewController
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

extension UIView{
    func dropShadow1(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
