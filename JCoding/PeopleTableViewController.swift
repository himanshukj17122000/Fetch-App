//
//  PeopleTableViewController.swift
//  JCoding
//
//  Created by himanshu on 03/04/20.
//  Edited by Donald
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class PeopleTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == nil {
            
            view.endEditing(true)
        } else if  searchController.searchBar.text!.isEmpty{
            searchResults = users
             view.endEditing(true)
        }
        else{
            let lowertextcase = searchController.searchBar.text!.lowercased()
            filterContent(for : lowertextcase)
        }
        tableView.reloadData()
    }
    func filterContent(for searchText: String){
        searchResults = self.users.filter{
            return $0.username.lowercased().range(of: searchText) != nil
        }
    }
    
    var users: [User] = []
    var searchResults: [User] = []
    var searchController : UISearchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBarController()
        setupNavigation()
        observeUsers()
        setupTableView()
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func setupTableView(){
        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func mapView(_ sender: Any) {
        let mapVC = storyboard?.instantiateViewController(identifier: "MapViewController") as! MapViewController; self.navigationController?.pushViewController(mapVC, animated: true)
        mapVC.users = self.users
    }
    func setupSearchBarController(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search users...."
        searchController.searchBar.barTintColor = UIColor.white
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func setupNavigation(){
        navigationItem.title = "Pets nearby"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func observeUsers(){
       Api.User.observeUsers{ (user) in
                let currentUserID : String = (Auth.auth().currentUser?.uid)!
                let ref = Database.database().reference()
                ref.child("users").child(currentUserID).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let dogsgender = value?["dogsgender"] as? String
                    let dogsprefgender = value?["prefgender"] as? String
                    let profileImageurl = value?["profileImageUrl"] as? String
                    _ = UIImage(contentsOfFile: profileImageurl ?? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.akc.org%2Fexpert-advice%2Flifestyle%2F35-perfect-pictures-of-dogs%2F&psig=AOvVaw0i2Zs48r3DkOc1njLwqF3h&ust=1587596187736000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCNj7hunO-ugCFQAAAAAdAAAAABAD")
                    let latt = value?["dogslat"] as? Double
                    let long = value?["dogslong"] as? Double
                    let dist = Int(value?["distance"] as! String)
                    //let dogbio = value?["dogbio"] as! String
                    let lattdiff = (latt!-user.dogslat)*(latt!-user.dogslat)
                    let longdiff = (long!-user.dogslong)*(long!-user.dogslong)
    
                    if ((Int((lattdiff+longdiff).squareRoot())) < dist!) {
                        if(dogsprefgender!.elementsEqual(user.dogGender) == true) || (dogsprefgender!.elementsEqual("both") == true) {
                            if(dogsgender!.elementsEqual(user.prefgender) == true) || (user.prefgender.elementsEqual("both") == true) {
                                if(currentUserID.elementsEqual(user.uid) == false) {
                                    self.users.append(user)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                    
                  }) { (error) in
                    print(error.localizedDescription)
                }
                
            }
            for user in users {
                print(user.uid)
            }
        }


    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
     
            if searchController.isActive{
                return searchResults.count
            }
            else {
                searchResults.removeAll()
        return self.users.count
        }
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let user = searchController.isActive ? searchResults[indexPath.row] : users[indexPath.row]
        cell.loadData(user)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let chatVC = storyboard.instantiateViewController(identifier: "chatVC") as! ChatViewController
//            chatVC.imagePartner = cell.avatar.image
//            chatVC.userName = cell.userName.text
//            chatVC.otherUser = cell.user.uid
//            self.navigationController?.pushViewController(chatVC, animated: true)
//
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // and cast it to the correct class type 

        let destVC = segue.destination as! detailViewController

        // Pass the selected object to the new view controller.
        let myRow = tableView!.indexPathForSelectedRow
        let cell = tableView!.cellForRow(at: myRow!) as! UserTableViewCell

        // set the destVC variables from the selected row
        destVC.pic = cell.avatar.image
        destVC.name = cell.user.dogname
        destVC.distance = cell.user.distance
        destVC.gender = cell.user.dogGender
        //destVC.user = cell.user
        destVC.info = cell.user.dogsbio

        }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
