//
//  TweetCell.m
//  twitter
//
//  Created by Mitchel Igolimah on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell
- (IBAction)didTapFavorite:(id)sender {
    // It's already favorited, so we want to unfavorite
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        UIImage *UnfavoriteImage = [UIImage imageNamed:@"favor-icon"];
        [self.UnfavoriteButton setImage:UnfavoriteImage forState:UIControlStateNormal];
        // number (like count)
        NSString *favoriteCount = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        [self.favoriteButton setTitle:favoriteCount forState:UIControlStateNormal];
        
        // API call
        [[APIManager shared] Unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error) {
                 NSLog(@"Error Unfavoriting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully Unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        // Data model
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        // Update our UI
        // button
        UIImage *favoriteImage = [UIImage imageNamed:@"favor-icon-red"];
        [self.favoriteButton setImage:favoriteImage forState:UIControlStateNormal];
        // number (like count)
        NSString *favoriteCount = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        [self.favoriteButton setTitle:favoriteCount forState:UIControlStateNormal];
        
        // API call
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error) {
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) {
        self.tweet.retweeted= NO;
        self.tweet.retweetCount -= 1;
        
        UIImage *UnretweetImage = [UIImage imageNamed:@"retweet-icon"];
        [self.UnretweetButton setImage:UnretweetImage forState:UIControlStateNormal];
        // number (like count)
        NSString *retweetCount = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        [self.UnretweetButton setTitle:retweetCount forState:UIControlStateNormal];
        
        // API call
        [[APIManager shared] Unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error) {
                 NSLog(@"Error Unretweeting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully Unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    } else {
    
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        UIImage *retweetImage = [UIImage imageNamed:@"retweet-icon-green"];
        [self.retweetButton setImage:retweetImage forState:UIControlStateNormal];
        [self.retweetButton setTitle:@"1" forState:UIControlStateNormal];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error) {
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
        
}
        

//- (void)awakeFromNib {
    //[super awakeFromNib];
    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
