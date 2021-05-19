////
////  MKDatePicker.swift
////  MiaoKiit
////
////  Created by miaokii on 2021/5/19.
////
//
//import UIKit
//
//class MKDatePicker: MKPopViewController{
//
//    /// 显示时间选择
//    private let datePicker = UIDatePicker.init()
//
//    var dateClosure:((Date)->Void)?
//    var datePickerMode: UIDatePicker.Mode = .date
//    var date = Date()
//    var maximumDate = Date()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        popStyle = .bottom
//        hideOnTapBackground = false
//
//        contentView.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.3).priority(.low)
//            make.left.right.equalToSuperview()
//        }
//
//        let cancelBtn = UIButton.init(super: contentView,
//                                      title: "取消",
//                                      titleColor: .text_l3,
//                                      font: .systemFont(ofSize: 15))
//        cancelBtn.snp.makeConstraints { (make) in
//            make.top.equalTo(15)
//            make.left.equalTo(15)
//        }
//
//        cancelBtn.setClosure { [unowned self] (_) in
//            self.hide()
//        }
//
//        let confirmBtn = UIButton.init(super: contentView,
//                                      title: "确认",
//                                      titleColor: .text_l1,
//                                      font: .systemFont(ofSize: 15))
//        confirmBtn.snp.makeConstraints { (make) in
//            make.top.equalTo(15)
//            make.right.equalTo(-15)
//        }
//
//        confirmBtn.setClosure { [unowned self] (_) in
//            self.hide {
//                self.dateClosure?(datePicker.date)
//            }
//        }
//
//        let topLine = UIView.init(super: contentView,
//                                  backgroundColor: .table_bg)
//        topLine.snp.makeConstraints { (make) in
//            make.top.equalTo(cancelBtn.snp.bottom).offset(15)
//            make.height.equalTo(1)
//            make.left.right.equalToSuperview()
//        }
//
//        datePicker.datePickerMode = datePickerMode
//        datePicker.tintColor = .theme
//        datePicker.date = date
//        datePicker.locale = Locale.current
//        datePicker.maximumDate = maximumDate
//        if #available(iOS 13.4, *) {
//            datePicker.locale = Locale.init(identifier: "zh_CN")
//            datePicker.preferredDatePickerStyle = .wheels
//        }
//        contentView.addSubview(datePicker)
//        datePicker.snp.makeConstraints { (make) in
//            make.left.equalTo(15)
//            make.right.equalTo(-15)
//            make.bottom.equalTo(-bottomSafeAreaHeight-15)
//            make.top.equalTo(topLine.snp.bottom).offset(15)
//        }
//    }
//
//    ///
//    @objc private func confirmAction() {
//        hide { [unowned self] in
//            self.dateClosure?(self.datePicker.date)
//        }
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        contentView.round(corners: [.topLeft, .topRight], radius: 8)
//    }
//}
