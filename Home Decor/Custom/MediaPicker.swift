//
//  MediaPicker.swift
//  Home Decor
//
//  Created by Dalynn on 12/17/25.
//
import SwiftUI
import PhotosUI
import UIKit
import MobileCoreServices
import AVKit
import UniformTypeIdentifiers

struct MediaPicker: UIViewControllerRepresentable {
    @Binding var mediaType: MediaType?
    @Binding var selectedMedia: UIImage?
    @Binding var selectedFileURLs: [URL]
    var isSingleSelection: Bool = false
    var onComplete: (() -> Void)?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
        var parent: MediaPicker

        init(parent: MediaPicker) {
            self.parent = parent
        }

        // MARK: - UIImagePickerController (Camera or Single Image)
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedMedia = image
                if let fileURL = saveImageToTempDirectory(image) {
                    parent.selectedFileURLs.append(fileURL)
                }
            }

            picker.dismiss(animated: true) {
                self.parent.onComplete?()
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) {
                self.parent.presentationMode.wrappedValue.dismiss()
                self.parent.onComplete?()
            }
        }

        // MARK: - PHPickerViewController (Gallery)
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if results.isEmpty {
                picker.dismiss(animated: true) {
                    self.parent.presentationMode.wrappedValue.dismiss()
                }
                return
            }

            picker.dismiss(animated: true) {
                self.parent.onComplete?()
            }

            for result in results where result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
                    if let image = object as? UIImage,
                       let compressedURL = self.saveImageToTempDirectory(image) {
                        DispatchQueue.main.async {
                            self.parent.selectedFileURLs.append(compressedURL)
                        }
                    }
                }
            }
        }

        // MARK: - Save & Compress Image
        private func saveImageToTempDirectory(_ image: UIImage) -> URL? {
            // Resize image first (max longest side = 1920px)
            let resizedImage = image.resized(byLongestSide: 1920) ?? image

            let fileName = UUID().uuidString + ".jpg"
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

            var compressionQuality: CGFloat = 1.0
            var imageData = resizedImage.jpegData(compressionQuality: compressionQuality)

            while let data = imageData, data.count > 2_000_000, compressionQuality > 0.1 {
                compressionQuality -= 0.1
                imageData = resizedImage.jpegData(compressionQuality: compressionQuality)
            }

            if let finalData = imageData {
                try? finalData.write(to: fileURL)
                return fileURL
            }

            return nil
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        if isSingleSelection {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator

            if let mediaType = mediaType {
                switch mediaType {
                case .camera:
                    picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
                case .gallery:
                    picker.sourceType = .photoLibrary
                }
            }

            picker.mediaTypes = [UTType.image.identifier]
            return picker
        } else {
            if mediaType == .gallery {
                var config = PHPickerConfiguration()
                config.filter = .images
                config.selectionLimit = 0

                let picker = PHPickerViewController(configuration: config)
                picker.delegate = context.coordinator
                return picker
            } else {
                let picker = UIImagePickerController()
                picker.delegate = context.coordinator
                picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
                picker.mediaTypes = [UTType.image.identifier]
                return picker
            }
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    enum MediaType {
        case camera, gallery
    }
}

extension UIImage {
    func resized(byLongestSide maxLength: CGFloat) -> UIImage? {
        guard maxLength > 0 else { return nil }

        let aspectRatio = size.width / size.height

        var newSize: CGSize
        if size.width > size.height {
            let width = maxLength
            let height = width / aspectRatio
            newSize = CGSize(width: width, height: height)
        } else {
            let height = maxLength
            let width = height * aspectRatio
            newSize = CGSize(width: width, height: height)
        }

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
