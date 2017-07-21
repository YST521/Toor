//
//  AppDelegate.h
//  MyTeamApp
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

//@class MainViewController;



@interface AppDelegate : UIResponder <UIApplicationDelegate>
//@property(nonatomic,retain)MainViewController *mainCtrl;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

