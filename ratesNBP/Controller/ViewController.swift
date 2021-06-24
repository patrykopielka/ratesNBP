//
//  ViewController.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ratesTableView: UITableView!
    
    
    var rateTable = ""
    var rateNo = ""
    var rateDate = ""
    var rates = [RateInfo]()
    
    var ratesManager = RatesManager()
    
    override func viewWillAppear(_ animated: Bool) {
        ratesManager.fetchData()
        ratesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratesManager.delegate = self
        ratesTableView.delegate = self
        ratesTableView.dataSource = self
        ratesTableView.register(UINib(nibName: "RateCell", bundle: nil), forCellReuseIdentifier: "rateCell")
    }
    
    
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        ratesManager.fetchData()
        ratesTableView.reloadData()
    }
    

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rateElement = rates[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "rateCell", for: indexPath)
            as! RateCell
        
        cell.rateCode.text = rateElement.code
        cell.rateName.text = rateElement.currency
        cell.rateDate.text = self.rateDate
        cell.rateMid.text = String(rateElement.mid)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: RatesManagerDelegate {
    
    func didUpdateFood(rateModel: RatesModel) {
        DispatchQueue.main.async {
            self.rateTable = rateModel.table
            self.rateDate = rateModel.date
            self.rates = rateModel.rates
        }
    }
    
    
}



