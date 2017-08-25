

//

#import "SearchTool.h"
#define RecordCount 10      //最多存储5条，自定义
//#define SEARCH_HISTORY [[NSUserDefaults standardUserDefaults] arrayForKey:@"SearchHistory"]
@implementation SearchTool

+ (void)addSearchRecord:(NSString *)searchStr NSUserDefaultsKey:(NSString*)keys
{
    NSMutableArray *searchArray = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:keys]];
    if (searchArray == nil) {
        searchArray = [[NSMutableArray alloc]init];
    } else if ([searchArray containsObject:searchStr]) {
        [searchArray removeObject:searchStr];
    } else if ([searchArray count] >= RecordCount) {
        [searchArray removeObjectsInRange:NSMakeRange(RecordCount - 1, [searchArray count] - RecordCount + 1)];
    }
    [searchArray insertObject:searchStr atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:searchArray forKey:keys];
}

+ (NSArray *)getAllSearchHistoryNSUserDefaultsKey:(NSString*)keys
{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:keys];
}

+ (void)clearAllSearchHistoryNSUserDefaultsKey:(NSString*)keys
{
    [[NSUserDefaults standardUserDefaults] setObject:[[NSMutableArray alloc]init] forKey:keys];
}

@end
