//
//  ViewController.m
//  KeepTest
//
//  Created by ilteris on 3/13/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

#import "ViewController.h"
#import "KeepTableViewCell.h"
#import "UIView+CircularProfileImage.h"


static NSString * const KeepTableViewIdentifier = @"keepTableViewCell";


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ViewController
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //load data from plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"source" ofType:@"plist"];
    NSDictionary *contents = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.data = contents[@"items"];

    //images downloader
    self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:_sessionConfig];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KeepTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:KeepTableViewIdentifier forIndexPath:indexPath];
    [cell.nameLabel setText:self.data[indexPath.row][@"name"]];
    [cell.bodyTextLabel setText:self.data[indexPath.row][@"text"]];
    
    NSMutableDictionary *myDictionary = [[self.data objectAtIndex:indexPath.row] copy];
    
    //if cell is not on the screen cancel the image download task which prevents cells loading wrong imageviews.
    if (cell.imageDownloadTask)
    {
        [cell.imageDownloadTask cancel];
    }
    
    
    [cell.activityIndicator startAnimating];
    cell.profileImageView.image = nil;
    
    
    NSString *urlString = [myDictionary valueForKey:@"imageURL"];
    NSURL *imageURL = [NSURL URLWithString:urlString];
    if (imageURL)
    {
        cell.imageDownloadTask = [_session dataTaskWithURL:imageURL
                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      if (error)
                                      {
                                          NSLog(@"ERROR: %@", error);
                                      }
                                      else
                                      {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          
                                          if (httpResponse.statusCode == 200)
                                          {
                                              UIImage *image = [UIImage imageWithData:data];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [cell.profileImageView setImage:image];
                                                  [UIView createAndReturnCircularProfileImage:cell.profileImageView];
                                                  
                                                  [cell.activityIndicator stopAnimating];
                                              });
                                          }
                                          else
                                          {
                                              NSLog(@"Couldn't load image at URL: %@", imageURL);
                                              NSLog(@"HTTP %ld", (long)httpResponse.statusCode);
                                          }
                                      }
                                  }];
        
        [cell.imageDownloadTask resume];
    }
    
    
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
