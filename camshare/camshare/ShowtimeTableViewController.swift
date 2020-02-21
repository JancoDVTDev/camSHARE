//
//  ShowtimeTableViewController.swift
//  camshare
//
//  Created by Janco Erasmus on 2020/02/20.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ShowtimeTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: Properties

    var results = [ResultingClass]()
    
    var listOfResults = [ArtistInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfResults.count) Results"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleResults()
        searchBar.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ShowtimeResultTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? ShowtimeResultTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let result = listOfResults[indexPath.row]
        
        cell.descriptionLabel.text = result.trackName
        //cell.profileImage.image = result.

        // Configure the cell...

        return cell
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
    
    //MARK: Private Methods
    
    private func loadSampleResults() {
        let photo1 = UIImage(named: "pfImage1")
        let photo2 = UIImage(named: "pfImage2")
        let photo3 = UIImage(named: "pfImage3")
        
        guard let result1 = ResultingClass(description: "Something about these two", photo: photo1) else{
            fatalError("Unable to instantiate result1")
        }
        guard let result2 = ResultingClass(description: "Be in the spirit", photo: photo2) else{
            fatalError("Unable to instantiate result1")
        }
        guard let result3 = ResultingClass(description: "Walking with you", photo: photo3) else{
            fatalError("Unable to instantiate result1")
        }
        
        results += [result1, result2, result3]
    }

}

extension ShowtimeTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let musicRequest = MusicRequest(request: searchBarText)
        musicRequest.getMusicFromiTunes { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let music):
                self?.listOfResults = music
            }
        }
    }
}
