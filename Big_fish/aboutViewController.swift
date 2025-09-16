//
//  aboutViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 03/08/22.
//

import UIKit

class aboutViewController: UIViewController {
    
    @IBOutlet weak var txtvw: UITextView!
    var aboutuserid = ""
    var getdata = NSMutableData()
    var jsondata = NSDictionary()
    var dict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
     /*   let heading = "                      BigFish Pvt Ltd."
        let content = "\n\nMultiple times debiting of Consumer Card/Bank Account due to ticnical error excluding Payment Gateway charges would be refunded to the consumer with in 1 week after submitting complaint form. Consumers account being debited with excess amount in single transaction due to tecnical error will be deducted in next month transaction. Due to technical error, payment being charged on the consumers Card/Bank Account but the Bill is unsuccessful."

        let attributedText = NSMutableAttributedString(string: heading, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])

        attributedText.append(NSAttributedString(string: content, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))

        txtvw.attributedText = attributedText
        txtvw.textAlignment = .justified                  */
        
        
        let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/completeapi/aboutUs&api_token")
         var req = URLRequest(url: url!)
         req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
         req.httpMethod = "Post"
        let poststring = "user_id=\(aboutuserid)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
        print("poststring ---->",poststring)
        req.httpBody = poststring.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req){(data,response,error)in
            
            let mydata = data
            
                print("mydata of about---->",mydata!)
                do{
                    self.getdata.append(mydata!)
                    
                    self.jsondata = try JSONSerialization.jsonObject(with: self.getdata as Data, options: [])as!NSDictionary
        
                    print("jsondata of about---->",self.jsondata)
                    self.dict = self.jsondata["data"]as!NSDictionary
                    do{
                        
                        DispatchQueue.main.async {
                            
                            self.txtvw.text = self.dict["description"]as?String
                        }
                    
                    
                    
                    
                    
                }
                }
            
            catch{
                print("error--->",error.localizedDescription)
            }
        }
        task.resume()
        
        
        
        
        
        
        
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
}
