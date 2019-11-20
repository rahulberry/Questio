//
//  ViewController.swift
//  camera-fucker
//
//  Created by Prithvi Menon on 17/11/2019.
//  Copyright © 2019 Prithvi Menon. All rights reserved.
//

/*import UIKit
import AVFoundation
class ComputerVision: UIViewController {
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamrera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    
    var image : UIImage?
    
    var load_image : UIImage!
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?

    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInTrueDepthCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamrera = frontCamera
    }
    
    
    func setupInputOutput(){
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamrera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
        
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    
    func getResult() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}

extension ComputerVision: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data:imageData)
            let png_format = image?.jpegData(compressionQuality: 0.9)
            print(png_format)
            let url = URL(string: "https://surveybot12.cognitiveservices.azure.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=gender,age,emotion&recognitionModel=recognition_01&returnRecognitionModel=false&detectionModel=detection_01")!
                    var request = URLRequest(url: url)
                    request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
                    request.setValue("240ca093ef6841c287611049c55a06f1", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
                    request.httpMethod = "POST"
                    
                    request.httpBody = png_format
                                    
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data,
                            let response = response as? HTTPURLResponse,
                            error == nil else {                                              // check for fundamental networking error
                            print("error", error ?? "Unknown error")
                            return
                        }

                        guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                            print("statusCode should be 2xx, but is \(response.statusCode)")
                            print("response = \(response)")
                            let responseString = String(data: data, encoding: .utf8)
                            print("responseString = \(responseString)")
                            return
                        }

                        let responseString = String(data: data, encoding: .utf8)
                        print("responseString = \(responseString)")
                    }

                    task.resume()
            
        }
    
    }
}
*/

