//
//  MainViewController.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/26.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class HomeTableViewController: UITableViewController, View {
    private let homeView = HomeView()
    var disposeBag = DisposeBag()
    private let homeReactor = HomeReactor(networkService: MockNetWork())
    
    static func instance() -> HomeTableViewController {
        return HomeTableViewController(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.navigationController?.isNavigationBarHidden = true
        self.view = self.homeView
        self.reactor = homeReactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.homeReactor.action.onNext(.viewDidLoad)
    }
    
    // TODO: bind(reactor: HomeReactor) 함수가 불리는 시점은 언제일까?
    func bind(reactor: HomeReactor) {
        // Bind Action
        self.homeView.tableView.rx.itemSelected
            .map { Reactor.Action.tapModelCell(row: $0.row) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$detailViewPublisher)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] (model: MockModel) in
                self?.navigationController?.pushViewController(
                    DetailViewController.instance(model: model),
                    animated: true
                )
            })
            .disposed(by: self.disposeBag)
        
        //Bind State
        reactor.state
            .map { $0.models ?? [] }
            .asDriver(onErrorJustReturn: [])
            .drive(
                self.homeView.tableView.rx.items(
                cellIdentifier: HomeViewCell.id, cellType: HomeViewCell.self
            )) { row, model, cell in
                cell.bind(model)
            }
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.models }
            .asDriver(onErrorJustReturn: [])
            .drive { [weak self] in
                self?.homeView.changeSubViewsIsHidden(model: $0)
            }
            .disposed(by: self.disposeBag)
    }
}
