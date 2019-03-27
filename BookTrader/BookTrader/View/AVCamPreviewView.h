//
//  AVCamPreviewView.h
//  BookTrader
//
//  Created by Yiju Yang on 3/14/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

@import UIKit;

@class AVCaptureSession;

@interface AVCamPreviewView : UIView

@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic) AVCaptureSession *session;

@end
