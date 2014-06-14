//
//  AboutViewController.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 4/17/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "AboutViewController.h"
#import "HelpManager.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *youtubeButton;
@property (weak, nonatomic) IBOutlet UIButton *googleButton;
@property (weak, nonatomic) IBOutlet UIButton *linkedIn;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

#define facebookLink @"https://www.facebook.com/happinessway2"
#define googlePlusLink @"https://plus.google.com/103156574596515924801/posts"
#define youtubeLink @"http://www.youtube.com/channel/UC_h_UvXCH6BmAEe-LnnvjmA"
#define twitterLink @"https://twitter.com/happyway80"
#define instagramLink @"http://instagram.com/happyway0ar"

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"About us";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.toolBar setBackgroundImage:[UIImage new]
                  forToolbarPosition:UIToolbarPositionAny
                          barMetrics:UIBarMetricsDefault];
    [self setupNavigationBarButtons];
    [self.toolBar setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
    if ([[HelpManager sharedHelpManager] IS_iPhone4]) {
        self.label.frame =  CGRectMake(self.label.frame.origin.x, self.label.frame.origin.y-80, self.label.frame.size.width, self.label.frame.size.height);
        self.youtubeButton.frame = CGRectMake(self.youtubeButton.frame.origin.x, self.youtubeButton.frame.origin.y-80, self.youtubeButton.frame.size.width, self.youtubeButton.frame.size.height);
        self.googleButton.frame = CGRectMake(self.googleButton.frame.origin.x, self.googleButton.frame.origin.y-80, self.googleButton.frame.size.width, self.googleButton.frame.size.height);
        self.linkedIn.frame = CGRectMake(self.linkedIn.frame.origin.x, self.linkedIn.frame.origin.y-80, self.linkedIn.frame.size.width, self.linkedIn.frame.size.height);
        self.twitterButton.frame = CGRectMake(self.twitterButton.frame.origin.x, self.twitterButton.frame.origin.y-80, self.twitterButton.frame.size.width, self.twitterButton.frame.size.height);
        self.facebookButton.frame = CGRectMake(self.facebookButton.frame.origin.x, self.facebookButton.frame.origin.y-80, self.facebookButton.frame.size.width, self.facebookButton.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cancel:(id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setupNavigationBarButtons{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"But_Back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    if (!IOS_7_LESS)
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
}

-(IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)instagramBtnpressed:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:instagramLink];
    [self presentViewController:webViewController animated:YES completion:NULL];
}
- (IBAction)googleBtnPressed:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:googlePlusLink];
    [self presentViewController:webViewController animated:YES completion:NULL];
}
- (IBAction)twitterBtnPressed:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:twitterLink];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

- (IBAction)youtubeBtnPressed:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:youtubeLink];
    [self presentViewController:webViewController animated:YES completion:NULL];
}
- (IBAction)facebookBtnPressed:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:facebookLink];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

-(BOOL) shouldAutomaticallyForwardRotationMethods{
    return NO;
}

@end
