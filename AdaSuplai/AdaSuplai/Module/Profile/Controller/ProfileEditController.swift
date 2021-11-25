//
//  ProfileEditController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 07/11/21.
//

import UIKit
import Combine
import Kingfisher
import PhotosUI

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
        
        // Observe photo library changes
        PHPhotoLibrary.shared().register(self)
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
        // Request permission to access photo library
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async { [unowned self] in
                showUI(for: status)
            }
        }
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
    
    private func showAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: self.profileVM.error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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
                .sink { [ unowned self ] result in
                    if result == "Success" {
                        self.profileVM.fetchProfile()
                    } else {
                        self.showAlert(error: result)
                    }
                }
                .store(in: &subscribers)
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configureNoButton(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.phoneNumber.removeCountryCode ?? "")
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configureNoButton(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.email ?? "")
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configure(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.businessName ?? "")
            cell.profileEditPublisher
                .sink { [ unowned self ] result in
                    if result == "Success" {
                        self.profileVM.fetchProfile()
                    } else {
                        self.showAlert(error: result)
                    }
                }
                .store(in: &subscribers)
            return cell
        case 4 :
            let cell = tableView.dequeueReusableCell(withCell: ProfileEditCell.self, for: indexPath)
            cell.configure(titleLabel: titleLabel[indexPath.row], descriptionLabel: user?.businessCategory ?? "")
            cell.profileEditPublisher
                .sink { [ unowned self ] result in
                    if result == "Success" {
                        self.profileVM.fetchProfile()
                    } else {
                        self.showAlert(error: result)
                    }
                }
                .store(in: &subscribers)
            return cell
        default :
            let cell = UITableViewCell()
            return cell
        }
    }
}

// MARK: - Access Library
extension ProfileEditController: PHPhotoLibraryChangeObserver, PHPickerViewControllerDelegate {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async { [unowned self] in
            // Obtain authorization status and update UI accordingly
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            showUI(for: status)
        }
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        let identifiers = results.compactMap(\.assetIdentifier)
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        if let fetch = fetchResult.firstObject {
            profileVM.updateProfileImage(data: getAssetThumbnail(asset: fetch)) { result in
                if result {
                    DispatchQueue.main.async {
                        self.profileVM.fetchProfile()
                    }
                } else {
                    DispatchQueue.main.async { () -> Void in
                        self.showAlert(error: self.profileVM.error)
                    }
                }
            }
        }
    }
}

private extension ProfileEditController {
    
    func showUI(for status: PHAuthorizationStatus) {
        
        switch status {
        case .authorized:
            openLibrary()

        case .limited:
            openLibrary()

        case .restricted:
            goToSetting()

        case .denied:
            goToSetting()

        case .notDetermined:
            break

        @unknown default:
            break
        }
    }
    
    func openLibrary() {
        let photoLibrary = PHPhotoLibrary.shared()
        let configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func goToSetting() {
        print("Limited Access")
    }
    
    func showRestrictedAccessUI() {
        print("Restricted Access")
    }
    
    func showAccessDeniedUI() {
        print("Denied Access")
    }
    
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else {
                assertionFailure("Not able to open App privacy settings")
                return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFit, options: option, resultHandler: {(result, _ ) -> Void in
                thumbnail = result!
        })
        return thumbnail
    }
}
