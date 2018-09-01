//
//  ViewController.h
//  FlickerDemo
//
//  Created by Kanika Sharma on 30/08/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *imgCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

