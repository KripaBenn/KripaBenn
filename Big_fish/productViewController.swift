//
//  productViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 02/08/22.
//

import UIKit

class productViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var seg: UISegmentedControl!
    
    @IBOutlet weak var collect: UICollectionView!
    
    
    @IBOutlet weak var titlelbl: UILabel!
    
    
   // var images1 = ["fish1","fish2"]
   // var images2 = ["fish3","fish4"]
   // var images3 = ["fish1","fish2"]
    
   var categoryidtemp = ""
    var productuserid = ""
    var getdata = NSMutableData()
    var jsondata = NSDictionary()
    var dict = NSDictionary()
    var arr = NSArray()
    var titlename = ""
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fcc", for: indexPath)as!freshfishCollectionViewCell
        dict = arr[indexPath.row]as!NSDictionary
        cell.namelbl.text = dict["name"]as?String
        cell.discountpricelbl.text = dict["discount_price"]as?String
        cell.pricelbl.text = dict["price"]as?String
        titlelbl.text = titlename
        let imgurl = dict["image"]as!String
        let urlimg = URL(string: imgurl)
        let dataimage = try?Data(contentsOf: urlimg!)
        cell.img.image = UIImage(data: dataimage!)
        
            return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stbrd = UIStoryboard(name: "Main", bundle: nil)
        let svc = stbrd.instantiateViewController(withIdentifier: "spvc")as!singleproductViewController
        dict = arr[indexPath.row]as!NSDictionary
        svc.singleproductid = dict["product_id"]as!String
        svc.singleproductuserid = productuserid
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        seg.backgroundColor = .white //Any Color of your choice
        seg.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default) //This does the magic
        seg.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default) // This will remove the divider image.
        
        
        
        
       /* seg.backgroundColor = .clear
        seg.tintColor = .clear
        
        seg.insertSegment(withTitle: "SEA FISH", at: 0, animated: true)
        seg.insertSegment(withTitle: "BACKWATER FISH", at: 1, animated: true)
        seg.selectedSegmentIndex = 0
        seg.setwidth
        */
        
        let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/completeapi/categoryProducts&api_token=")
         var req = URLRequest(url: url!)
         req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
         req.httpMethod = "Post"
        let poststring = "user_id=\(productuserid)&category_id=\(categoryidtemp)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
        print("poststring ---->",poststring)
        req.httpBody = poststring.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req){(data,response,error)in
            
            let mydata = data
            do{
                print("mydata of product--->",mydata!)
                do{
                    self.getdata.append(mydata!)
                    
                    self.jsondata = try JSONSerialization.jsonObject(with: self.getdata as Data, options: [])as!NSDictionary
        
                    print("jsondata of product---->",self.jsondata)
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
