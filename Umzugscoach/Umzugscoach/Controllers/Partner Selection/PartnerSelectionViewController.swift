//
//  PartnerSelectionViewController.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/25/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit

class PartnerSelectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var partners: [Partner] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableViewAnimation()
        delay(1.0) {
            self.setupData()
            self.animateTableView()
        }
    }
    
    func setupNavigationBar() {
        title = Config.strings.vertragspartner
    }
    
    func setupTableViewAnimation() {
        tableView.transform = CGAffineTransform(translationX: 0, y: tableView.frame.height)
    }
    
    func setupData() {
        partners = Partner.getPartners()
        tableView.reloadData()
    }
    
    func animateTableView() {
        UIView.animate(withDuration: 0.2) {
            self.tableView.transform = .identity
        }
    }
    
    @IBAction func continueBtnPressed() {
        performSegue(withIdentifier: Config.identifiers.congratulationViewControllerSegue, sender: nil)
    }
}

extension PartnerSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return partners.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Config.identifiers.partnerTableViewCell, for: indexPath) as! PartnerSelectionTableViewCell
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: PartnerSelectionTableViewCell, atIndexPath indexPath: IndexPath) {
        let index = indexPath.section
        let partner = partners[index]
        cell.nameLabel.text = partner.name
        cell.checkboxImageView.image = partner.selected ? #imageLiteral(resourceName: "check-on") : #imageLiteral(resourceName: "check-off")
        cell.customContainerView.backgroundColor = partner.selected ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2035530822) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2016534675)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.section
        partners[index].selected = !partners[index].selected
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return {
            let footerView = UIView()
            footerView.backgroundColor = .clear
            return footerView
        }()
    }
}
