//
//  DetailViewController.h
//  filmyfilm
//
//  Created by Jatin Pandey on 1/25/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) NSDictionary *movieDict;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;


@end
