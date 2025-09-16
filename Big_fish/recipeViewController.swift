//
//  recipeViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 03/08/22.
//

import UIKit

class recipeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var recipeuserid = ""
    var getdata = NSMutableData()
    var jsondata = NSDictionary()
    var arr = NSArray()
    var dict = NSDictionary()
    
    @IBOutlet weak var collect: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rcc", for: indexPath)as!recipeCollectionViewCell
        dict = arr[indexPath.row]as!NSDictionary
        cell.namelbl.text = dict["name"]as?String
        cell.timelbl.text = dict["time"]as?String
        let imgurl = dict["image"]as!String
        let urlimg = URL(string: imgurl)
        let dataimage = try?Data(contentsOf: urlimg!)
        cell.img.image = UIImage(data: dataimage!)
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stbrd = UIStoryboard(name: "Main", bundle: nil)
        let nvc = stbrd.instantiateViewController(withIdentifier: "rdvc")as!recipedetailsViewController
        dict = arr[indexPath.row]as!NSDictionary
        nvc.recipeid = dict["id"]as!String
        nvc.recipedetailsuserid = recipeuserid
        self.navigationController?.pushViewController(nvc, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/completeapi/getRecipes&api_token=")
         var req = URLRequest(url: url!)
         req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
         req.httpMethod = "Post"
        let poststring = "user_id=\(recipeuserid)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
        print("poststring ---->",poststring)
        req.httpBody = poststring.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req){(data,response,error)in
            
            let mydata = data
            do{
                print("mydata of recipe--->",mydata!)
                do{
                    self.getdata.append(mydata!)
                    
                    self.jsondata = try JSONSerialization.jsonObject(with: self.getdata as Data, options: [])as!NSDictionary
        
                    print("jsondata of recipe---->",self.jsondata)
                    self.arr = self.jsondata["data"]as!NSArray
                    do{
                        DispatchQueue.main.async {
                            self.collect.reloadData()
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
