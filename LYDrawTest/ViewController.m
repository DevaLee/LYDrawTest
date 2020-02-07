//
//  ViewController.m
//  LYDrawTest
//
//  Created by 李玉臣 on 2020/2/7.
//  Copyright © 2020 LYfinacial.com. All rights reserved.
//

#import "ViewController.h"

#import "LYDrawView.h"
#import "LYDrawTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LYDrawTextView *drawView = [[LYDrawTextView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:drawView];
}


@end
