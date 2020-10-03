//
//  ViewController.swift
//  OpenCVDemo
//
//  Created by Adriana Pineda on 03/10/2020.
//  Copyright © 2020 Adriana Pineda. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet var openCVVersionLabel: UILabel!
    @IBOutlet var cameraView: UIImageView!

    var session: AVCaptureSession = AVCaptureSession()
    var input: AVCaptureDeviceInput?
    var output = AVCaptureVideoDataOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        openCVVersionLabel.text = OpenCVWrapper.openCVVersionString()
    }

    @IBAction func startButtonClicked(_: Any) {
        guard let camera = getDevice(position: .front) else {
            print("invalid device")
            return
        }

        do {
            input = try AVCaptureDeviceInput(device: camera)
            guard let input = input else {
                print("invalid input")
                return
            }

            output.alwaysDiscardsLateVideoFrames = true
            let queue = DispatchQueue(label: "cameraQueue")
//            output.setSampleBufferDelegate(self, queue: queue)
            output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]

            session.addInput(input)
            session.addOutput(output)
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer?.frame = cameraView.bounds
            cameraView.layer.addSublayer(previewLayer!)
            session.startRunning()

        } catch let error as NSError {
            print(error)
            input = nil
        }
    }
}

// extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
//    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
//        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
//        CVPixelBufferLockBaseAddress(imageBuffer!, CVPixelBufferLockFlags(rawValue: .allZeros))
//        let baseAddress = UnsafeMutableRawPointer(CVPixelBufferGetBaseAddress(imageBuffer!))
//        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer!)
//        let width = CVPixelBufferGetWidth(imageBuffer!)
//        let height = CVPixelBufferGetHeight(imageBuffer!)
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let newContext = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo:
//            CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
//
//        let newImage = newContext!.makeImage()
//        cameraImage = UIImage(cgImage: newImage!)
//
//        CVPixelBufferUnlockBaseAddress(imageBuffer!, CVPixelBufferLockFlags(rawValue: .allZeros))
//    }
// }

extension ViewController {
    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        if let device = AVCaptureDevice.default(.builtInDualCamera,
                                                for: AVMediaType.video,
                                                position: position) {
            return device
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                       for: AVMediaType.video,
                                                       position: position) {
            return device
        } else {
            return nil
        }
    }
}
