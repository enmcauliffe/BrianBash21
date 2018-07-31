//
//  ThirdViewController.swift
//  BrianBash21
//
//  Created by Jal Irani on 7/30/18.
//  Copyright © 2018 Erin McAuliffe. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var card = ["Hello", "Hello", "Hello", "Hello", "Hello"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return card.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        cell.textLabel?.text = "Name poop"
        cell.detailTextLabel?.text = "Some kind of text Some kind of text Some kind of text Some kind of text Some kind of text Some kind of text Some kind of text Some kind of text  Some kind of text Some kind of text Some kind of text Some kind of text Some kind of text Some kind of text Some kind of text Some kind of text"
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
