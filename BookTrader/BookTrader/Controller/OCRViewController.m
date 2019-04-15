//
//  OCRViewController.m
//  BookTrader
//
//  Created by Simon yang on 4/7/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCRViewController.h"

@interface OCRViewController ()
@property(strong,nonatomic) UITextView * templateField;
@property(strong,nonatomic) G8Tesseract* tesseract;
@end

@implementation OCRViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Languages are used for recognition (e.g. eng, ita, etc.). Tesseract will
    // search for the .traineddata language file in the tessdata directory. For
    // example, specifying "eng+ita" will search for "eng.traineddata" and
    // "ita.traineddata".
    
    // Create your Tesseract object using the initWithLanguage method:
    self.tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    
    // Set up the delegate to receive Tesseract's callbacks.
    // self should respond to TesseractDelegate and implement a
    // "- (BOOL)shouldCancelImageRecognitionForTesseract:(Tesseract*)tesseract"
    // method to receive a callback to decide whether or not to interrupt
    // Tesseract before it finishes a recognition.
    self.tesseract.delegate = self;
    
    // Optional: Limit the character set Tesseract should try to recognize from
    [self.tesseract setVariableValue:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" forKey:@"tessedit_char_whitelist"];
    [self.tesseract setVariableValue:@".,:;'" forKey:@"tessedit_char_blacklist"];
    
    // See http://www.sk-spell.sk.cx/tesseract-ocr-en-variables for a complete
    // (but not up-to-date) list of Tesseract variables.
    
    // Specify the image Tesseract should recognize on
    [self.tesseract setImage:[UIImage imageNamed:@"book_store.jpeg"]];
    
    // Optional: Limit the area of the image Tesseract should recognize on to a rectangle
    [self.tesseract setRect:CGRectMake(0, 0, 640, 400)];
    
    // Start the recognition
    [self.tesseract recognize];
    
    // Retrieve the recognized text
    NSLog(@"%@", [self.tesseract recognizedText]);
    
    UIImageView * templateDisplay = [[UIImageView alloc] initWithFrame:CGRectMake(5, 105, 407, 85)];
    templateDisplay.image = [UIImage imageNamed:@"book_store.jpeg"];
    templateDisplay.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:templateDisplay];
    self.templateField = [[UITextView alloc] initWithFrame:CGRectMake(5, 200, 407, 135)];
    self.templateField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_templateField];
    UIButton * crBtn = [[UIButton alloc] initWithFrame:CGRectMake(5,350, 407, 44)];
    [crBtn addTarget:self action:@selector(OCR) forControlEvents:UIControlEventTouchUpInside];
    [crBtn setTitle:@"Click me!" forState:(UIControlStateNormal)];
    crBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:crBtn];
}


- (void)OCR
{
    [self.tesseract recognize];
    NSLog(@"%@", [self.tesseract recognizedText]);
    self.templateField.text = [self.tesseract recognizedText];
}
     
- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract*)tesseract
{
    NSLog(@"progress: %d", tesseract.progress);
    return NO;  // return YES if you need to interrupt Tesseract before it finishes
}

@end
