//
//  BookViewController_iPad.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/29/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BookMainViewController_iPad.h"
#import "BookManager.h"
#import "BookMainCategory.h"
#import "BookSubCell.h"
#import "RABookDataObject.h"
#import "BooksTableViewController.h"
#import "IIViewDeckController.h"
#import "BooksViewController_iPad.h"
@interface BookMainViewController_iPad ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet RATreeView *treeView;
@property (nonatomic,strong) NSArray *booksCategories;
@property (strong, nonatomic) id expanded;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation BookMainViewController_iPad

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
    self.booksCategories = [[BookManager sharedBookManager] categories];
    self.data =[NSMutableArray array];
    [self setupHeaderView];
    [self setupTreeView];
    [self setupNavigationBarButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void) setupHeaderView{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Mnu_Icon_Mnu.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(menuPressed)];
}
- (void) setupTreeView{
    self.treeView.delegate =self;
    self.treeView.dataSource = self;
    self.treeView.separatorStyle = RATreeViewCellSeparatorStyleNone;
    self.treeView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin;
    [self.treeView setRowsCollapsingAnimation:RATreeViewRowAnimationLeft];
    [self.treeView setRowsExpandingAnimation:RATreeViewRowAnimationLeft];
    for (BookMainCategory *bookCategory in self.booksCategories) {
        [self.data addObject:[RABookDataObject dataObjectWithCategory:bookCategory]];
    }
    
}

#pragma mark TreeView Delegate methods
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return treeNodeInfo.children.count > 0 ? 80 : 75;
}

- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return 3 * treeNodeInfo.treeDepthLevel;
}

- (BOOL)treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return YES;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel
{
    if ([item isEqual:self.expanded]) {
        return YES;
    }
    
    return NO;
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    UITableViewCell *cell;
    if (treeNodeInfo.children.count > 0 || treeNodeInfo.treeDepthLevel == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VideoCat_VedioBack.png"]];
        cell.textLabel.text = ((RABookDataObject *)item).name;
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.imageView.image = [UIImage imageNamed:@"Book2_IconBook.png"];
        if (treeNodeInfo.treeDepthLevel == 0 && treeNodeInfo.children.count == 0) {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Book_More.png"]];
        }
    }
    else{
        cell = [[BookSubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
        ((BookSubCell*)cell).backgrounImageView.image = [UIImage imageNamed:@"Book2_TitleBack.png"];
        ((BookSubCell*)cell).titleLabel.text = ((RABookDataObject *)item).name;
        ((BookSubCell*)cell).selectionStyle = UITableViewCellSelectionStyleNone;
        ((BookSubCell*)cell).backgroundColor = [UIColor clearColor];
        ((BookSubCell*)cell).iconImageView.image = [UIImage imageNamed:@"Book2_IconBook.png"];
        ((BookSubCell*)cell).accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Book_More.png"]];
    }
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.data count];
    }
    
    RABookDataObject *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RABookDataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    
    return [data.children objectAtIndex:index];
}

- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    if (treeNodeInfo.children.count == 0) {
        RABookDataObject *data = item;
        BooksViewController_iPad  *booksTableView = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"BooksViewController_iPad"];
        booksTableView.model = data.model;
        booksTableView.titleText= ((RABookDataObject *)item).name;
        [self.navigationController pushViewController:booksTableView animated:YES];
    }
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
    AboutViewController *aboutViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

@end
