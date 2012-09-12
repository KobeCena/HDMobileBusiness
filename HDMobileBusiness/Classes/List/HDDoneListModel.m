//
//  HDDoneListModel.m
//  HandMobile
//
//  Created by Rocky Lee on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDDoneListModel.h"

@implementation HDDoneListModel
@synthesize resultList = _resultList;
@synthesize pageNum = _pageNum;
@synthesize queryURL = _queryURL;
@synthesize currentIndex = _currentIndex;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_resultList);
    TT_RELEASE_SAFELY(_queryURL);
    [super dealloc];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(id)init
{
    if (self = [super init]) {
        _pageNum = 1;
        _resultList = [[NSMutableArray alloc] init];
        //test data
        //        self.queryUrl = [NSString stringWithFormat:@"%@autocrud/ios.ios_approve.ios_workflow_has_approved_query/query",[[HDHTTPRequestCenter sharedURLCenter]baseURLPath]];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (more) {
        _pageNum ++;
    }
    if (!more && [_resultList count] == 0) {
        _pageNum =1;
    }
    //debug:添加对_queryUrl的nil校验，否则对nil appendding导致crash R
    if (_queryURL.length) {
        HDRequestMap * map = [HDRequestMap mapWithDelegate:self];
        map.requestPath = [_queryURL stringByAppendingFormat:@"?pagesize=10&amp;pagenum=%i&amp;_fetchall=false&amp;_autocount=false",_pageNum];
        [self requestWithMap:map];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)requestResultMap:(HDResponseMap *)map
{
    [_resultList addObjectsFromArray:map.result];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark Page turning
-(id)current
{
    return [self.resultList objectAtIndex:_currentIndex];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)next
{
    if ([self hasNext]) {
        _currentIndex ++;
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(BOOL)hasNext
{
    return  (_currentIndex < [self effectiveRecordCount]);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)prev
{
    if ([self hasPrev]) {
        _currentIndex --;
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(BOOL)hasPrev
{
    return  (_currentIndex > 0);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(NSUInteger)effectiveRecordCount
{
    return self.resultList.count;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(NSIndexPath *) currentIndexPath
{
    return [NSIndexPath indexPathForRow:_currentIndex inSection:0];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@end