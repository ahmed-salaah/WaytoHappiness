//
//  BooksTableViewController.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BooksTableViewController.h"
#import "BookMainCategory.h"
#import "BookSubCategoryModel.h"
#import "HappinessCell.h"
#import "BookDetailModel.h"
#import "DownloadManager.h"
#import "AFNetworkReachabilityManager.h"
#import "IIViewDeckController.h"
#import "UIImageView+AFNetworking.h"


#define CellIdentifier @"BookCell"

@interface BooksTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabelBookLibrary;


@end

@implementation BooksTableViewController{
    BookCell* toBeDownloadcell;
    BookDetailModel *downloadedBook;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self setupNavigationbarHeight];
    [self.tableView registerNib:[UINib nibWithNibName:@"BookCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self setupNavigationBarButtons];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate {
    
    CGRect frame = self.headerLabel.frame;
    frame.origin.x = self.headerLabelBookLibrary.frame.origin.x -  self.headerLabel.frame.size.width;
    self.headerLabel.frame = frame;
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [[self.model valueForKey:@"books"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookCell *cell = (BookCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[BookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    BookDetailModel * book = [[self.model valueForKey:@"books" ] objectAtIndex:indexPath.row];
    cell.bookModel = book;
    cell.titleLabel.text = book.title;
    NSString *imgURL = [[bookThumb_Site_Path stringByAppendingString:book.imageName]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * imagePath = [BooksImagesFolderInDocuments  stringByAppendingPathComponent:book.imageName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        cell.iconImageView.image  = [UIImage imageWithContentsOfFile:imagePath];
    }
    else{
        [cell.iconImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgURL]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            cell.iconImageView.image = image;
            [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        }];
    }
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookDetailModel *book = [(BookCell *)[tableView cellForRowAtIndexPath:indexPath ] bookModel];
	ReaderDocument *document = [ReaderDocument withDocumentFilePath:book.filePathInDocuments password:nil];
	if (document != nil)
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
		readerViewController.delegate = self;
		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
		[self presentViewController:readerViewController animated:YES completion:NULL];
	}
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) didTappedDownloadButtonAtCell:(BookCell *)cell{
    [self downloadPDFFileForBook:cell];
}

- (void) didTappedDeleteButtonAtCell:(BookCell *)cell{
    
    [self deletePDFFileForBook:cell];
    [[NSFileManager defaultManager] removeItemAtPath:cell.bookModel.filePathInDocuments error:nil];
}

- (void) downloadPDFFileForBook:(BookCell *)cell{
    BookDetailModel *book = [cell bookModel];

        MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeAnnularDeterminate;
        HUD.delegate = self;
        HUD.labelText = @"Downloading";
        [HUD show:YES];
        NSString *fromPath = [Download_Site_Path stringByAppendingString:book.fileName];
        [[DownloadManager sharedDownloadManager] downloadFileFrom:fromPath to:book.filePathInDocuments withSuccessBlock:^{
            HUD.labelText = @"";
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            HUD.mode = MBProgressHUDModeCustomView;
            [HUD hide:YES afterDelay:2];
            book.isDownloaded = YES;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [cell updateButtons];
            }];
        } failuerBlock:^{
            [HUD hide:YES];
        }DownloadProgressBlock:^(NSUInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead) {
            HUD.progress = totalBytesRead / (float)totalBytesExpectedToRead;
        }];

}

- (void) deletePDFFileForBook:(BookCell *)cell{
    toBeDownloadcell = cell;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"تحذير" message:@"هل تريد حذف هذا الكتاب؟" delegate:self cancelButtonTitle:@"إلغاء" otherButtonTitles:@"موافق", nil];
    [alert show];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation  duration:(NSTimeInterval)duration {
//    [self setupNavigationbarHeight];

}

- (void) setupNavigationbarHeight{
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.size.height = 44;
    self.navigationController.navigationBar.frame = frame;
}

- (void) setupNavigationBarButtons{
    
    UIView *btnVu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(menuPressed) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"Mnu_Icon_Mnu.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(10, 0, 44, 44)];
    [btnVu addSubview:button];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btnVu]];
    
    UIView *bookmarkBtnVu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];

    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self
                   action:@selector(infoPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"Mnu_Icon_About.png"]forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(0, 0, 44, 44)];
    [bookmarkBtnVu addSubview:infoButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bookmarkBtnVu]];
}

- (void) menuPressed{
    [self.viewDeckController openLeftView];
}



- (void) infoPressed{
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:{
             BookDetailModel *book = [toBeDownloadcell bookModel];
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:book.filePathInDocuments error:nil];
            book.isDownloaded= NO;
            [toBeDownloadcell updateButtons];
            break;
        }
        default:
            break;
    }
}


@end

