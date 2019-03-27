//
//  AVCamPreviewView.m
//  BookTrader
//
//  Created by Yiju Yang on 3/14/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//
@import AVFoundation;

#import "AVCamPreviewView.h"

@implementation AVCamPreviewView

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureVideoPreviewLayer*) videoPreviewLayer
{
    return (AVCaptureVideoPreviewLayer *)self.layer;
}

- (AVCaptureSession*) session
{
    return self.videoPreviewLayer.session;
}

- (void)setSession:(AVCaptureSession*) session
{
    self.videoPreviewLayer.session = session;
}

@end
