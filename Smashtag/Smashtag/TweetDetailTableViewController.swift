//
//  TweetDetailTableViewController.swift
//  Smashtag
//
//  Created by C4Q  on 6/23/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
import Twitter

class TweetDetailTableViewController: UITableViewController {

    enum TweetContent {
        case Media(Twitter.MediaItem)
        case Hashtag(Twitter.Mention)
        case User(Twitter.Mention)
        case URL(Twitter.Mention)
    }
    
    var categories = [[TweetContent]]()
    
    var selectedTweet: Twitter.Tweet? {
        didSet {
            if let tweet = selectedTweet {
                categories = [[TweetContent]]()
                if !tweet.media.isEmpty {categories.append((tweet.media.map{TweetContent.Media($0)}))}
                if !tweet.hashtags.isEmpty {categories.append((tweet.hashtags.map{TweetContent.Hashtag($0)}))}
                if !tweet.userMentions.isEmpty {categories.append((tweet.userMentions.map{TweetContent.User($0)}))}
                if !tweet.urls.isEmpty {categories.append((tweet.urls.map{TweetContent.URL($0)}))}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch categories[section][0] {
        case .Media:
            return "Images"
        case .Hashtag:
            return "Hashtags"
        case .URL:
            return "URLs"
        case .User:
            return "Users"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch categories[indexPath.section][indexPath.row] {
        case .Media(let mediaItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath)
            if let mediaCell = cell as? MediaDetailTableViewCell {
                mediaCell.selectedMediaItem = mediaItem
            }
            return cell
        case .Hashtag(let mention), .URL(let mention), .User(let mention):
            let cell = tableView.dequeueReusableCell(withIdentifier: "mentionCell", for: indexPath)
            cell.textLabel?.text = mention.keyword
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch categories[indexPath.section][indexPath.row] {
        case .Media(let mediaItem):
            let cellWidth = self.view.frame.maxX - self.view.frame.minX
            return cellWidth / CGFloat(mediaItem.aspectRatio)
        default:
            return UITableViewAutomaticDimension
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTweetContent = categories[indexPath.section][indexPath.row]
        switch selectedTweetContent {
        case .Hashtag(let mention), .User(let mention):
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "tweetVC") as? TweetTableViewController
            destination?.searchText = mention.keyword
            self.navigationController?.pushViewController(destination!, animated: true)
        case .Media(let media):
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "imageVC") as? ImageViewController
            destination?.imageURL = media.url
            self.navigationController?.pushViewController(destination!, animated: true)
        case .URL(let mention):
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "browserVC") as? BrowserViewController
            destination?.url = URL(string: mention.keyword)
            self.navigationController?.pushViewController(destination!, animated: true)
        }
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let indexPath = tableView.indexPathForSelectedRow!
//        let selectedTweetContents = categories[indexPath.section][indexPath.row]
//        switch segue.identifier ?? "" {
//        case "hashtagOrUserSegue":
//            var destinationVC = segue.destination
//            if let navController = destinationVC as? UINavigationController {
//                destinationVC = navController.visibleViewController ?? destinationVC
//            }
//            if let destination = destinationVC as? TweetTableViewController {
//                if let cell = sender as? UITableViewCell {
//                    destination.searchText = newText
//                }
//            }
//        case "imageSegue":
//            if let destination = segue.destination as? ImageViewController {
//                if let url = sender as? URL {
//                    destination.imageURL = url
//                }
//            }
//        case "urlSegue":
//            break
//        default:
//            break
//        }
//    }
}


/*  Old Segue Method
 
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 let selectedTweetContent = categories[indexPath.section][indexPath.row]
 switch selectedTweetContent {
 case .Hashtag(let mention), .User(let mention):
 performSegue(withIdentifier: "hashtagOrUserSegue", sender: mention.keyword)
 case .Media(let media):
 performSegue(withIdentifier: "imageSegue", sender: media.url)
 case .URL(let mention):
 performSegue(withIdentifier: "urlSegue", sender: mention.keyword)
 }
 }
 
 
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 switch segue.identifier ?? "" {
 case "hashtagOrUserSegue":
 var destinationVC = segue.destination
 if let navController = destinationVC as? UINavigationController {
 destinationVC = navController.visibleViewController ?? destinationVC
 }
 if let destination = destinationVC as? TweetTableViewController {
 if let newText = sender as? String {
 destination.searchText = newText
 }
 }
 case "imageSegue":
 if let destination = segue.destination as? ImageViewController {
 if let url = sender as? URL {
 destination.imageURL = url
 }
 }
 case "urlSegue":
 break
 default:
 break
 }
 }
 }

 
 */





/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

