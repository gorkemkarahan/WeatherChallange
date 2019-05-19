//
//  CityWeatherViewController.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityGeneralInfoView: CityGeneralInfoView!
    
    //MARK: Private members
    private let kCellIdentifier = String(describing: WeatherDayTableViewCell.self)
    private let refreshControl = UIRefreshControl()
    private var dataSource: CityWeatherDataProvider = CityWeatherOnlineDataSource()
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: kCellIdentifier, bundle: nil), forCellReuseIdentifier: kCellIdentifier)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshData()
    }
    
    //MARK: Main Functions
    @objc func refreshData() {
        if dataSource.needsFetch() {
            refreshControl.beginRefreshing()
            cityGeneralInfoView.switchToLoading(true)
            dataSource.fetchData { [weak self] (message, error) in
                self?.refreshControl.endRefreshing()
                self?.cityGeneralInfoView.switchToLoading(false)
                
                if let err = error {
                    let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    self?.cityGeneralInfoView.prepare(for: self?.dataSource.city, forecast: self?.dataSource.forecasts(for: 0)?[0])
                    self?.tableView.reloadData()
                }
            }
        } else {
            refreshControl.endRefreshing()
        }
    }
    
    //NOTE: single data source used for demonstration but datasources already have a needsFetch function depending on how frequent this called it might be better to keep references to datasources and create if datasource not exists
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dataSource = CityWeatherOnlineDataSource()
        } else {
            dataSource = CityWeatherFileDataSource()
        }
        refreshData()
    }
}

//MARK: UITableViewDataSource
extension CityWeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? WeatherDayTableViewCell {
            cell.forecasts = dataSource.forecasts(for: indexPath.section)
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
}

//MARK: UITableViewDelegate
extension CityWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = WeatherDayTableViewSectionHeader()
        headerView.titleLabel.text = Formatters.shared.normalizedDate(from: dataSource.forecasts(for: section)?.first?.dt ?? 0) 
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
