//
//  TestViewController.m
//  test
//
//  Created by tuanche on 16/1/12.
//  Copyright © 2016年 tuancheWJ. All rights reserved.
//

#import "CarImageBroswerViewController.h"
#import "WJScrollView.h"
#import "SmallCarImageView.h"
#import "BigCarImageView.h"
@interface CarImageBroswerViewController ()<WJScrolViewDataSource>

@property (nonatomic, strong) WJScrollView *scrollView;
@property (nonatomic, strong) WJScrollView *scrollView2;
@property (nonatomic, assign) NSInteger pageCount;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (nonatomic, strong) NSArray *array;


@end

@implementation CarImageBroswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    _array = @[
               @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
               @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
               @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
               @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
               @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
               
               @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
               @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
               @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
               @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
               @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
               
               @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
               @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
               @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
               @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
               @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
               
               @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
               @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
               @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
               @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
               @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg"
               ];

    _scrollView=[[WJScrollView alloc] initWithFrame:CGRectMake(0, 44, kMainBoundsWidth, 200) count:0];
    _scrollView.dataSource = self;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _pageCount= 20;
    _pageLabel.text = @"1/9";
//    _scrollView.contentSize = CGSizeMake(frame.size.width * _pageCount, 200);

    [self.view addSubview:_scrollView];
    [_scrollView reloadData];
    
    _scrollView2 =[[WJScrollView alloc] initWithFrame:CGRectMake(0, 250, kMainBoundsWidth, 200) count:0];
    _scrollView2.dataSource = self;
    _scrollView2.backgroundColor = [UIColor clearColor];
//    _scrollView2.pagingEnabled=YES;
    _pageCount= 20;
//    _scrollView2.contentSize = CGSizeMake(frame.size.width / 3 * _pageCount, 200);
    
    [self.view addSubview:_scrollView2];
    [_scrollView2 reloadData];
    // Do any additional setup after loading the view from its nib.
    

}

//返回总页码
-(NSInteger)numberOfPagesInWJScrollView:(WJScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        return _pageCount;

    }else{
        return _pageCount;
    }
}
//获得指定页的位置和大小
-(CGSize)perPageSizeInWJScrollView:(WJScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        return CGSizeMake(_scrollView.frame.size.width, 200);
    }else{
       return CGSizeMake(_scrollView.frame.size.width / 3, 200);
    }

}
//获得指定页实例
-(WJItemView *)wjScrollView:(WJScrollView *)scrollView pageForIndex:(NSInteger)index
{
    BigCarImageView *page = [[[NSBundle mainBundle] loadNibNamed:@"BigCarImageView" owner:self options:nil]lastObject];
    SmallCarImageView *page2 = [[[NSBundle mainBundle] loadNibNamed:@"SmallCarImageView" owner:self options:nil]lastObject];
    page2.target = self;
    page2.action = @selector(itemClick);
    
    __weak typeof(self) weakself = self;
    page2.block = ^(WJItemView *item, NSInteger index){
//        weakself.pageCount = 8;
//        weakself.scrollView.contentSize = CGSizeMake(kMainBoundsWidth * weakself.pageCount, 200);
        [weakself.scrollView scrollToPage:index animated:YES];
//        weakself.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",index + 1,weakself.pageCount];
//        [weakself.scrollView reloadData];
    };
    if (scrollView == _scrollView) {
        return page;
    }else{
        return page2;
    }
}
//返回要显示的数据对象
-(id)wjScrollView:(WJScrollView *)scrollView dataObjectForIndex:(NSInteger)index
{
//    NSString *imageName;
//    
//    imageName=[NSString stringWithFormat:@"%zd.png",index+1];
//
//    return imageName;

    return _array[index];
//    
    
}

-(void)wjScrollView:(WJScrollView *)scrollView pageChange:(NSInteger)pageNumber animated:(BOOL)animated
{
    if (_scrollView == scrollView) {
        
        _pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",pageNumber+1,_pageCount];
        NSLog(@"第%zd页",pageNumber);

    }
}

- (void)itemClick
{
//    NSLog(@"1111");
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender {
    
    //取出itemView
    BigCarImageView *itemView = _scrollView.currentView;
    
    NSLog(@"%@",itemView);
    if(!itemView.hasImage){

        return;
    }
    

    

    
}

- (IBAction)changeBtn:(UIButton *)sender {
    if (sender.tag == 91) {  // 外观
        
    }else if (sender.tag == 92){ // 内饰
        
    }else{ // 空间
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
