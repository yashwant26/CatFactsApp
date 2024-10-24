//
//  CatFactVC.swift
//  CatFactsApp
//
//  Created by Yashwant Kumar on 23/10/24.
//

import UIKit
import SDWebImage

class CatFactVC: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catFactLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: CatViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel = CatViewModel()
        activityIndicator.hidesWhenStopped = true
        
        viewModel.catFact = { [weak self] fact in
            DispatchQueue.main.async {
                self?.catFactLabel.text = fact
            }
        }
        
        viewModel.catImageUrl = { [weak self] url in
            DispatchQueue.main.async {
                self?.showImageWithLoader(from: url)
            }
        }
        
        // Initial data fetch
        viewModel.fetchRandomCatFactAndImage()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fetchNewFactAndImage))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func showImageWithLoader(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        activityIndicator.startAnimating()
        
        catImageView.sd_setImage(with: url, placeholderImage: nil, options: [], progress: nil) { [weak self] _, _, _, _ in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    @objc func fetchNewFactAndImage() {
        viewModel.fetchRandomCatFactAndImage()
    }

}
