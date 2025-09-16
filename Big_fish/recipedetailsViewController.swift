//
//  recipedetailsViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 11/08/22.
//

import UIKit

class recipedetailsViewController: UIViewController {
    
    var recipedetailsuserid = ""
    var recipeid = ""
    var getdata = NSMutableData()
    var jsondata = NSDictionary()
    var dict1 = NSDictionary()
    var dict2 = NSDictionary()
    
    @IBOutlet weak var callbl: UILabel!
    
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var blackview: UIView!
    
    
    @IBOutlet weak var txtvw: UITextView!
    
    @IBOutlet weak var txtvw2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //blackview.alpha = 0.5
        
        blackview.backgroundColor = UIColor.black.withAlphaComponent(0.5)
       // blackview.layer.opacity = 0.5
        
        
        let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/completeapi/recipe&api_token")
         var req = URLRequest(url: url!)
         req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
         req.httpMethod = "Post"
        let poststring = "user_id=\(recipedetailsuserid)&recipe_id=\(recipeid)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
        print("poststring ---->",poststring)
        req.httpBody = poststring.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req){(data,response,error)in
            
            let mydata = data
            
                print("mydata of recipedetails--->",mydata!)
                do{
                    self.getdata.append(mydata!)
                    
                    self.jsondata = try JSONSerialization.jsonObject(with: self.getdata as Data, options: [])as!NSDictionary
        
                    print("jsondata of recipedetails---->",self.jsondata)
                    self.dict1 = self.jsondata["data"]as!NSDictionary
                    self.dict2 = self.dict1["recipie"]as!NSDictionary
                    
                   do{
                        DispatchQueue.main.async {
                            let imgurl = self.dict2["image"]as!String
                            let urlimg = URL(string: imgurl)
                            let dataimage = try?Data(contentsOf: urlimg!)
                            self.imgvw.image = UIImage(data: dataimage!)
                            
                            self.namelbl.text = self.dict2["name"]as?String
                            self.titlelbl.text = self.dict2["name"]as?String
                            self.txtvw.text = self.dict2["ingredients"]as?String
                            self.txtvw2.text = self.dict2["description"]as?String
                            self.timelbl.text = self.dict2["time"]as?String
                            self.callbl.text = self.dict2["cals"]as?String
                            
                            
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

    
    @IBAction func backbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
