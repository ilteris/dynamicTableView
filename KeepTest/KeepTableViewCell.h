//
//  KeepCollectionViewCell.h
//  KeepTest
//
//  Created by ilteris on 3/13/15.
//  Copyright (c) 2015 ilteris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeepTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyTextLabel;
@property (strong, nonatomic) NSString *imageURL;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) NSURLSessionDataTask *imageDownloadTask;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;



@end
