//
//  ProfileEditController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 07/11/21.
//

import UIKit
import Combine
import Kingfisher

class ProfileEditController: BaseUIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var editImageButton: UIButton!
    var user: User?
    private var profileVM = ProfileViewModel()
    private let titleLabel = ["Nama", "No. Telepon", "Alamat Email", "Nama Bisnis", "Kategori Bisnis"]
    private var isEdit = false
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setUpNavigationBar()
        
        profileVM.profileData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.configure()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
        profileVM.fetchProfile()
    }
    
    func configure() {
        if !(profileVM.profileData.value?.isEmpty ?? false) {
            if let user = profileVM.profileData.value?.first {
                self.user = user
                title = user.name
                guard let url = URL(string: RemoteURL.image.rawValue + user.profilePicture) else { return }
                setupImage(url: url)
                tableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        containerView.addShadow()
        containerView.backgroundColor = .white
        imageContainer.layer.cornerRadius = 61
        imageContainer.clipsToBounds = true
        editImageButton.backgroundColor = .inactive
        editImageButton.alpha = 0.85
        view.backgroundColor = .blueBackground
    }
    
    private func setupImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: profileImage.bounds.size)
        profileImage.kf.indicatorType = .activity
        profileImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.registerNib(forCell: ProfileEditCell.self)
    }
    
    @IBAction func editProfileImage(_ sender: UIButton) {
        print("Edit Image")
        
    }
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.isHidden = false
        navigation.navigationItem.hidesBackButton = true
        navigation.navigationBar.tintColor = .primaryGreen
//        let ubahButton = UIBarButtonItem(title: "Ubah", style: .plain, target: self, action: #selector(editButton(_:)))
//        self.navigationItem.rightBarButtonItems = [ubahButton]
        self.addBackButton()
    }
    
    private func setupEditNavigationBar() {
        self.navigationItem.hidesBackButton = true
        let cancelButton = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(cancelButton(_:)))
        cancelButton.tintColor = .alert
        let doneButton = UIBarButtonItem(title: "Simpan", style: .done, target: self, action: #selector(cancelButton(_:)))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func editButton(_ sender: UIBarButtonItem) {
        setupEditNavigationBar()
        isEdit = true
    }
    
    @objc private func cancelButton(_ sender: UIBarButtonItem) {
        setUpNavigationBar()
        isEdit = false
    }
    
    @objc private func doneButton(_ sender: UIBarButtonItem) {
        setUpNavigationBar()
        isEdit = false
    }
}

// MARK: - Table
extension ProfileEditController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configure(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.name ?? "")
            cell.profileEditPublisher
                .sink { [ unowned self ] in
                    self.profileVM.fetchProfile()
                }
                .store(in: &subscribers)
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configureNoButton(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.phoneNumber ?? "")
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configureNoButton(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.email ?? "")
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configure(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.businessName ?? "")
            cell.profileEditPublisher
                .sink { [ unowned self ] in
                    self.profileVM.fetchProfile()
                }
                .store(in: &subscribers)
            return cell
        case 4 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configure(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.businessCategory ?? "")
            cell.profileEditPublisher
                .sink { [ unowned self ] in
                    self.profileVM.fetchProfile()
                }
                .store(in: &subscribers)
            return cell
        default :
            let cell = UITableViewCell()
            return cell
        }
    }
}
