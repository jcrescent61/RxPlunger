//
//  HomeView.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/27.
//

import UIKit

import SnapKit
import Then
import RxSwift

final class HomeView: UIView {
    
    private let topBarView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let emptyView = HomeListEmptyView().then {
        $0.isHidden = true
    }
    
    private let topBarTitleLabel = UILabel().then {
        $0.text = "야아 명언들"
        $0.font = .preferredFont(forTextStyle: .subheadline)
        $0.textColor = .black
    }
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.tableView.backgroundColor = .white
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(
            HomeViewCell.self,
            forCellReuseIdentifier: HomeViewCell.id
        )
        self.addSubviews(
            topBarView,
            emptyView,
            topBarTitleLabel,
            tableView
        )
    }
    
    private func bindConstraints() {
        self.topBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        self.emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.topBarTitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(topBarView)
            $0.bottom.equalTo(topBarView.snp.bottom).offset(-20)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func changeSubViewsIsHidden(model: [MockModel]?) {
        if let model = model {
            if model.isEmpty {
                self.emptyView.isHidden = false
                self.emptyView.isHiddenEmptyView(false)
                self.tableView.isHidden = true
            } else {
                self.emptyView.isHidden = true
                self.tableView.isHidden = false
            }
        } else {
            self.emptyView.isHidden = false
            self.emptyView.isHiddenEmptyView(true)
            self.tableView.isHidden = true
        }
    }
}
