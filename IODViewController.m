//
//  IODViewController.m
//  gestureRecognizer
//
//  Created by Aditya Narayan on 1/15/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "IODViewController.h"

@interface IODViewController ()

@end

@implementation IODViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UILongPressGestureRecognizer * longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToLongPressGesture:)];

    //add longPressRecognizer as a new GestureRecognizer
    
    [self.view addGestureRecognizer: longPressRecognizer];
    
    bubbleArray = [[NSMutableArray alloc] init];


}



-(void)respondsToLongPressGesture:(UILongPressGestureRecognizer *)recognizer {
    
    
    
    //if recognizer state is anything other than stateBegan, terminate method
    
    if(recognizer.state != UIGestureRecognizerStateBegan) {
        
        return;
    }
    
    //store CGPoint for longPress
    
    locationOfLongPress = [recognizer locationInView: self.view];
    
    
    NSLog(@"X Value for location = %f Y Value for location = %f", locationOfLongPress.x, locationOfLongPress.y);
    
    
    // call CGRectMake method
    
    [self createBubble];
    
    
}

-(void) createBubble {
    
    // store screen width and height as floats
    
    float screenWidth = self.view.frame.size.width;
    
    float screenHeight = self.view.frame.size.height;
    
    NSLog(@"Screen Width = %f", screenWidth);
    
    NSLog(@"Screen Height = %f", screenHeight);
    
    // proportionally calculate the width and height of bubble
    
    float bubbleWidth = 0.20833 * screenWidth;
    
    float bubbleHeight = 0.087891 * screenHeight;
    
    NSLog(@"bubbleWidth = %f", bubbleWidth);
    
    NSLog(@"bubbleHeight = %f", bubbleHeight);
    
    //make rectangle for bubble and center it by subtracting half the bubble width and height from the x and y coordinates
    
    UIView * bubbleRectangle = [[UIView alloc] initWithFrame:CGRectMake(locationOfLongPress.x - (bubbleWidth * 0.5), locationOfLongPress.y, bubbleWidth, bubbleHeight)];
    
    bubbleRectangle.backgroundColor = [UIColor yellowColor];
    
    
    UIView *bubbleRectangleWithBoundary = [[UIView alloc] initWithFrame:bubbleRectangle.frame];
    
    CGFloat heightBoundary = 10;
    
    //bubbleRectangleWithBoundary.bounds.size.height += 10;
    
    
    
    //if bubble frame overlaps with already existing bubble, alert user
    
    for (UIView *currBubble in bubbleArray) {
        if (CGRectIntersectsRect(bubbleRectangle.frame, currBubble.frame)) {
            
            NSLog(@"Bubble overlaps with existing bubble");
            return;
        }
    }
    
    
    
    
    //add bubbleRectangle to view
    
    [bubbleArray addObject:bubbleRectangle];
    
    [self.view addSubview:bubbleRectangle];
    
    //    [UIView animateWithDuration:1 delay:1.5 options:UIViewAnimationOptionCurveEaseOut animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
