//
//  DeviceRentalViewController.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 07.07.22.
//

import UIKit

final class DeviceRentalMainViewController: UIViewController {
    
    // MARK: - Data
    var iOSDevices: [DeviceRentalModel] = []
    var androidDevices: [DeviceRentalModel] = []
    
    // MARK: - Private properties
    private lazy var segmentedControlView: CustomSegmentedControl = {
        let segmntedControlView = CustomSegmentedControl()
        segmntedControlView.setButtonTitles(buttonTitles: ["IOS", "Android"])
        segmntedControlView.selectorViewColor = MColors.spray
        segmntedControlView.selectorTextColor = MColors.spray
        return segmntedControlView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    // Mocked data -> we can use it in model 
    private var devices = [
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 1", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 2", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 3", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 4", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 5", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 6", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 7", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 8", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 9", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 10", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 11", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .iOS, image: UIImage(named: "image")!, title: "iPhone 12", subtitle: "free", isBusy: false),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 1", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 2", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 3", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 4", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 5", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 6", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 7", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 8", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 9", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 10", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 11", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 12", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 13", subtitle: "Busy", isBusy: true),
        DeviceRentalModel(id: 0, operatingSystem: .android, image: UIImage(named: "image1")!, title: "Samsung 14", subtitle: "Busy", isBusy: true)
    ]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Аренда устройств"
        
        setupUI()
        setupMockData()
    }
}

// MARK: - Private
private extension DeviceRentalMainViewController {
    func setupUI() {
        
        let segmentedControlViewHeight: CGFloat = 50
        
        segmentedControlView.delegate = self
        
        segmentedControlView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControlView)
        NSLayoutConstraint.activate([
            segmentedControlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControlView.leftAnchor.constraint(equalTo: view.leftAnchor),
            segmentedControlView.rightAnchor.constraint(equalTo: view.rightAnchor),
            segmentedControlView.heightAnchor.constraint(equalToConstant: segmentedControlViewHeight),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DeviceRentalTableViewCell.self, forCellReuseIdentifier: DeviceRentalTableViewCell.reuseIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControlView.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func setupMockData() {
        iOSDevices = devices.filter({ $0.operatingSystem == .iOS })
        androidDevices = devices.filter({ $0.operatingSystem == .android })
    }
    
    func obtainContextualActionBy(deviceOS: OperatingSystem, indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, handler) in
            
            guard let self = self else { return }
            deviceOS == .iOS ? self.iOSDevices[indexPath.row].isBusy.toggle() : self.androidDevices[indexPath.row].isBusy.toggle()

            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

// MARK: - CustomSegmentedControlDelegate
extension DeviceRentalMainViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DeviceRentalMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControlView.selectedIndex == 0 ? iOSDevices.count : androidDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceRentalTableViewCell.reuseIdentifier, for: indexPath) as! DeviceRentalTableViewCell
        cell.selectionStyle = .none

        let device = segmentedControlView.selectedIndex == 0 ? iOSDevices[indexPath.row] : androidDevices[indexPath.row]
        cell.configure(by: device)
        cell.deviceStatusDidChanged(isBusy: device.isBusy)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let device = segmentedControlView.selectedIndex == 0 ? iOSDevices[indexPath.row] : androidDevices[indexPath.row]
        let rentDeviceAction = obtainContextualActionBy(deviceOS: device.operatingSystem, indexPath: indexPath)
        let image = device.isBusy ? UIImage(named: "vector") : UIImage(named: "cross")
        let backgroundColor = device.isBusy ? MColors.spray : MColors.heliotrope
        rentDeviceAction.image = image
        rentDeviceAction.backgroundColor = backgroundColor
        let configuration = UISwipeActionsConfiguration(actions: [rentDeviceAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
