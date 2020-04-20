//
//  PeopleTableViewController.swift
//  JCoding
//
//  Created by himanshu on 03/04/20.
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
        let mapVC = storyboard?.instantiateViewController(identifier: "MapView") as! MapView; self.navigationController?.pushViewController(mapVC, animated: true)
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
        navigationItem.title = "Animals"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func observeUsers(){
        Api.User.observeUsers{ (user) in
            let currentUserID : String = (Auth.auth().currentUser?.uid)!
            let ref = Database.database().reference()
            ref.child("users").child(currentUserID).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let latt = value?["dogslat"] as? Double
                let long = value?["dogslong"] as? Double
                let dist = Int(value?["distance"] as! String)
                print(latt)
                print(long)
                print(dist)
                let lattdiff = (latt!-user.dogslat)*(latt!-user.dogslat)
                let longdiff = (long!-user.dogslong)*(long!-user.dogslong)
                if ((Int((lattdiff+longdiff).squareRoot())) < dist!) {
                    self.users.append(user)
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
        return 105
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let chatVC = storyboard.instantiateViewController(identifier: "chatVC") as! ChatViewController
            chatVC.imagePartner = cell.avatar.image
            chatVC.userName = cell.userName.text
            chatVC.otherUser = cell.user.uid
            self.navigationController?.pushViewController(chatVC, animated: true)
            
        }
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
