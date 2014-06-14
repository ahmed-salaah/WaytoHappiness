//
//  PagesViewController.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/12/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "PagesViewController.h"
#import "PageCell.h"
#import "WayToHappinessManager.h"
#import "HappinessModel.h"
#import "IIViewDeckController.h"
#import "FlatWebView.h"
#define Paginator_Width 320
#define Paginator_Y_Position 37
#define Paginator_height_iphone5 473
#define Paginator_height_iphone4 366

@interface PagesViewController (){
    UIView *displayedCell;
    UIButton *bookmarkButton;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerViewBackGround;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic) NSInteger selectedPageIndex;
@property (strong, nonatomic) SYPaginatorView *paginatorView;

@end

@implementation PagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    self.navigationItem.hidesBackButton=YES;
    [super viewDidLoad];
//    [self setupNavigationbarHeight];
    [self  setupHeaderView];
    [self setupNavigationBarButtons];
    if ([[HelpManager sharedHelpManager] IS_Portrait]) {
        [self setupPagintaorViewForPortrait];
    }
    else{
        [self setupPagintaorViewForLandscape];
    }
    [self.view addSubview:self.paginatorView];


}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupHeaderView{
    
    NSString *title = [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? ((WayToHappinessSubCategoryModel *)self.model).title : ((AbstractCategoryModel*)self.model).title;
    NSString *imageName = [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]]?[[HelpManager sharedHelpManager] wayToHappinessHeaderImageName]:[((HappinessModel *)self.model).title isEqualToString:HappinessDialougesName]?[[HelpManager sharedHelpManager] happinessDialougesHeaderImageName]:[[HelpManager sharedHelpManager] storyHeaderImageName];
    
    self.headerViewBackGround.image = [UIImage imageNamed:imageName];
    self.categoryTitleLabel.text = title;
    [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Helvetica-Bold" size:13] forKey:NSFontAttributeName];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Helvetica-Bold" size:13] forKey:NSFontAttributeName];    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
    self.navigationItem.title = [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? ((WayToHappinessSubCategoryModel *)self.model).categoryModel.title : ((AbstractCategoryModel *)self.model).title;
}

- (void) setupPagintaorViewForPortrait{
    
    int height = [[HelpManager sharedHelpManager] IS_iPhone5] ? IPHONE_5Height : IPHONE_4_Height;
    self.paginatorView = [[SYPaginatorView alloc] initWithFrame:CGRectMake(0, Paginator_Y_Position, Paginator_Width, height-Paginator_Y_Position)];
    self.paginatorView.autoresizingMask =UIViewAutoresizingFlexibleWidth;
    self.paginatorView.autoresizesSubviews = YES;

    self.paginatorView.delegate =self;
    self.paginatorView.dataSource = self;
	self.paginatorView.pageGapWidth = 20.0f;
    self.paginatorView.currentPageIndex = self.selectedPageIndex;
    self.paginatorView.backgroundColor = [UIColor clearColor];
}

- (void) setupPagintaorViewForLandscape{
    int width = [[HelpManager sharedHelpManager] IS_iPhone5] ? IPHONE_5Height : IPHONE_4_Height;
    self.paginatorView = [[SYPaginatorView alloc] initWithFrame:CGRectMake(0,Paginator_Y_Position,width,IPHONE_Width-Paginator_Y_Position)];
    self.paginatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    self.paginatorView.autoresizesSubviews = YES;
    
    self.paginatorView.delegate =self;
    self.paginatorView.dataSource = self;
    self.paginatorView.pageGapWidth = 20.0f;
    self.paginatorView.currentPageIndex = self.selectedPageIndex;
    self.paginatorView.backgroundColor = [UIColor clearColor];
}

