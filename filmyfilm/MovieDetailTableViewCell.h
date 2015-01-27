//
//  MovieDetailTableViewCell.h
//  filmyfilm
//
//  Created by Jatin Pandey on 1/22/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *criticsScore;
@property (weak, nonatomic) IBOutlet UILabel *audienceScore;

@end
