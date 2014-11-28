//
//  MoreTableVC.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/17.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "MoreTableVC.h"
#import "CustomMoreCell.h"

#import "UploadVC.h"

@interface MoreTableVC () 
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSArray *infoStrings;
@end

@implementation MoreTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    self.tableView.scrollEnabled = NO;
    _images = @[@"cell_upload",@"cell_share",@"cell_case",@"cell_about_illness",@"cell_userInfo",@"cell_device",@"cell_help",@"cell_about_us",@"cell_exist"];
    
    _infoStrings = @[@"上传",@"分享",@"病例",@"相关疾病简介",@"更改用户信息",@"更改设备名称",@"帮助",@"关于我们",@"退出"];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _images.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CustomMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CustomMoreCell" owner:self options:nil][0];
    }
    UIImage *image = [UIImage imageNamed:_images[indexPath.row]];
    cell.leftIV.image = image;
    cell.textLb.text = _infoStrings[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UploadVC *uploadVC = [[UploadVC alloc]init];
    switch (indexPath.row) {
        case 0:
//            uploadVC.transitioningDelegate = self;
//            uploadVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:uploadVC animated:YES completion:nil];
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (HEIGHT-92)/9;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