- (void) backButtonTapped :(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setCurrentPageIndex:(NSInteger)index{
    self.selectedPageIndex = index;
}

#pragma PaginatorDatasource
- (NSInteger) numberOfPagesForPaginatorView:(SYPaginatorView *)paginatorView{
    
    
    return  [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? ((WayToHappinessSubCategoryModel *)self.model).Pages.count : ((HappinessModel*)self.model).pages.count;

}
- (SYPageView *)paginatorView:(SYPaginatorView *)paginatorView viewForPageAtIndex:(NSInteger)pageIndex{


    static NSString *identifier = @"identifier";

    PageCell *page = (PageCell *)[paginatorView dequeueReusablePageWithIdentifier:identifier];
    if (!page) {
        page = [[PageCell alloc] initWithReuseIdentifier:identifier];
    }
    page.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    AbstractPageModel*pageModel =  [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? [((WayToHappinessSubCategoryModel *)self.model).Pages objectAtIndex:pageIndex] : [((HappinessModel*)self.model).pages objectAtIndex:pageIndex];
    page.HTMLString = pageModel.htmlString;
    CGRect frame = self.paginatorView.frame;
    frame.origin.y = 0;
    page.pageFrame = frame;
	return page;

}

/*
<h2>كل الناس تبحث عن السعادة، فأين الطريق؟!</h2><h3 id='1'>  متفقون على غاية واحدة </h3><div class="shahed"> <div class='shahed'><img src='/>/>/>documentspath/>/>/>/>#'Benjamin_Disraeli.jpg/><h4> بنجامين ديزرائيلي </h4><h5>رئيس وزراء بريطانيا سابقًا</h5><h6>السعادة بمقابل</h6><span>"ربما تقوم بشيء لا يجلب لك  السعادة، ولكن ليست هناك سعادة  دون القيام بشيء". </span></div><p>يسعى كل إنسان على وجه البسيطة إلى السعادة، فرغم اختلاف الناس في مذاهبهم وأعراقهم، ومشاربهم ومبادئهم، وغاياتهم ومقاصدهم، إلا إنهم يتفقون في غاية واحدة؛ إنها: طلب السعادة والطمأنينة. </p><p>لو سألت أي إنسان: لم تفعل هذا؟ ولأي شيء تفعل ذاك؟ لقال: أريد السعادة!! سواء أقالها بحروفها أم بمعناها، بمدلولها أم بحقيقتها.</p><h3 id='2'>   ما هي السعادة؟ </h3><p>فما هي السعادة، وكيف نصل إليها؟!</p><p>السعادة هي الشعور المستمر بالغبطة والطمأنينة والأريحية والبهجة، وهذا الشعور السعيد يأتي نتيجة للإحساس الدائم بثلاثة أمور: خيرية الذات، وخيرية الحياة، وخيرية المصير.</p><div class="shahed"> <div class='shahed'><img src='/>/>/>documentspath/>/>/>/>#'Tolstoy.jpg/><h4>تولستوي</h4><h5>أديب روسي</h5><h6>السعادة أقرب ما تكون إلينا</h6><span>"إننا نبحث عن السعادة غالبًا وهي قريـبة منا، كما نبحث في كثير من الأحيان عن النظارة وهي فوق عيوننا".</span></div><p>وحول هذه الأمور الثلاثة تبدأ تساؤلات الإنسان مع نفسه، وتكبر كلما كبر، ولا يجد السعادة حتى يجيب نفسه على تساؤولاتها التي تتوارد على ذهنه، ومنها:</p><p>ـ مَن يملك هذا الكون ويتصرف فيه؟</p><p>ـ مَن خلقني وخلق هذا الكون من حولي؟ </p><p>ـ مَن أنا؟ ومن أين جئت؟ ولماذا خُلقت؟ وإلى أين المصير</p><div class="shahed"> <div class='shahed'><img src='/>/>/>documentspath/>/>/>/>#'Lewis_Carroll.jpg/><h4>لويس كارول</h4><h5>عالم رياضيات</h5><h6>تعددت الطرق والله واحدٌ</h6><span>"إذا لم تكن تعرف إلى أين أنت ذاهب، فكل الطرق ستأخذك إلى هناك".</span></div><p>ولما زاد وعي الإنسان بنفسه وبحياته ازدادت هذه الأسئلة إلحاحًا على عقله وتفكيره وروحه، ولا يجد الطمأنينة والسعادة حتى يجد جوابًا تسكن به نفسه.</p> 
 */
#pragma PaginatorDelegate
-(void)paginatorView:(SYPaginatorView *)paginatorView
     willDisplayView:(UIView *)view
             atIndex:(NSInteger)pageIndex{
    displayedCell =view;
    AbstractPageModel*pageModel = [self getCurrentPage];

    if ([pageModel.isbookmarked boolValue])
        bookmarkButton.tintColor = [UIColor blueColor];
    else
        bookmarkButton.tintColor = [UIColor whiteColor];

}
- (void)paginatorViewDidBeginPaging:(SYPaginatorView *)paginatorView{
    NSLog(@"will Begin Paging");

}
- (void)paginatorView:(SYPaginatorView *)paginatorView didScrollToPageAtIndex:(NSInteger)pageIndex{
    AbstractPageModel*pageModel =  [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? [((WayToHappinessSubCategoryModel *)self.model).Pages objectAtIndex:pageIndex] : [((HappinessModel*)self.model).pages objectAtIndex:pageIndex];
    self.categoryTitleLabel.text = pageModel.title;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
//    [self setupNavigationbarHeight];
    self.paginatorView.alpha = 0;
    [self.paginatorView removeFromSuperview];
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || [[HelpManager sharedHelpManager] IS_Landscape]) {
        [self setupPagintaorViewForLandscape];
    }
    else {
        [self setupPagintaorViewForPortrait];
    }
    self.paginatorView.alpha = 0;
    [self.view addSubview:self.paginatorView];
    [UIView animateWithDuration:.3 animations:^{
        self.paginatorView.alpha = 1;
    }];
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
    
    UIView *bookmarkBtnVu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookmarkButton addTarget:self
                       action:@selector(bookmarkPressed)
             forControlEvents:UIControlEventTouchUpInside];
    [bookmarkButton setImage:[UIImage imageNamed:@"Mnu_Icon_BookMark.png"]forState:UIControlStateNormal];
    [bookmarkButton setFrame:CGRectMake(0, 0, 44, 44)];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self
                   action:@selector(infoPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"Mnu_Icon_About.png"]forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(50, 0, 44, 44)];
    [bookmarkBtnVu addSubview:bookmarkButton];
    [bookmarkBtnVu addSubview:infoButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bookmarkBtnVu]];
}
- (void) menuPressed{
    [self.viewDeckController openLeftView];
}

