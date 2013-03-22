//
//  ViewController.m
//  Allroy Viewer
//
//  Created by Gary Leija on 22/03/13.
//  Copyright (c) 2013 Gary Leija. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    
	[super viewDidAppear:animated];
    int imageCount = 5;
    [self loadImagesForPage:0 maximumPages:imageCount*4];
    self.imagesContainer.contentSize = CGSizeMake(self.imagesContainer.bounds.size.width * 4, self.imagesContainer.bounds.size.height);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) loadImage:(NSInteger)imageNumber {
    int totalImages = 5;
    
    if([self.imagesContainer viewWithTag:imageNumber] !=nil){
        return;
    }
    
    NSString* imageName = [NSString stringWithFormat:@"all-%i", imageNumber %totalImages];
    NSString* imagePath = [[NSBundle mainBundle]pathForResource:imageName ofType:@".jpg"];
    UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView* imageView = [[UIImageView alloc]initWithImage:image];
    CGRect imageViewFrame = self.imagesContainer.bounds;
    imageViewFrame.origin.x = self.imagesContainer.bounds.size.width * (imageNumber - 1);
    imageView.frame = imageViewFrame;
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.tag = imageNumber;
    [self.imagesContainer addSubview:imageView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView{
    NSInteger page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width);
    [self loadImagesForPage:page maximumPages:5*4];
    // [self loadImagesForPage:page maximumPages:(NSInteger)]
}

- (void) loadImagesForPage:(NSInteger)page maximumPages:(NSInteger)maximumPages{
    
    page += 1;
    if(page - 1 >=0){
        [self loadImage:page-1];
        
    }
    [self loadImage:page];
    if( page + 1 < maximumPages){
        [self loadImage:page+1];
    }
    for (UIView* view in self.imagesContainer.subviews){
        NSInteger tag = view.tag;
        if(tag< page - 1 || tag > page + 1)
            [view removeFromSuperview];
    }
    
}


@end
