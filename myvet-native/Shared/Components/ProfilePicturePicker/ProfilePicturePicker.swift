//
//  ProfilePicturePicker.swift
//  myvet-native
//
//  Created by Ligmab Allz on 26/06/25.
//

#if os(iOS)
import UIKit
#endif
#if os(macOS)
import AppKit
import UniformTypeIdentifiers
#endif
import SwiftUI
import PhotosUI

#if os(iOS)
struct CameraPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var onImagePicked: (UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker
        init(parent: CameraPicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImagePicked(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
#endif

#if os(iOS)
typealias PlatformImage = UIImage
#elseif os(macOS)
typealias PlatformImage = NSImage
#endif

struct ProfilePicturePicker: View {
    @State private var showMenu = false
    @State private var selectedImage: PlatformImage? = nil
    @State private var showPhotoPicker = false
    @State private var showCamera = false
    @State private var photoPickerItem: PhotosPickerItem? = nil
    #if os(macOS)
    @State private var showFilePicker = false
    #endif

    var body: some View {
        VStack(spacing: 24) {
            if let image = selectedImage {
                #if os(iOS)
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                #elseif os(macOS)
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                #endif
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
            }
            Menu {
                Button {
                    showPhotoPicker = true
                } label: {
                    Label("Choose from Library", systemImage: "photo.on.rectangle")
                }
                #if os(macOS)
                Button {
                    showFilePicker = true
                } label: {
                    Label("Choose from File", systemImage: "folder")
                }
                #endif
                #if os(iOS)
                Button {
                    showCamera = true
                } label: {
                    Label("Take Photo", systemImage: "camera")
                }
                #endif
            } label: {
                Button("Change") {}
                .font(.headline)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .background(Capsule().stroke(Color.accentColor, lineWidth: 2))
            }
        }
        .padding()
        .photosPicker(isPresented: $showPhotoPicker, selection: $photoPickerItem, matching: .images)
        #if os(iOS)
        .fullScreenCover(isPresented: $showCamera) {
            CameraPicker { image in
                selectedImage = image
            }
        }
        #endif
        .onChange(of: photoPickerItem) { oldValue, newValue in
            if let item = newValue {
                Task {
                    #if os(iOS)
                    if let data = try? await item.loadTransferable(type: Data.self), let uiImg = UIImage(data: data) {
                        selectedImage = uiImg
                    }
                    #elseif os(macOS)
                    if let data = try? await item.loadTransferable(type: Data.self), let nsImg = NSImage(data: data) {
                        selectedImage = nsImg
                    }
                    #endif
                }
            }
        }
        #if os(macOS)
        .onChange(of: showFilePicker) { _, newValue in
            if newValue {
                showFilePicker = false
                DispatchQueue.main.async{
                    openFilePicker()
                }
            }
        }
        #endif
    }

    #if os(macOS)
    private func openFilePicker() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.png, .jpeg, .heic]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        if panel.runModal() == .OK, let url = panel.url, let nsImg = NSImage(contentsOf: url) {
            selectedImage = nsImg
        }
    }
    #endif
}

#Preview {
    ProfilePicturePicker()
}
