//
//  DetailViewController.m
//  filmyfilm
//
//  Created by Jatin Pandey on 1/25/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = self.movieDict[@"title"];
    NSString *picUrlString = self.movieDict[@"posters"][@"detailed"];
    picUrlString = [picUrlString stringByReplacingOccurrencesOfString:@"tmb" withString:@"org"];
    [self.posterImageView setImageWithURL:[NSURL URLWithString:picUrlString]];
    self.synopsisLabel.text = self.movieDict[@"synopsis"];
    [self.synopsisLabel sizeToFit];
    CGSize synopsisSize = [self.synopsisLabel sizeThatFits:CGSizeMake(320, 1000)];
    self.scrollView.contentSize = CGSizeMake(320, synopsisSize.height + 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
