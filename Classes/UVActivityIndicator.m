//
//  UVActivityIndicator.m
//  UserVoice
//
//  Created by UserVoice on 2/27/10.
//  Copyright 2010 UserVoice Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UVActivityIndicator.h"


@implementation UVActivityIndicator

@synthesize activityIndicatorView;
@synthesize heightOffset;

- (id)initWithText: (NSString *)text {
	if ((self = [super init])) {
        CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
        BOOL isPortrait = [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait;
        CGFloat width = (isPortrait ? frame.size.width : frame.size.height);
        CGFloat height = (isPortrait ? frame.size.height : frame.size.width);
        
        CGRect corretedFrame = CGRectMake(0, 0, width, height);
        
		self.frame = corretedFrame;
		UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
		backgroundView.backgroundColor = [UIColor blackColor];
		backgroundView.alpha = 0.4;
		[self addSubview:backgroundView];
		[backgroundView release];
		
		UIView *activityFrame = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - ORIENTATIONWIDTH - 200) / 2, ORIENTATIONWIDTH - 220, ORIENTATIONWIDTH - 200, ORIENTATIONWIDTH - 200)];
		activityFrame.backgroundColor = [UIColor blackColor];
		activityFrame.alpha = 0.9;
		activityFrame.layer.cornerRadius = 10;
		
		UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		activity.center = CGPointMake(60, 60);
		self.activityIndicatorView = activity;
		[activityFrame addSubview:activity];
		[activity release];
		
		UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, ORIENTATIONWIDTH - 200, 20)];
		activityLabel.text = text;
		activityLabel.textColor = [UIColor whiteColor];
		activityLabel.backgroundColor = nil;
		activityLabel.opaque = NO;
		activityLabel.textAlignment = UITextAlignmentCenter;
		[activityFrame addSubview:activityLabel];
		[activityLabel release];
		
		[self addSubview:activityFrame];
		[activityFrame release];
	}
	
	return self;	
}

- (id)init {
	if ((self = [super init])) {
		[self initWithText: @"Loading..."];
	}
	
	return self;
}

+ (UVActivityIndicator *)activityIndicator {
	return [[[UVActivityIndicator alloc] init] autorelease];
}

+ (UVActivityIndicator *)activityIndicatorWithText: (NSString *)text {
	return [[[UVActivityIndicator alloc] initWithText:text] autorelease];
}

- (void)show {
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	[window addSubview:self];
	[self.activityIndicatorView startAnimating];
}

- (void)hide {
	[self.activityIndicatorView stopAnimating];
	[self removeFromSuperview];
}

@end
