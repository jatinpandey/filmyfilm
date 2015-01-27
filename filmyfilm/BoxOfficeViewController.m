//
//  BoxOfficeViewController.m
//  filmyfilm
//
//  Created by Jatin Pandey on 1/22/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "BoxOfficeViewController.h"
#import "MovieDetailTableViewCell.h"
#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface BoxOfficeViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation BoxOfficeViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Filmyfilm";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendAsyncRequest:[NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=16&country=us&apikey=246zdsdp9779jvsg3fpagauf"]];
            [SVProgressHUD dismiss];
        });
    });
    UINib *movieDetailTableViewCell = [UINib nibWithNibName:@"MovieDetailTableViewCell" bundle:nil];
    [self.tableView registerNib:movieDetailTableViewCell forCellReuseIdentifier:@"MovieDetailTableViewCell"];
    self.tableView.rowHeight = 360;
}

- (void) sendAsyncRequest:(NSURL *)urlToHit {
    NSURL *url = urlToHit;
    //    http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit=16&page=1&country=us&apikey=246zdsdp9779jvsg3fpagauf In Theatres link
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = responseData[@"movies"];
        for (NSDictionary *movie in self.movies) {
            NSLog(@"%@", movie[@"title"]);
        }
        [self.tableView reloadData];
    }];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%@", searchBar.text);
    NSString *queryUrlString = [NSString stringWithFormat:@"%@&q=%@", @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=246zdsdp9779jvsg3fpagauf", searchBar.text];
    NSURL *queryUrl = [NSURL URLWithString:queryUrlString];
    NSLog(@"%@", queryUrlString);
    [self sendAsyncRequest:queryUrl];
    [self.view endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@", searchText);
    NSString *queryUrlString = [NSString stringWithFormat:@"%@&q=%@", @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=246zdsdp9779jvsg3fpagauf", searchText];
    NSURL *queryUrl = [NSURL URLWithString:queryUrlString];
    NSLog(@"%@", queryUrlString);
    [self sendAsyncRequest:queryUrl];
}

- (void) onRefresh {
    [self sendAsyncRequest:[NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=16&country=us&apikey=246zdsdp9779jvsg3fpagauf"]];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    cell.textLabel.text = self.movies[indexPath.row][@"title"];
    MovieDetailTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"MovieDetailTableViewCell" forIndexPath:indexPath];
    customCell.titleLabel.text = self.movies[indexPath.row][@"title"];
    customCell.criticsScore.text = [NSString stringWithFormat:@"%@", self.movies[indexPath.row][@"ratings"][@"critics_score"]];
    customCell.audienceScore.text = [NSString stringWithFormat:@"%@", self.movies[indexPath.row][@"ratings"][@"audience_score"]];
    NSString *picUrlString = self.movies[indexPath.row][@"posters"][@"detailed"];
    picUrlString = [picUrlString stringByReplacingOccurrencesOfString:@"tmb" withString:@"org"];
    [customCell.posterImageView setImageWithURL:[NSURL URLWithString:picUrlString]];
    
    return customCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *dvc = [[DetailViewController alloc] init];
    dvc.movieDict = [self.movies objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}

- (BOOL)isConnected {
    CFNetDiagnosticRef dReference;
    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.google.com"]);
    
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
    
    CFRelease (dReference);
    
    if ( status == kCFNetDiagnosticConnectionUp )
    {
        NSLog (@"Connection is Available");
        return YES;
    }
    else
    {
        NSLog (@"Connection is down");
        return NO;
    }
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
