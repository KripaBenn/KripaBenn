//
//  singleproductViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 03/08/22.
//

import UIKit

class singleproductViewController: UIViewController {

    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var txtvw2: UITextView!
    
    
    @IBOutlet weak var bluepricelbl: UILabel!
    
    
    @IBOutlet weak var wholeproductpricelbl: UILabel!
    
    
    @IBOutlet weak var weightagelbl: UILabel!
    
    
    var singleproductid = ""
    var singleproductuserid = ""
    var getdata = NSMutableData()
    var jsondata = NSDictionary()
    var dict = NSDictionary()
    var imgarray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    /*    let heading = "Description"
        let content = "\n\nMultiple times debiting of Consumer Card/Bank Account due to ticnical error excluding Payment Gateway charges would be refunded to the consumer with in 1 week after submitting complaint form. Consumers account being debited with excess amount in single transaction due to tecnical error will be deducted in next month transaction. Due to technical error, payment being charged on the consumers Card/Bank Account but the Bill is unsuccessful."

        let attributedText = NSMutableAttributedString(string: heading, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])

        attributedText.append(NSAttributedString(string: content, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.black]))

        txtvw2.attributedText = attributedText
        txtvw2.textAlignment = .justified  */
        
       /* let heading1 = "Price Summary"
        let content1 = "\n\nWhole Product Price                                                       580/kg\n\nWhole Product Required                                             0.580/kg\n\nWeightage                                                                          .27kg\n\nFinal Weight                                                                       .50kg\n\nDelivery Charge:"
        let content2 = "                                                                FREE"
        let content3 = "\n\n\nFinal Price                                                             0.780*580=486"
        
        let attributedText1 = NSMutableAttributedString(string: heading1, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        let  attributedText2 = NSMutableAttributedString(string: content1, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
        let  attributedText3 = NSMutableAttributedString(string: content2, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.green])
        let  attributedText4 = NSMutableAttributedString(string: content3, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
    

       attributedText1.append(attributedText2)
        attributedText1.append(attributedText3)
        attributedText1.append(attributedText4)
        

        txtvw1.attributedText = attributedText1 */
        
        let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/completeapi/getProduct&api_token=")
         var req = URLRequest(url: url!)
         req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
         req.httpMethod = "Post"
        let poststring = "product_id=\(singleproductid)&user_id=\(singleproductuserid)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
        print("poststring ---->",poststring)
        req.httpBody = poststring.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req){(data,response,error)in
            
            let mydata = data
            
                print("mydata of single product--->",mydata!)
                do{
                    self.getdata.append(mydata!)
                    
                    self.jsondata = try JSONSerialization.jsonObject(with: self.getdata as Data, options: [])as!NSDictionary
        
                    print("jsondata of single product---->",self.jsondata)
                    self.dict = self.jsondata["data"]as!NSDictionary
                    do{
                        DispatchQueue.main.async {
                            self.namelbl.text = self.dict["name"]as?String
                            self.titlelbl.text = self.dict["name"]as?String
                            self.weightagelbl.text = self.dict["weight"]as?String
                           self.wholeproductpricelbl.text = self.dict["whole_price"]as?String
                           self.bluepricelbl.text = self.dict["product_price"]as?String
                            self.txtvw2.text = self.dict["description"]as?String
                            self.imgarray = self.dict["images"]as!NSArray
                            let imgurl = self.imgarray[0]as!String
                            let urlimg = URL(string: imgurl)
                            let dataimage = try?Data(contentsOf: urlimg!)
                            self.imgvw.image = UIImage(data: dataimage!)
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
