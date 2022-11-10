//
//  MyPageViewModel.swift
//  Workade
//
//  Created by Hyeonsoo Kim on 2022/10/27.
//

import Foundation

@MainActor
final class MyPageViewModel {
    let bookmarkManager = BookmarkManager.shared
    let userDefaultsManager = UserDefaultsManager.shared
    var clickedMagazineId = Binder("")
    var wishMagazines: [Magazine] = []
    
    /// 모델 데이터 fetch가 완료되었을 때, HomeViewController에 알려주는 역할을 할 Binder 타입의 변수
    var isCompleteFetch = Binder(false)
    
    init() {
        fetchWishMagazines()
        bindingBookmarkManager()
    }
    
    private func bindingBookmarkManager() {
        bookmarkManager.clickedMagazineId.bindAndFire(at: .myPage) { [weak self] id in
            guard let self = self else { return }
            self.clickedMagazineId.value = id
        }
    }
    
    func notifyClickedMagazineId(title id: String, key: String) {
        bookmarkManager.notifyClickedMagazineId(title: id, key: key)
    }
    
    private func fetchWishMagazines() {
        Task {
            guard let resource: MagazineResource = try await NetworkManager.shared.requestResourceData(urlString: Constants.magazineResourceAddress) else { return }
            wishMagazines = resource.content.filter {
                userDefaultsManager.loadUserDefaults(key: Constants.wishMagazine).contains($0.title)
            }
            isCompleteFetch.value = true
        }
    }
    
    deinit {
        bookmarkManager.clickedMagazineId.remove(at: .myPage)
    }
}
