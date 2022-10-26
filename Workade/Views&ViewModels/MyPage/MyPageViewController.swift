//
//  MyPageViewController.swift
//  Workade
//
//  Created by Hyeonsoo Kim on 2022/10/26.
//

import UIKit

class MyPageViewController: UIViewController {
    private let titleView = TitleView(title: "매거진")
    
    private let wishLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 찜한 매거진"
        label.font = .customFont(for: .headline)
        label.textColor = .theme.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var wishMagazineCollectionView: UICollectionView = {
        let width = (view.bounds.width - 60) / 2
        let collectionView = UICollectionView(
            itemSize: CGSize(width: width, height: width*1.3),
            inset: .init(top: 0, left: 20, bottom: 20, right: 20),
            direction: .vertical)
        collectionView.dataSource = self
        collectionView.register(cell: MagazineCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        
        setupNavigationBar()
        setupLayout()
    }
}

// MARK: Navigates
extension MyPageViewController {
    @objc
    func popToHomeVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func pushToSettingVC() {
//        let vc = SettingViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Protocols
extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 임시 UI 보여주기용 수치입니다.
        // UI먼저 PR쏘고, 다음 PR에 ViewModel 및 각종 Manager 클래스들 순서대로 PR하겠습니다.
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MagazineCollectionViewCell = collectionView.dequeue(for: indexPath)
        return cell
    }
}

// MARK: UI setup 관련 Methods
extension MyPageViewController {
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: SFSymbol.chevronLeft.image,
            style: .done,
            target: self,
            action: #selector(popToHomeVC)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: SFSymbol.gearshapeFill.image,
            style: .done,
            target: self,
            action: #selector(pushToSettingVC)
        )
    }
    
    private func setupLayout() {
        view.addSubview(titleView)
        view.addSubview(wishLabel)
        view.addSubview(wishMagazineCollectionView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            wishLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 30),
            wishLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            wishMagazineCollectionView.topAnchor.constraint(equalTo: wishLabel.bottomAnchor, constant: 16),
            wishMagazineCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            wishMagazineCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
