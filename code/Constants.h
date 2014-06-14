//
//  Constants.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 2/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#ifndef WayToHappiness_Constants_h
#define WayToHappiness_Constants_h
/////////////////////////////////////////////////////////////////////////////////////////////
#define IOS_7_LESS [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending
///////////////////////////
#pragma DOCUMENTS_PATHS
#define SqliteFilePathInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"database.sqlite"]

#define ImagesZipPathInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"Images.zip"]

#define ImagesFolderPathInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"Images"]

#define AddedMACOSXFolderPathInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"__MACOSX"]

#define WayToHappinessHTMLFilePathPathInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"WayToHappiness.html"]
#define HappinessHTMLFilePathPathInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"Happiness.html"]
#define BooksFolderInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"Books"]
#define BooksImagesFolderInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"BooksImages"]
#define VideosImagesFolderInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"VideosImages"]
#define shawahedImagesFolderInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"ShawahedImages"]
#define VideosFolderInDocuments [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"Videos"]

#define Documents_Path [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma FILES_PROCESSING

#define ImagesFolderKeyInHTMLPage @"***documentspath****#"
#define START_JUMP_DEV @"<ul>"
#define END_JUMP_DEV @"</ul>"
#define JUMP_LINE @"<li><a href='Num*'>txt*</a></li>"
#define JUMP_Number_KEYWORD @"Num*"
#define JUMP_TEXT_KEYWORD @"txt*"

#define IMAGE_DEV_IMAGE_PATH_NAME @"***documentspath****#imagename"
#define JUMP_KEYWORD_HTML @"***JumpList****"
#define EMBDED_HTML @"<html><head><style type=\"text/css\">\body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"85\" height=\"60\"></embed></body></html>"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma FILE_NAME_EXTENISON

#define Database_FileName @"database"
#define SQLITE_EXTENISON @"sqlite"
#define HTML_FileName_1 @"WayToHappiness"
#define HTML_FileName_2 @"Happiness"
#define HTML_EXTENISON @"html"
#define Shawahed_Folder @"Images"
#define ZIP_EXTENISON @"zip"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma DATABASE_TABLES_NAMES

#define Main_Category_Table @"Categ"
#define Sub_Main_Category_Table @"MainMaterial_Cat"
#define Page_Table @"MainMaterial_Detail"

#define Video_Main_Table @"Vd_Master"
#define Video_Detail_Table @"Vd_Detail"

#define Book_Main_Table @"BookLibrary_Cat"
#define Book_SubCategory_Table @"BookLibrary_Fesool"
#define Book_Detail_Table @"BookLibrary_Detals"
////////////////////////////////////////////////////////////
#pragma DATABASE_COLUMNS_NAMES
#define SubCategory_Parent_ColumnName @"Sub1IDParentID"
#define ID_ColumnName @"Sub1Id"

////////////////////////////////////////////////////////////
#pragma DATABASE_IDS
#define WayToHappinessID @"82"
#define HappinessDialoguesID @"93"
#define HappinessRoadID @"481"
#define VideoMainCategoryID @"342"

////////////////////////////////////////////////////////////
#pragma MAIN_CATEGORIES
#define WayToHappinessName @"الطريق إلى السعادة"
#define HappinessDialougesName @"حوارات السعادة"
#define HappinessStoryName @"رواية طريق السعادة"
////////////////////////////////////////////////////////////

#pragma BOOK_MAIN_CATEGORIES_IDS
#define AdeanArdya_ID @"173"
#define AdeanSamawya_ID @"174"
#define history_ID @"175"
#define replies_ID @"176"
#define stories_ID @"177"
#define ways_ID @"178"

#pragma SITE_URL
#define videoThumb_Site_Path @"http://www.path-2-happiness.com/files/1/VideoImg/"
#define Download_Site_Path @"http://www.path-2-happiness.com/files/1/pdf/"
#define bookThumb_Site_Path @"http://www.path-2-happiness.com/files/1/booksImg/"
#define shawahedThumb_Image_Path @"http://www.path-2-happiness.com/files/1/ShawahedSquare/"
////////////////////////////////////////////////////////////
#define IPHONE_5Height 568
#define IPHONE_Width 320
#define IPHONE_4_Height 480
#define IPAD_WIDTH   768
#define IPAD_HEIGHT   1024


#define Bookmark_Color @"99CCFF"

#define Sharing_Link @"http://www.path-2-happiness.com/%@.aspx"

#define appColor @"003366"

#pragma customfont

#define CUSTOM_FONT_(s) [UIFont fontWithName:@"Droid Arabic Kufi" size:s]


#define Hacen Liner Screen Bd


#endif
