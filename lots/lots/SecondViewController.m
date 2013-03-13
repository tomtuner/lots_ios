//
//  SecondViewController.m
//  lots
//
//  Created by Thomas DeMeo on 3/11/13.
//  Copyright (c) 2013 Thomas DeMeo. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Check-in", @"check-ing tab");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
        @try {
    		NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                          NSUserDomainMask, YES) objectAtIndex:0];
            NSLog(@"Scan Data Archive String: %@", LSAllLotsArchiveString);
			NSString *archivePath = [documentsDir stringByAppendingPathComponent:LSAllLotsArchiveString];
			self.lotArray = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
		}
		@catch (...)
		{
            NSLog(@"Exception unarchiving file.");
    	}
        
        if (!self.lotArray) {
			self.lotArray = [[NSMutableArray alloc] init];
        }
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.lotCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LSCollectionViewCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected!");
    // TODO: Select Item
    ExploreLots *chosenLot = [self.lotArray objectAtIndex:indexPath.row];
    CheckInViewController *chkController = [[CheckInViewController alloc] initWithNibName:@"CheckInViewController" bundle:nil];
    chkController.lot = chosenLot;
    [self presentViewController:chkController animated:YES completion:nil];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
    NSLog(@"Deselected!");

}

#pragma mark – UICollectionViewDelegateFlowLayout
/*
// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExploreLots *lot =  self.lotArray[indexPath.row];
    // 2
    CGSize retval = lot.thumbnail.size.width > 0 ? lot.thumbnail.size : CGSizeMake(100, 100);
    retval.height += 35;
    retval.width += 35;
    return retval;
}
*/
// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.lotArray count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"LSCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) ];
    ExploreLots *lot = [self.lotArray objectAtIndex:indexPath.row];
    titleLabel.text = lot.name;
    [cell addSubview:titleLabel];
    
//    UICollectionViewCell *cell = [cv dequeueReusableCellWithIdentifier:@"LSCollectionViewCell"];
//    if (cell == nil)
//	{
//        cell = [[UICollectionViewCell alloc] initWithStyle:UICollectionViewSty
//                                      reuseIdentifier:@"LSExploreCell"];
//        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    return cell;
}

@end
