//
//  PhotoCollectionVC.m
//  szone
//
//  Created by zhuyq-MacBook Pro on 14/12/1.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "PhotoCollectionVC.h"
@interface PhotoCollectionVC ()
@property(nonatomic,strong)NSMutableArray *photoPaths;

@end

@implementation PhotoCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片";
//    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize=CGSizeMake(100,100);
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    
//    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 100) collectionViewLayout:flowLayout];
    UIBarButtonItem *editBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:@selector(editPhoto:)];
    editBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = editBarBtn;
    UIImageView *backgroundIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing"]];
    [self.collectionView setBackgroundView:backgroundIV];
    
    _photoPaths = [NSMutableArray array];
    //获取document路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    [self findJpgInPath:documentPath];

    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

-(void)findJpgInPath:(NSString *)path{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:Nil];
    for (NSString *fileName in fileNames) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        
        BOOL isDir;
        if ([fm fileExistsAtPath:filePath isDirectory:&isDir]&&isDir) {//如果是文件夹
            [self findJpgInPath:filePath];//递归继续搜索
        }else//说明是文件
        if ([filePath hasSuffix:@"jpg"]||[filePath hasSuffix:@"JPG"]) {
            NSLog(@"照片路径%@",filePath);
            [_photoPaths addObject:filePath];
        }   
    } 
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)editPhoto:(UIBarButtonItem*)sender{
    switch (sender.tag) {
        case 0:
            [sender setTitle:@"取消"];
            sender.tag = 1;
            break;
        case 1:
            [sender setTitle:@"选择"];
            sender.tag = 0;
            break;
    }
    
}
#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _photoPaths.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageWithContentsOfFile:_photoPaths[indexPath.item]];
    cell.backgroundView = [[UIImageView alloc]initWithImage:image];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WIDTH/3.5,WIDTH/3.5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(WIDTH/64, WIDTH/32, WIDTH/64, WIDTH/32);
}

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.alpha = .6;
    UIImageView *selectedIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedColleView"]];
    selectedIV.frame = CGRectMake(72, 72, 25, 25);
    [cell addSubview:selectedIV];

    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.alpha = 1;
}

// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item


- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}


@end
