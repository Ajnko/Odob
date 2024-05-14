//
//  PlanningSunnahViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 10/05/24.
//

import UIKit
import SnapKit

@available(iOS 15.0, *)
class PlanningSunnahViewController: UIViewController {
    
    //MARK: - Properties
    private let sunnahSelectingLabel = Label(text: "Select Sunnah", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 22), numberOfLines: 0)
    private let fromLabel = Label(text: "From", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    private let toLabel = Label(text: "To", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    private let numberOfDaysLabel = Label(text: "Number of Days", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    private let notificationLabel = Label(text: "Notification", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    private let notificationTimeLabel = Label(text: "Notification Time", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    @objc let addPlannerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Planner", for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.backgroundColor = .mainBlack
        button.layer.cornerRadius = 15
        button.tintColor = .mainColor
        return button
    }()
    
    private let fromSunnahLabel = Label(text: "From Sunnah Name", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 13), numberOfLines: 2)
    
    private let fromSunnahChoosingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
        button.tintColor = .mainColor
        button.backgroundColor = .mainBlack
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let toSunnahLabel = Label(text: "To Sunnah Name", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 13), numberOfLines: 2)
    
    private let toSunnahChoosingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
        button.tintColor = .mainColor
        button.backgroundColor = .mainBlack
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let numberOfDaysTextField: UITextField = {
        let field = UITextField()
        field.tintColor = .textColor
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.textColor.cgColor
        return field
    }()
    
    private let switchButton: UISwitch = {
        let button = UISwitch()
        button.onTintColor = .mainBlack
        button.isOn = true
        return button
    }()
    
    private let timeSettingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Time", for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        return button
    }()
    
    private let sunnahPickerView: UIPickerView = {
        let pickerview = UIPickerView()
        return pickerview
    }()
    
    private let toSunnahPickerView: UIPickerView = {
        let pickerview = UIPickerView()
        return pickerview
    }()
    
    private var isOn: Bool = true
    
    private var sunnahTypes: [SunnahType] = Information.sunnahs
    private var selectedFromSunnahTypeIndex: Int = 0
    private var selectedToSunnahTypeIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingToUserDefaults()
        
        view.backgroundColor = .mainColor
        setupUI()
        
        sunnahPickerView.delegate = self
        sunnahPickerView.dataSource = self
        sunnahPickerView.isHidden = isOn
        toSunnahPickerView.delegate = self
        toSunnahPickerView.dataSource = self
        toSunnahPickerView.isHidden = isOn
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        numberOfDaysTextField.delegate = self
        numberOfDaysTextField.leftView = paddingView
        numberOfDaysTextField.leftViewMode = .always
        numberOfDaysTextField.keyboardType = .numberPad
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        // Assign the toolbar as the input accessory view for the text field
        numberOfDaysTextField.inputAccessoryView = toolbar
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            } else {
                print("Notification authorization granted: \(granted)")
            }
        }
        
        
        
    }
    
    private func setupUI() {
        view.addSubview(sunnahSelectingLabel)
        sunnahSelectingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(10)
        }
        
        view.addSubview(fromLabel)
        fromLabel.snp.makeConstraints { make in
            make.top.equalTo(sunnahSelectingLabel.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(10)
        }
        
        //button to choose from which sunnah begin
        view.addSubview(fromSunnahChoosingButton)
        fromSunnahChoosingButton.addTarget(self, action: #selector(fromSunnahButtonTapped), for: .touchUpInside)
        fromSunnahChoosingButton.snp.makeConstraints { make in
            make.top.equalTo(fromLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        view.addSubview(fromSunnahLabel)
        fromSunnahLabel.snp.makeConstraints { make in
            make.top.equalTo(fromLabel.snp.top)
            make.right.equalTo(fromSunnahChoosingButton.snp.left).offset(-8)
        }
        
        view.addSubview(toLabel)
        toLabel.snp.makeConstraints { make in
            make.top.equalTo(fromLabel.snp.bottom).offset(35)
            make.left.equalTo(view.snp.left).offset(10)
        }
        
        //button to choose at which sunnah to stop
        view.addSubview(toSunnahChoosingButton)
        toSunnahChoosingButton.addTarget(self, action: #selector(toSunnahButtonTapped), for: .touchUpInside)
        toSunnahChoosingButton.snp.makeConstraints { make in
            make.top.equalTo(toLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        view.addSubview(toSunnahLabel)
        toSunnahLabel.snp.makeConstraints { make in
            make.top.equalTo(toLabel.snp.top)
            make.right.equalTo(toSunnahChoosingButton.snp.left).offset(-8)
        }
        
        //number of days
        view.addSubview(numberOfDaysLabel)
        numberOfDaysLabel.snp.makeConstraints { make in
            make.top.equalTo(toLabel.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left).offset(10)
        }
        
        view.addSubview(numberOfDaysTextField)
        numberOfDaysTextField.snp.makeConstraints { make in
            make.top.equalTo(numberOfDaysLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-10)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
        
        view.addSubview(notificationLabel)
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(numberOfDaysLabel.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(10)
        }
        
        view.addSubview(switchButton)
        switchButton.addTarget(self, action: #selector(switchButtonToggled), for: .valueChanged)
        switchButton.snp.makeConstraints { make in
            make.top.equalTo(notificationLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-10)
            make.width.equalTo(50)
            make.height.equalTo(32)
        }
        
        view.addSubview(notificationTimeLabel)
        notificationTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(notificationLabel.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(10)
        }
        
        view.addSubview(timeSettingButton)
        timeSettingButton.addTarget(self, action: #selector(timeSettingButtonTapped), for: .touchUpInside)
        timeSettingButton.snp.makeConstraints { make in
            make.top.equalTo(notificationTimeLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-10)
            make.width.equalTo(view.snp.width).multipliedBy(0.15)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
        }
        
        view.addSubview(addPlannerButton)
        addPlannerButton.addTarget(self, action: #selector(getter: addPlannerButton), for: .touchUpInside)
        addPlannerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(notificationTimeLabel.snp.bottom).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.6)
            make.height.equalTo(view.snp.height).multipliedBy(0.1)
        }
        
        //pickerview
        view.addSubview(sunnahPickerView)
        sunnahPickerView.snp.makeConstraints { make in
            make.top.equalTo(notificationLabel.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.height.equalTo(150)
        }
        
        view.addSubview(toSunnahPickerView)
        toSunnahPickerView.snp.makeConstraints { make in
            make.top.equalTo(notificationLabel.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.height.equalTo(150)
        }
        
    }
    
    private func savingToUserDefaults() {
        
        if let numberOfDays = UserDefaults.standard.value(forKey: "numberOfDays") as? Int {
            numberOfDaysTextField.text = "\(numberOfDays)"
        }
        
        if let selectedFromIndex = UserDefaults.standard.value(forKey: "selectedFromSunnahIndex") as? Int {
            selectedFromSunnahTypeIndex = selectedFromIndex
            fromSunnahLabel.text = sunnahTypes[selectedFromIndex].typeName
        }
        
        if let selectedToIndex = UserDefaults.standard.value(forKey: "selectedToSunnahIndex") as? Int {
            selectedToSunnahTypeIndex = selectedToIndex
            toSunnahLabel.text = sunnahTypes[selectedToIndex].typeName
        }
        
        if let savedTime = UserDefaults.standard.string(forKey: "notificationTime") {
            self.timeSettingButton.setTitle(savedTime, for: .normal)
        }
    }
    
    func scheduleLocalNotification() {
        // Get the current date
        let currentDate = Date()
        
        // Create a date component for the next day
        var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: currentDate)
        dateComponents.day! += 1
        
        // Create a date from the next day's components
        guard let nextDate = Calendar.current.date(from: dateComponents) else {
            print("Error creating next date")
            return
        }
        
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Sunnah Reminder"
        content.sound = .default
        
        // Get selected sunnahs
        let selectedSunnahs = sunnahTypes[selectedFromSunnahTypeIndex].sunnahs[selectedFromSunnahTypeIndex...selectedToSunnahTypeIndex]
        
        // Create notification trigger for daily notifications
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true) // 86400 seconds = 1 day
        
        // Iterate over each selected sunnah
        for (index, sunnah) in selectedSunnahs.enumerated() {
            // Customize the notification content
            content.body = sunnah.name // Change the content body to the sunnah name or any other desired content
            
            // Calculate the fire date for the current sunnah
            let fireDate = nextDate.addingTimeInterval(TimeInterval(index * 86400)) // Add 1 day for each sunnah
            
            // Create notification request
            let request = UNNotificationRequest(identifier: "SunnahReminder-\(index)", content: content, trigger: UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: fireDate), repeats: false))
            
            // Schedule the notification
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled successfully for \(fireDate)")
                }
            }
        }
    }
    
    
    
    @objc func timeSettingButtonTapped() {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        alertController.view.addSubview(timePicker)
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            let selectedTime = timePicker.date
            let components = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let selectedTimeString = formatter.string(from: selectedTime)
            self.timeSettingButton.setTitle(selectedTimeString, for: .normal)
            
            UserDefaults.standard.set(selectedTimeString, forKey: "notificationTime")
            self.scheduleNotifications(at: components)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func scheduleNotifications(at components: DateComponents) {
        cancelExistingNotifications()
        
        let content = UNMutableNotificationContent()
        content.title = "Sunnah Reminder"
        content.sound = .default
        
        let selectedSunnahs = sunnahTypes[selectedFromSunnahTypeIndex].sunnahs[selectedFromSunnahTypeIndex...selectedToSunnahTypeIndex]
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        for (index, sunnah) in selectedSunnahs.enumerated() {
            content.body = sunnah.name
            
            let identifier = "Sunnah Reminde- \(index)"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        }
    }
    
    private func cancelExistingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    @objc func switchButtonToggled() {
        
    }
    
    @objc func addPlannerButtonTapped() {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
        
        scheduleNotifications(at: dateComponents)
        
        self.dismiss(animated: true)
    }
    
    
    @objc func doneButtonTapped() {
        // Dismiss the keyboard
        numberOfDaysTextField.resignFirstResponder()
        
        if let numberOfDays = Int(numberOfDaysTextField.text ?? "") {
            UserDefaults.standard.set(numberOfDays, forKey: "numberOfDays")
        }
    }
    
    @objc func fromSunnahButtonTapped() {
        sunnahPickerView.isHidden = !isOn
        addPlannerButton.isHidden = isOn
        toSunnahPickerView.isHidden = true
        isOn.toggle()
    }
    
    @objc func toSunnahButtonTapped() {
        toSunnahPickerView.isHidden = isOn
        addPlannerButton.isHidden = !isOn
        sunnahPickerView.isHidden = true
        isOn.toggle()
    }
    
}

@available(iOS 15.0, *)
extension PlanningSunnahViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        
        
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

@available(iOS 15.0, *)
extension PlanningSunnahViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sunnahTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sunnahTypes[row].typeName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sunnahPickerView {
            selectedFromSunnahTypeIndex = row
            fromSunnahLabel.text = sunnahTypes[row].typeName
            
            UserDefaults.standard.set(row, forKey: "selectedFromSunnahIndex")
        } else if pickerView == toSunnahPickerView {
            selectedToSunnahTypeIndex = row
            toSunnahLabel.text = sunnahTypes[row].typeName
            
            UserDefaults.standard.set(row, forKey: "selectedToSunnahIndex")
        }
    }
}
