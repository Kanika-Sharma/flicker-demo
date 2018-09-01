//
//  ViewController.m
//  FlickerDemo
//
//  Created by Kanika Sharma on 30/08/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import "ViewController.h"
#import "WebServices.h"
#import "FlickrUtility.h"
#import "CommonFunctions.h"

@interface ViewController ()
{
    NSMutableArray *imgURLArray;
    NSInteger currentPage;
    NSInteger totalPages;
    NSString *currentSearchText;
    NSMutableDictionary *dicImages_msg;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    imgURLArray = [[NSMutableArray alloc] init];
    dicImages_msg = [[NSMutableDictionary alloc] init];
    currentPage = 1;
    totalPages = 1;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refershControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.imgCollectionView addSubview:refreshControl];
    self.imgCollectionView.alwaysBounceVertical = YES;
    
}

- (void)refershControlAction : (UIRefreshControl *)refreshControl
{
    [refreshControl endRefreshing];
    [imgURLArray removeAllObjects];
    currentPage = 1;
    totalPages = 1;
    currentSearchText = @"";
    [self.searchBar resignFirstResponder];
    [self loadData];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Delegates and DataSources
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(indexPath.row < imgURLArray.count)
    {
        UIImageView *photoImageView = (UIImageView *)[cell viewWithTag:100];
        photoImageView.image = [UIImage imageNamed:@"placeholder"];
        if ([dicImages_msg valueForKey:[[imgURLArray objectAtIndex:indexPath.row] absoluteString]]) {
            photoImageView.image=[dicImages_msg valueForKey:[[imgURLArray objectAtIndex:indexPath.row] absoluteString]];
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: [self->imgURLArray objectAtIndex:indexPath.row]];
                if ( data == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    // WARNING: is the cell still using the same data by this point??
                    photoImageView.image = [UIImage imageWithData: data];
                });
            });
                [self performSelectorInBackground:@selector(downloadImage_3:) withObject:indexPath];
        }
    }
    else
    {
        if(currentPage <= totalPages)
        [self loadData];
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imgURLArray.count + 1;
}

#pragma mark - SearchBar Delegates
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    currentPage = 1;
    totalPages = 1;
    [imgURLArray removeAllObjects];
    [self.searchBar resignFirstResponder];
    [self loadData];
}

#pragma mark - Web Services

- (void)loadData
{
        NSString *searchText = _searchBar.text;
        searchText = [searchText stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(searchText.length == 0 && currentSearchText.length == 0)
        {
            currentSearchText = @"kittens";
        }
        
        [[WebServices sharedController] getDataFrom:[[CommonFunctions sharedFunctions] searchURL:currentSearchText withPageNumber : currentPage] userInfo:nil withSelector:@selector(takeResponse:)  delegate:self];
}

-(void)takeResponse:(id)data
{
    if([data isKindOfClass:[NSDictionary class]])
    {
        currentPage = [[data valueForKeyPath:@"photos.page"] integerValue] + 1;
        totalPages = [data valueForKeyPath:@"photos.pages"] ? [[data valueForKeyPath:@"photos.pages"] integerValue] : totalPages;
        for (NSDictionary *photoDictionary in [data valueForKeyPath:@"photos.photo"]) {
            NSURL *url = [[FlickrUtility sharedUtility] photoURLForSize:FKPhotoSizeThumbnail100 fromPhotoDictionary:photoDictionary];
            [imgURLArray addObject:url];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // do work here
            [self.imgCollectionView reloadData];
        });
    }
}

-(void)downloadImage_3:(NSIndexPath *)path{
    
    UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[imgURLArray objectAtIndex:path.row]]];
    
    [dicImages_msg setObject:img forKey:[[imgURLArray objectAtIndex:path.row] absoluteString]];
    
}

@end
