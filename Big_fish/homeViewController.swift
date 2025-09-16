//
//  homeViewController.swift
//  Big_fish
//
//  Created by Kripa Benny on 02/08/22.
//

import UIKit

class homeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate  {

    var images = ["fish","yellfish","blackfish"]
   // var image1 = ["fish1","fish2"]
   // var image2 = ["fish3","fish4"]
    var useridtemp = ""
    var getdata = NSMutableData()
    var jsondata = NSDictionary()
    var dict1 = NSDictionary()
    var arr1 = NSArray()
    var dict2 = NSDictionary()
    
    
    @IBOutlet weak var collect2: UICollectionView!
    
    @IBOutlet weak var collect1: UICollectionView!
    
    @IBOutlet weak var mypage: UIPageControl!
    
    
    @IBOutlet weak var sview: UIView!
    
    
    @IBOutlet weak var fview: UIView!
    
    
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collect1{
            return images.count
        }
        else{
            
            return arr1.count
        
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collect1{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pcc", for: indexPath)as!pagecontrolCollectionViewCell
        cell.img.image = UIImage(named: images[indexPath.row])
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chcc", for: indexPath)as!categories_homeCollectionViewCell
            
            
           dict2 = arr1[indexPath.row]as!NSDictionary
            let imgurl = dict2["image"]as!String
            let urlimg = URL(string: imgurl)
            let dataimage = try?Data(contentsOf: urlimg!)
            cell.img.image = UIImage(data: dataimage!)
            cell.lbl.text = dict2["name"]as?String
            
                return cell
            
            
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == collect1{
            mypage.currentPage = indexPath.row
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collect2{
            let stbrd = UIStoryboard(name: "Main", bundle: nil)
            let svc = stbrd.instantiateViewController(withIdentifier: "pvc")as!productViewController
            dict2 = arr1[indexPath.row]as!NSDictionary
            svc.categoryidtemp = dict2["category_id"]as!String
            svc.titlename = dict2["name"]as!String
            svc.productuserid = useridtemp
            self.navigationController?.pushViewController(svc, animated: true)
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mypage.currentPage = 0
        mypage.numberOfPages = images.count
        
        fview.isHidden = true
        
        let leftside = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        leftside.direction = .left
        fview.addGestureRecognizer(leftside)
        
        
        let url = URL(string: "https://iroidtechnologies.in/MeatShop/index.php?route=api/completeapi&api_token=")
         var req = URLRequest(url: url!)
         req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
         req.httpMethod = "Post"
        let poststring = "user_id=\(useridtemp)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        
        print("poststring ---->",poststring)
        req.httpBody = poststring.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req){(data,response,error)in
            
            let mydata = data
            do{
                print("mydata of home--->",mydata!)
                do{
                    self.getdata.append(mydata!)
                    
                    self.jsondata = try JSONSerialization.jsonObject(with: self.getdata as Data, options: [])as!NSDictionary
        
                    print("jsondata of home---->",self.jsondata)
                    self.dict1 = self.jsondata["data"]as!NSDictionary
                   self.arr1 = self.dict1["categories"]as!NSArray
            
    
                   do{
                        DispatchQueue.main.async {
                            self.collect2.reloadData()
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
    
        
        
        
    
    @objc func swiped(gesture:UIGestureRecognizer){
        
        if let swipegesture = gesture as? UISwipeGestureRecognizer{
            
            switch swipegesture.direction
            {
            case .left:
                
                fview.isHidden = true
                
            default:
                break
        }
        
        }
    }
    

    
    
    @IBAction func menu_action(_ sender: Any) {
        
        fview.isHidden = false
        
        let backgroundImage = UIImageView(frame: sview.bounds)
         backgroundImage.image = UIImage(named: "fishbackground")
         backgroundImage.contentMode = UIView.ContentMode.scaleToFill
         backgroundImage.alpha = 0.7
         //sview.addSubview(backgroundImage)
        sview.insertSubview(backgroundImage, at: 0)
        
       /* let newview = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 896))
            newview.backgroundColor = UIColor.white
            self.view.addSubview(newview)
        
        let sview = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 268.8))
             newview.addSubview(sview)
        
        
       let backgroundImage = UIImageView(frame: sview.bounds)
        backgroundImage.image = UIImage(named: "fishbackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        backgroundImage.alpha = 0.7
        sview.addSubview(backgroundImage)
        
       let userImage = UIImageView(frame: CGRect(x: 30, y: 100, width: 100, height: 100))
        userImage.image = UIImage(named: "user")
        userImage.contentMode = UIView.ContentMode.scaleToFill
        userImage.alpha = 1
        backgroundImage.addSubview(userImage)
        
        let flabel = UILabel(frame: CGRect(x: 27, y: 210, width: 250, height: 30))
        flabel.text = "Welcome to Big Fish"
        flabel.textAlignment = .left
        flabel.textColor = .white
        flabel.font = UIFont.systemFont(ofSize: 17)
        backgroundImage.addSubview(flabel)
        
        let lbtn = UIButton(frame: CGRect(x: 0, y: 270, width: 350, height:100))
        lbtn.setTitle("Login", for: .normal)
        lbtn.setImage(UIImage(named: "gplus"), for: .normal)
        lbtn.setTitleColor(.black, for: .normal)
        newview.addSubview(lbtn)
        
        let sbtn = UIButton(frame: CGRect(x: 0, y: 370, width: 350, height:100))
    
        sbtn.setTitle("Sea Fish", for: .normal)
        sbtn.setTitleColor(.black, for: .normal)
        newview.addSubview(sbtn)
        
        let rbtn = UIButton(frame: CGRect(x: 0, y: 470, width: 350, height:100))
        
        rbtn.setTitle("Recipes", for: .normal)
        rbtn.setTitleColor(.black, for: .normal)
        newview.addSubview(rbtn)
        
        let ebtn = UIButton(frame: CGRect(x: 0, y: 570, width: 350, height:100))
        
        ebtn.setTitle("Edit Profile", for: .normal)
        ebtn.setTitleColor(.black, for: .normal)
        newview.addSubview(ebtn)
        
        let abtn = UIButton(frame: CGRect(x: 0, y: 670, width: 350, height:100))
        
        abtn.setTitle("About", for: .normal)
        abtn.setTitleColor(.black, for: .normal)
        newview.addSubview(abtn)*/
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func fishaction(_ sender: Any) {
        
        let stbrd = UIStoryboard(name: "Main", bundle: nil)
        let lvc = stbrd.instantiateViewController(withIdentifier: "pvc")as!productViewController
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }
   
    
    @IBAction func recipeaction(_ sender: Any) {
        
        let stbrd = UIStoryboard(name: "Main", bundle: nil)
        let lvc = stbrd.instantiateViewController(withIdentifier: "rvc")as!recipeViewController
        lvc.recipeuserid = useridtemp
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }
    
 
    
    @IBAction func editprofileaction(_ sender: Any) {
        
        let stbrd = UIStoryboard(name: "Main", bundle: nil)
        let lvc = stbrd.instantiateViewController(withIdentifier: "evc")as!editprofileViewController
        lvc.editprofileuserid = useridtemp
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }
    
  
    @IBAction func aboutaction(_ sender: Any) {
        
        let stbrd = UIStoryboard(name: "Main", bundle: nil)
        let lvc = stbrd.instantiateViewController(withIdentifier: "avc")as!aboutViewController
        lvc.aboutuserid = useridtemp
        self.navigationController?.pushViewController(lvc, animated: true)
        
        
        
    }
    
    
}
