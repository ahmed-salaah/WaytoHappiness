//
//  BooksViewController_iPad.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 5/31/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BooksViewController_iPad.h"
#import "UIColor+HexColors.h"
#define Bookmark_Color @"99CCFF"
@interface BooksViewController_iPad ()
{
    WYPopoverController *popOver;
    BOOL popOverisOpen;
    BooksCell* toBeDownloadcell;
    BookDetailModel *downloadedBook;
    UIButton *infoButton;
}
@end

@implementation BooksViewController_iPad

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
     [self.collectionView registerNib:[UINib nibWithNibName:@"BooksCell" bundle:nil] forCellWithReuseIdentifier:BOOKS_CELL_ID];
        [self setupNavigationBarButtons];

    [self.titleLabel setFont:[UIFont fontWithName:@"Droid Arabic Kufi" size:20]];
    self.titleLabel.text = self.titleText;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.model valueForKey:@"books"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BooksCell *cell =(BooksCell *)[collectionView dequeueReusableCellWithReuseIdentifier:BOOKS_CELL_ID forIndexPath:indexPath];
    BookDetailModel * book = [[self.model valueForKey:@"books"] objectAtIndex:indexPath.row];
    cell.bookModel = book;
    cell.titleLabel.text = book.title;
    [cell.titleLabel adjustsFontSizeToFitWidth];
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
    return cell;
}

#pragma CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    // We only want to mess here in iPad in the list view
//    if ([[HelpManager sharedHelpManager] IS_Landscape] && [[HelpManager sharedHelpManager] IS_iPhone5])
//        return CGSizeMake(135, 200);
//    else
        return CGSizeMake(150, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([[HelpManager sharedHelpManager] IS_Landscape] ) {
        return UIEdgeInsetsMake(20, 12, 20, 13);
    }else{
        return UIEdgeInsetsMake(20, 9, 20, 9);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.collectionView.collectionViewLayout invalidateLayout];
    if (popOverisOpen) {
        [popOver dismissPopoverAnimated:YES];
        [self infoPressed:infoButton];
    }
}
- (void) tap:(UIGestureRecognizer *)gesture{
    [popOver dismissPopoverAnimated:YES];
    popOverisOpen = NO;
    [self.view removeGestureRecognizer:gesture];
}

- (void) setupNavigationBarButtons{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"But_Back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    if (!IOS_7_LESS)
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    UIView *bookmarkBtnVu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];

    infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self
                   action:@selector(infoPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"Mnu_Icon_About.png"]forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(0, 0, 44, 44)];

    [bookmarkBtnVu addSubview:infoButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bookmarkBtnVu]];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) infoPressed:(UIButton *) sender{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    AboutViewController *aboutViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    aboutViewController.modalInPopover = NO;
    popOver = [[WYPopoverController alloc] initWithContentViewController:aboutViewController];
    popOver.delegate = self;
    WYPopoverBackgroundView *appeareance = [WYPopoverBackgroundView appearance];
    appeareance.borderWidth = 5;
    appeareance.fillTopColor = [UIColor colorWithHexString:Bookmark_Color];
    appeareance.fillBottomColor = [UIColor colorWithHexString:Bookmark_Color];
    int height = [[HelpManager sharedHelpManager] IS_iPhone4] ? 430 : 550;
    if ([[HelpManager sharedHelpManager] IS_Landscape]) {
        popOver.popoverContentSize = CGSizeMake(height, 300);
    }else
        popOver.popoverContentSize = CGSizeMake(300, height);
    popOver.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 0, 10);
    [popOver presentPopoverFromRect:sender.frame inView:sender.superview permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES];
    popOverisOpen = YES;
}


- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) didTappedDownloadButtonAtCell:(BooksCell *)cell{
    [self downloadPDFFileForBook:cell];
}

- (void) didTappedDeleteButtonAtCell:(BooksCell *)cell{
    
    [self deletePDFFileForBook:cell];
    [[NSFileManager defaultManager] removeItemAtPath:cell.bookModel.filePathInDocuments error:nil];
}

- (void) downloadPDFFileForBook:(BooksCell *)cell{
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

- (void) deletePDFFileForBook:(BooksCell *)cell{
    toBeDownloadcell = cell;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"تحذير" message:@"هل تريد حذف هذا الكتاب؟" delegate:self cancelButtonTitle:@"إلغاء" otherButtonTitles:@"موافق", nil];
    [alert show];
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