-(void)share{
    AbstractPageModel*pageModel = [self getCurrentPage];
    

    NSArray *activityItems = [[NSArray alloc] initWithObjects:pageModel.title, [NSString stringWithFormat:Sharing_Link, pageModel.ID], nil];
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
//    activityController.excludedActivityTypes = [[NSArray alloc] initWithObjects:
//                                                UIActivityTypeCopyToPasteboard,
//                                                UIActivityTypePostToWeibo,
//                                                UIActivityTypeSaveToCameraRoll,
//                                                UIActivityTypeCopyToPasteboard,
//                                                UIActivityTypeMessage,
//                                                UIActivityTypeAssignToContact,
//                                                UIActivityTypePrint,
//                                                UIActivityTypeMail,
//                                                nil];

        NSAttributedString *as = [[NSAttributedString alloc] initWithString:@"إلغاء" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
        [[UIButton appearanceWhenContainedIn:[UIActivityViewController class], nil] setAttributedTitle:as forState:UIControlStateNormal];

    
    [self presentViewController:activityController
                       animated:YES completion:nil];
}
#warning hereeeee
- (void)bookmarkPressed{
    AbstractPageModel*pageModel = [self getCurrentPage];

    if (![pageModel.isbookmarked boolValue])
        bookmarkButton.tintColor = [UIColor blueColor];
    else
        bookmarkButton.tintColor = [UIColor whiteColor];
    
    if ([self.model isKindOfClass:[WayToHappinessSubCategoryModel class]]) {
        [[WayToHappinessManager sharedWayToHappinessManager] setBookMarkePage:(WayToHappinessPageModel *)pageModel isBookMarked:![pageModel.isbookmarked boolValue]];
    }else{
        if ([((AbstractCategoryModel *)self.model).ID isEqualToString:HappinessDialoguesID]) {
            [[HappinessDialoguesManager sharedHappinessDialoguesManager]setBookMarkePage:(HappinessPageModel *)pageModel isBookMarked:![pageModel.isbookmarked boolValue]];
        }
        else{
            [[HappinessRoadManager sharedHappinessRoadManager]setBookMarkePage:(HappinessPageModel *)pageModel isBookMarked:![pageModel.isbookmarked boolValue]];
        }
    }
    pageModel.isbookmarked = [NSNumber numberWithBool:![pageModel.isbookmarked boolValue]];
}
-(AbstractPageModel *)getCurrentPage{
        AbstractPageModel*pageModel =  [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? [((WayToHappinessSubCategoryModel *)self.model).Pages objectAtIndex:self.paginatorView.currentPageIndex] : [((HappinessModel*)self.model).pages objectAtIndex:self.paginatorView.currentPageIndex];
    return pageModel;
}
- (void) infoPressed{
    
}

@end
