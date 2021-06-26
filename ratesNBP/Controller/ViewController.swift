//
//  ViewController.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ratesTableView: UITableView!
    @IBOutlet weak var tableAButton: UIButton!
    @IBOutlet weak var tableBButton: UIButton!
    @IBOutlet weak var tableCButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var ratesManager = RatesManager()
    var rates = [RateInfo]()
    var rateTable = "A"
    var rateCode = ""
    var rateDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableAButton.layer.cornerRadius = 5
        tableAButton.layer.borderWidth = 1
        tableBButton.layer.cornerRadius = 5
        tableBButton.layer.borderWidth = 1
        tableCButton.layer.cornerRadius = 5
        tableCButton.layer.borderWidth = 1
        refreshButton.layer.cornerRadius = 5
        refreshButton.layer.borderWidth = 1
        
        title = "Exchange Rates"
        ratesManager.fetchData(table: "A")
        ratesManager.delegate = self
        ratesTableView.delegate = self
        ratesTableView.dataSource = self
        ratesTableView.register(UINib(nibName: "RateCell", bundle: nil), forCellReuseIdentifier: "rateCell")
    }
    
    @IBAction func tableChanged(_ sender: UIButton) {
        tableAButton.isSelected = false
        tableBButton.isSelected = false
        tableCButton.isSelected = false
        sender.isSelected = true
        ratesTableView.setContentOffset(ratesTableView.contentOffset, animated: false)
        
        if tableAButton.isSelected{
            rateTable = "A"
            ratesManager.fetchData(table: rateTable)
        }
        if tableBButton.isSelected{
            rateTable = "B"
            ratesManager.fetchData(table: rateTable)
        }
        if tableCButton.isSelected{
            rateTable = "C"
            ratesManager.fetchData(table: rateTable)
        }
        createSpinnerView()
    }
    
    
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        ratesManager.fetchData(table: rateTable)
        ratesTableView.reloadData()
        createSpinnerView()
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
        if rateTable == "C" {
            cell.rateMid.text = "bid: "+String(rateElement.bid!)
            cell.rateAsk.text = "ask: "+String(rateElement.ask!)
        } else {
            cell.rateMid.text = "mid: "+String(rateElement.mid!)
            cell.rateAsk.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rateElement = rates[indexPath.row]
        rateCode = rateElement.code
        self.performSegue(withIdentifier: "goToRate", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: RatesManagerDelegate {
    func didUpdateRate(rateModel: RatesModel) {
        DispatchQueue.main.async {
            self.rateDate = rateModel.date
            self.rates = rateModel.rates
            self.ratesTableView.reloadData()
        }
    }
}


extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRate" {
            let destinationVC = segue.destination as! RateViewController
            destinationVC.title = rateCode
            destinationVC.rateCode = rateCode
            destinationVC.rateTable = rateTable
        }
    }
}

extension ViewController {
    func createSpinnerView() {
        let child = SpinnerViewController()

        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}



