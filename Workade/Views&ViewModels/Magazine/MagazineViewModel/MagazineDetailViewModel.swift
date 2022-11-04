//
//  MagazineDetailViewModel.swift
//  Workade
//
//  Created by Hong jeongmin on 2022/11/04.
//

import UIKit

@MainActor
class MagazineDetailViewModel {
    private let networkManager = NetworkingManager.shared
    private let bookmarkManager = BookmarkManager.shared
        
    var data: Binder<[MagazineDetailModel]> = Binder([])
    
    func fetchMagazine(url: URL?) async {
        var magazineDetailData: [MagazineDetailModel] = []
        
        guard let dataUrl = url else { return }
        
        let result = await networkManager.request(url: dataUrl)
        guard let result = result else { return }
        
        do {
            let magazineData = try JSONDecoder().decode(MagazineDataModel.self, from: result)
            magazineData.magazineData.forEach { detailData in
                magazineDetailData.append(detailData)
            }
        } catch {
            print(error)
        }
        
        data.value = magazineDetailData
    }
    
    func fetchURL(urlString: String) -> URL? {
        guard let url = URL(string: urlString) else { return nil }
        
        return url
    }
}
