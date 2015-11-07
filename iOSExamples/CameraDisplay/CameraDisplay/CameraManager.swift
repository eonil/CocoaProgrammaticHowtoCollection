//
//  CameraManager.swift
//  cam1
//
//  Created by Hoon H. on 2015/02/17.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



final class CameraManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
	let	video:AVCaptureDevice
	let	audio:AVCaptureDevice
	let	session:AVCaptureSession
	let	display:AVCaptureVideoPreviewLayer
	
	override init() {
		func findFrontfacingCamera() -> AVCaptureDevice? {
			for dev in AVCaptureDevice.devices() as! [AVCaptureDevice] {
				if dev.hasMediaType(AVMediaTypeVideo) {
					if dev.position == AVCaptureDevicePosition.Front {
						return	dev
					}
				}
			}
			return	nil
		}
		
		print(AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo))
		video	=	findFrontfacingCamera()!
		audio	=	AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio)[0] as! AVCaptureDevice
		session	=	AVCaptureSession()
		display	=	AVCaptureVideoPreviewLayer(session: session)
		
		super.init()

		let	in1		=	try! AVCaptureDeviceInput(device: video)
		let	in2		=	try! AVCaptureDeviceInput(device: audio)
		let	out1	=	AVCaptureVideoDataOutput()
		out1.setSampleBufferDelegate(self, queue: dispatch_get_main_queue())
		
		session.beginConfiguration()
		assert(session.canAddInput(in1))
		assert(session.canAddInput(in2))
		assert(session.canAddOutput(out1))
		session.addInput(in1)
		session.addInput(in2)
		session.addOutput(out1)
		session.commitConfiguration()
		session.startRunning()
	}
	
	func captureOutput(captureOutput: AVCaptureOutput!, didDropSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
		print("DROP frame!")
	}
	func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
		print("OUTPUT frame!")
	}
}

