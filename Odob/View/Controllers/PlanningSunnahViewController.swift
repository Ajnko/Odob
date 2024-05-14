//
//  PlanningSunnahViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 10/05/24.
//

import UIKit
import SnapKit

class PlanningSunnahViewController: UIViewController {

    //MARK: - Properties
    let sunnahSelectingLabel = Label(text: "Select Sunnah", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 22), numberOfLines: 0)
    let fromLabel = Label(text: "From", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    let toLabel = Label(text: "To", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    let numberOfDaysLabel = Label(text: "Number of Days", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    let notificationLabel = Label(text: "Notification", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    let notificationTimeLabel = Label(text: "Notification Time", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    
    @objc let addPlannerButton: UIButton = {
       let button = UIButton()
        button.setTitle("Add Planner", for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.backgroundColor = .mainBlack
        button.layer.cornerRadius = 15
        button.tintColor = .mainColor
        button.addTarget(self, action: #selector(getter: addPlannerButton), for: .touchUpInside)
        return button
    }()
    
    let fromSunnahLabel = Label(text: "From Sunnah Name", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 13), numberOfLines: 2)
    
    let fromSunnahChoosingButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
        button.tintColor = .mainColor
        button.backgroundColor = .mainBlack
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(fromSunnahButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let toSunnahLabel = Label(text: "To Sunnah Name", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 13), numberOfLines: 2)
    
    let toSunnahChoosingButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
        button.tintColor = .mainColor
        button.backgroundColor = .mainBlack
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(toSunnahButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let numberOfDaysTextField: UITextField = {
       let field = UITextField()
        field.tintColor = .textColor
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.textColor.cgColor
        return field
    }()
    
    let switchButton: UISwitch = {
       let button = UISwitch()
        button.onTintColor = .mainBlack
        button.isOn = true
        button.addTarget(self, action: #selector(switchButtonToggled), for: .valueChanged)
        return button
    }()
    
    let timeSettingButton: UIButton = {
       let button = UIButton()
//        button.setTitle("12:00", for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.addTarget(self, action: #selector(timeSettingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let sunnahPickerView: UIPickerView = {
       let pickerview = UIPickerView()
        return pickerview
    }()
    
    let toSunnahPickerView: UIPickerView = {
       let pickerview = UIPickerView()
        return pickerview
    }()
    
    var isOn: Bool = true

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
        timeSettingButton.snp.makeConstraints { make in
            make.top.equalTo(notificationTimeLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-10)
            make.width.equalTo(view.snp.width).multipliedBy(0.15)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
        }
        
        view.addSubview(addPlannerButton)
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
    
    func savingToUserDefaults() {
        
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
    }
    
    
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.sound = .default
        
        // Get selected sunnahs
        let selectedSunnahs = sunnahTypes[selectedFromSunnahTypeIndex].sunnahs[selectedFromSunnahTypeIndex...selectedToSunnahTypeIndex]
        
        // Create notification trigger for daily notifications
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true) // 86400 seconds = 1 day
        
        // Loop through each selected sunnah and schedule a separate notification for each
        for sunnah in selectedSunnahs {
            // Customize the notification content
            content.body = sunnah.name // Change the content body to the sunnah name or any other desired content
            
            // Create a unique identifier for each notification
            let identifier = UUID().uuidString
            
            // Create notification request
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            // Schedule the notification
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        }
    }


    
    @objc func timeSettingButtonTapped() {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        
        // Create alert controller
        let alertController = UIAlertController(title: "Select Notification Time", message: nil, preferredStyle: .actionSheet)
        
        // Add time picker to alert controller
        alertController.view.addSubview(timePicker)
        
        // Create done action
        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            let selectedTime = timePicker.date
            let components = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
            
            // Set the title of timeSettingButton to the selected time
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let selectedTimeString = formatter.string(from: selectedTime)
            self.timeSettingButton.setTitle(selectedTimeString, for: .normal)
            
            // Schedule notifications for the selected time
            self.scheduleNotifications(at: components)
        }
        
        // Create cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to alert controller
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }


    func scheduleNotifications(at time: DateComponents) {
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.sound = .default
        
        // Get selected sunnahs
        let selectedSunnahs = sunnahTypes[selectedFromSunnahTypeIndex...selectedToSunnahTypeIndex]
        
        // Iterate over each SunnahType
        for sunnahType in selectedSunnahs {
            // Iterate over each Sunnah in the SunnahType
            for sunnah in sunnahType.sunnahs {
                content.body += "\(sunnah.name)\n"
            }
        }
        
        // Create notification trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
        
        // Create notification request
        for (index, _) in selectedSunnahs.enumerated() {
            let identifier = "SunnahReminder-\(index)"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            // Schedule the notification
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        }
    }


    @objc func switchButtonToggled() {
        if switchButton.isOn {
            // Resume notifications
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                let identifiers = requests.map { $0.identifier }
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
                self.scheduleLocalNotification()
            }
        } else {
            // Stop notifications
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    @objc func addPlannerButtonTapped() {
        scheduleLocalNotification()
        dismiss(animated: true)
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

extension PlanningSunnahViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let allowedCharacters = CharacterSet.decimalDigits
        

        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

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
