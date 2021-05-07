//
//  ViewController.swift
//  WDImagePicker
//
//  Created by Wu Di on 27/8/15.
//  Copyright (c) 2015 Wu Di. All rights reserved.
//

import UIKit
import WDImagePicker

class ViewController: UIViewController, WDImagePickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    fileprivate var imagePicker: WDImagePicker!
    fileprivate var imagePickerController: UIImagePickerController!

    fileprivate var customCropButton: UIButton!
    fileprivate var normalCropButton: UIButton!
    fileprivate var imageView: UIImageView!
    fileprivate var resizableButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.customCropButton = UIButton()
        self.customCropButton.frame = UIDevice.current.userInterfaceIdiom == .pad ?
            CGRect(x: 20, y: 20, width: 220, height: 44) :
            CGRect(x: 20, y: self.customCropButton.frame.maxY + 60 , width: self.view.bounds.width - 40, height: 44)
        self.customCropButton.setTitleColor(self.view.tintColor, for: UIControl.State())
        self.customCropButton.setTitle("6:1 Crop", for:UIControl.State())
        self.customCropButton.addTarget(self, action: #selector(ViewController.showPicker(_:)), for: .touchUpInside)
        self.view.addSubview(self.customCropButton)

        self.normalCropButton = UIButton()
        self.normalCropButton.setTitleColor(self.view.tintColor, for: UIControl.State())
        self.normalCropButton.setTitle("Apple's Build In Crop", for: UIControl.State())
        self.normalCropButton.addTarget(self, action: #selector(ViewController.showNormalPicker(_:)), for: .touchUpInside)
        self.view.addSubview(self.normalCropButton)

        self.resizableButton = UIButton()
        self.resizableButton.setTitleColor(self.view.tintColor, for:UIControl.State())
        self.resizableButton.setTitle("Rectangle crop", for: UIControl.State())
        self.resizableButton.addTarget(self, action: #selector(ViewController.showResizablePicker(_:)), for: .touchUpInside)
        self.view.addSubview(self.resizableButton)

        self.imageView = UIImageView(frame: CGRect.zero)
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = UIColor.gray
        self.view.addSubview(self.imageView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.normalCropButton.frame = UIDevice.current.userInterfaceIdiom == .pad ?
            CGRect(x: 260, y: 20, width: 220, height: 44) :
            CGRect(x: 20, y: self.customCropButton.frame.maxY + 20 , width: self.view.bounds.width - 40, height: 44)

        self.resizableButton.frame = UIDevice.current.userInterfaceIdiom == .pad ?
            CGRect(x: 500, y: 20, width: 220, height: 44) :
            CGRect(x: 20, y: self.normalCropButton.frame.maxY + 20 , width: self.view.bounds.width - 40, height: 44)

        self.imageView.frame = UIDevice.current.userInterfaceIdiom == .pad ?
            CGRect(x: 20, y: 84, width: self.view.bounds.width - 40, height: self.view.bounds.height - 104) :
            CGRect(x: 20, y: self.resizableButton.frame.maxY + 20, width: self.view.bounds.width - 40, height: self.view.bounds.height - 20 - (self.resizableButton.frame.maxY + 20))
    }

    @objc func showPicker(_ button: UIButton) {
        self.imagePicker = WDImagePicker()
        self.imagePicker.delegate = self
        self.imagePicker.aspectRatioPreset = .preset6x1
        self.present(self.imagePicker.imagePickerController, animated: true, completion: nil)
    }

    @objc func showNormalPicker(_ button: UIButton) {
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.sourceType = .photoLibrary
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true
        self.present(self.imagePickerController, animated: true, completion: nil)
    }

    @objc func showResizablePicker(_ button: UIButton) {
        self.imagePicker = WDImagePicker()
        self.imagePicker.aspectRatioPreset = .presetSquare
        self.imagePicker.delegate = self
        self.imagePicker.resizableCropArea = false
        self.present(self.imagePicker.imagePickerController, animated: true, completion: nil)
    }

    func imagePicker(_ imagePicker: WDImagePicker, pickedImage: UIImage) {
        self.imageView.image = pickedImage
        self.hideImagePicker()
    }

    func hideImagePicker() {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}

