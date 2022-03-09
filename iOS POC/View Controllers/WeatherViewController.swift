//
//  WeatherViewController.swift
//  iOS POC
//
//  Created by NanduV on 07/03/22.
//

import Foundation
import UIKit
import SideMenu
import Charts

class WeatherViewController: UIViewController {
    
    var menu:SideMenuNavigationController?
    var weatherVM : WeatherViewModel?
    
    @IBOutlet weak var cityInfoLabel: UILabel!
    @IBOutlet weak var barChartView: LineChartView!
    @IBOutlet weak var cityNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameTextField.delegate = self
        
        weatherVM = WeatherViewModel()
        
        Utilities.setUpSideMenu(&menu, currentVC: self)
    }
    
    @IBAction func didTapHamburggerMenu(_ sender: UIBarButtonItem) {
        print("Hamburgger menu tapped")
        present(menu!,animated: true)
    }
    
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        print("Search pressed")
        if let city = cityNameTextField.text {
            getWeatherInfo(city: city)
        }
    }
    
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:dataPoints)

        barChartView.xAxis.granularity = 1
        barChartView.backgroundColor = Constants.Colors.backgroundColor

//        var dataEntries: [BarChartDataEntry] = []
//        for index in 0..<dataPoints.count {
//          let dataEntry = BarChartDataEntry(x: Double(index), y: Double(values[index]))
//          dataEntries.append(dataEntry)
//        }
//        let chartDataSet = BarChartDataSet(entries: dataEntries, label: Constants.weatherInfo.tempInC)
//        let chartData = BarChartData(dataSet: chartDataSet)
//        barChartView.data = chartData
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
          dataEntries.append(dataEntry)
        }
        print("data - \(dataEntries)")
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: Constants.weatherInfo.tempInC)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        barChartView.data = lineChartData
    }
    
    // get weather info
    func  getWeatherInfo(city:String) {
        
        weatherVM?.getLatandLongFromCity(cityName: city, completion: { (weatherInformation) in
            DispatchQueue.main.async {
//                self.customizeChart(dataPoints: self.players, values: self.goals.map{ Double($0) })
                if (weatherInformation != nil) {
                    self.cityInfoLabel.text = "\(Constants.weatherInfo.weatherIn)\(city)"
                    self.customizeChart(dataPoints: weatherInformation!.dateTime, values: (weatherInformation!.temperature.map{ Double($0) }))
                }
                else {
                    self.presentAlertWithTitle(title: nil, message: Constants.CustomStrings.cityError , options: Constants.AlertOptions.okButton) { (option) in
                               print("option: \(option)")
                               switch(option) {
                                   case Constants.AlertOptions.okButton:
                                       break
                                   default:
                                       break
                               }
                           }
                }
            }
        })
    }
}

