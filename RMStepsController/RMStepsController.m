//
//  RMViewController.m
//  RMStepsController
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RMStepsController.h"
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0f)
#define IS_IPHONE_XS_MAX (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0f)
@interface RMStepsController () <RMStepsBarDelegate, RMStepsBarDataSource>

@property (nonatomic, strong, readwrite) NSMutableDictionary *results;
@property (nonatomic, strong) UIViewController *currentStepViewController;

@property (nonatomic, strong, readwrite) RMStepsBar *stepsBar;
@property (nonatomic, strong) UIView *stepViewControllerContainer;
@property (nonatomic, strong) UIView *naviBar;

@end

@implementation RMStepsController

#pragma mark - Configuration
- (NSArray *)stepViewControllers {
    return @[];
}

#pragma mark - Init and Dealloc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.stepViewControllerContainer];
    [self.view addSubview:self.stepsBar];
    [self.view addSubview:self.naviBar];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.naviTitle];
    
    RMStepsBar *stepsBar = self.stepsBar;
    UIView *container = self.stepViewControllerContainer;
    UIView *navi = self.naviBar;
    UIButton *backButton = self.backButton;
    UILabel *title = self.naviTitle;
    
    NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(navi, stepsBar, container,backButton,title);
    
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[navi(64)]-[stepsBar]" options:0 metrics:nil views:bindingsDict]];
     int height = 108;
    if (IS_IPHONE_X || IS_IPHONE_XS_MAX) {
         [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[navi(88)]-[stepsBar(44)]-[container]-(0)-|" options:0 metrics:nil views:bindingsDict]];
        height = 132;
    }else{
         [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[navi(64)]-[stepsBar(44)]-[container]-(0)-|" options:0 metrics:nil views:bindingsDict]];
        height = 108;
    }
   
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[stepsBar]-0-|" options:0 metrics:nil views:bindingsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[navi]-0-|" options:0 metrics:nil views:bindingsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[container]-0-|" options:0 metrics:nil views:bindingsDict]];
    
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-12-[backButton(64)]-12-[title]-88-|" options:0 metrics:nil views:bindingsDict]];
     //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backButton]-12-[stepBar]" options:0 metrics:nil views:bindingsDict]];
    
  //   [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[title(32)]" options:0 metrics:nil views:bindingsDict]];
    
    // [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[title]-12-[stepBar]" options:0 metrics:nil views:bindingsDict]];
    
    // [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backButton]-12-[stepBar]" options:0 metrics:nil views:bindingsDict]];
    
//    NSLayoutConstraint *titleConstraint = [NSLayoutConstraint constraintWithItem:self.naviTitle
//     attribute:NSLayoutAttributeCenterX
//     relatedBy:NSLayoutRelationEqual
//        toItem:self.view
//     attribute:nil
//    multiplier:1.0f
//      constant:0.0f];
//    [self.view addConstraint:titleConstraint];
    
    NSLayoutConstraint *titelHeightconstraint = [NSLayoutConstraint constraintWithItem:self.naviTitle attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.naviBar attribute:NSLayoutAttributeBottom multiplier:1 constant:-12];
       [self.view addConstraint:titelHeightconstraint];
    
    NSLayoutConstraint *buttonContraint = [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.naviTitle attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
          [self.view addConstraint:buttonContraint];
    
//
//    NSLayoutConstraint *titleContraint = [NSLayoutConstraint constraintWithItem:self.naviTitle
//        attribute:NSLayoutAttributeBottom
//        relatedBy:NSLayoutRelationEqual
//           toItem:self.stepsBar
//        attribute:NSLayoutAttributeTop
//       multiplier:1.0f
//         constant:12.0f];
//
//    NSLayoutConstraint *buttonContraint = [NSLayoutConstraint constraintWithItem:self.backButton
//           attribute:NSLayoutAttributeCenterY
//           relatedBy:NSLayoutRelationEqual
//              toItem:self.naviTitle
//           attribute:NSLayoutAttributeNotAnAttribute
//          multiplier:1.0f
//            constant:0.0f];
    
   // [self.naviBar addConstraints:titleContraint];
   // [self.view addConstraints:buttonContraint];
    //[self.naviBar addConstraint:constraint];
    
   
    
//
//    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.stepsBar attribute:NSLayoutAttributeBaseline multiplier:1 constant:12];
//    [self.view addConstraint:constraint];
    
    [self loadStepViewControllers];
    [self showStepViewController:[self.childViewControllers objectAtIndex:0] animated:NO];
}

#pragma mark - Properties
- (NSMutableDictionary *)results {
    if(!_results) {
        self.results = [@{} mutableCopy];
    }
    
    return _results;
}

- (RMStepsBar *)stepsBar {
    if(!_stepsBar) {
        self.stepsBar = [[RMStepsBar alloc] initWithFrame:CGRectZero];
        _stepsBar.delegate = self;
        _stepsBar.dataSource = self;
    }
    
    return _stepsBar;
}

- (UIView *)stepViewControllerContainer {
    if(!_stepViewControllerContainer) {
        self.stepViewControllerContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _stepViewControllerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _stepViewControllerContainer;
}

-(UILabel *)naviTitle{
    if (!_naviTitle) {
        self.naviTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _naviTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _naviTitle.textAlignment = UITextAlignmentCenter;
    }
    return _naviTitle;
}

-(UIButton *)backButton{
    if (!_backButton) {
           self.backButton = [[UIButton alloc] initWithFrame:CGRectZero];
           _backButton.translatesAutoresizingMaskIntoConstraints = NO;
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
       }
    
       return _backButton;
}


-(UIView *)naviBar{
    if(!_naviBar){
        self.naviBar = [[UIView alloc] initWithFrame:CGRectZero];
        _naviBar.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _naviBar;
}

#pragma mark - Helper
- (BOOL)extendViewControllerBelowBars:(UIViewController *)aViewController {
    return (aViewController.extendedLayoutIncludesOpaqueBars || (aViewController.edgesForExtendedLayout & UIRectEdgeTop));
}

- (void)updateContentInsetsForViewController:(UIViewController *)aViewController {
    if([self extendViewControllerBelowBars:aViewController]) {
        UIEdgeInsets insets = UIEdgeInsetsZero;
        insets.top += self.stepsBar.frame.size.height;
        
        [aViewController adaptToEdgeInsets:insets];
    }
}

- (void)loadStepViewControllers {
    NSArray *stepViewControllers = [self stepViewControllers];
    NSAssert([stepViewControllers count] > 0, @"Fatal: At least one step view controller must be returned by -[%@ stepViewControllers].", [self class]);
    
    for(UIViewController *aViewController in stepViewControllers) {
        NSAssert([aViewController isKindOfClass:[UIViewController class]], @"Fatal: %@ is not a subclass from UIViewController. Only UIViewControllers are supported by RMStepsController as steps.", [aViewController class]);
        
        aViewController.stepsController = self;
        
        [aViewController willMoveToParentViewController:self];
        [self addChildViewController:aViewController];
        [aViewController didMoveToParentViewController:self];
    }
    
    [self.stepsBar reloadData];
}

- (void)showStepViewController:(UIViewController *)aViewController animated:(BOOL)animated {
    if(!animated) {
        [self showStepViewControllerWithoutAnimation:aViewController];
    } else {
        [self showStepViewControllerWithSlideInAnimation:aViewController];
    }
    
    [self updateContentInsetsForViewController:aViewController];
}

- (void)showStepViewControllerWithoutAnimation:(UIViewController *)aViewController {
    [self.currentStepViewController.view removeFromSuperview];
    
    CGFloat y = 0;
    if(![self extendViewControllerBelowBars:aViewController])
        y = self.stepsBar.frame.origin.y + self.stepsBar.frame.size.height;
    
    aViewController.view.frame = CGRectMake(0, y, self.stepViewControllerContainer.frame.size.width, self.stepViewControllerContainer.frame.size.height - y);
    aViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    aViewController.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self.stepViewControllerContainer addSubview:aViewController.view];
    
    self.currentStepViewController = aViewController;
    [self.stepsBar setIndexOfSelectedStep:[self.childViewControllers indexOfObject:aViewController] animated:NO];
}

- (void)showStepViewControllerWithSlideInAnimation:(UIViewController *)aViewController {
    NSInteger oldIndex = [self.childViewControllers indexOfObject:self.currentStepViewController];
    NSInteger newIndex = [self.childViewControllers indexOfObject:aViewController];
    
    BOOL fromLeft = NO;
    if(oldIndex < newIndex)
        fromLeft = NO;
    else
        fromLeft = YES;
    
    CGFloat y = 0;
    if(![self extendViewControllerBelowBars:aViewController])
        y = self.stepsBar.frame.origin.y + self.stepsBar.frame.size.height;
    
    aViewController.view.frame = CGRectMake(fromLeft ? -self.stepViewControllerContainer.frame.size.width : self.stepViewControllerContainer.frame.size.width, y, self.stepViewControllerContainer.frame.size.width, self.stepViewControllerContainer.frame.size.height - y);
    aViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    aViewController.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self.stepViewControllerContainer addSubview:aViewController.view];
    
    [self.stepsBar setIndexOfSelectedStep:[self.childViewControllers indexOfObject:aViewController] animated:YES];
    
    __weak RMStepsController *blockself = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        aViewController.view.frame = CGRectMake(0, y, blockself.stepViewControllerContainer.frame.size.width, blockself.stepViewControllerContainer.frame.size.height - y);
        blockself.currentStepViewController.view.frame = CGRectMake(fromLeft ? blockself.stepViewControllerContainer.frame.size.width : -blockself.stepViewControllerContainer.frame.size.width, blockself.currentStepViewController.view.frame.origin.y, blockself.currentStepViewController.view.frame.size.width, blockself.currentStepViewController.view.frame.size.height);
    } completion:^(BOOL finished) {
        [blockself.currentStepViewController.view removeFromSuperview];
        blockself.currentStepViewController = aViewController;
    }];
}

- (void)viewDidLayoutSubviews {
    CGFloat y = 0;
    if(![self extendViewControllerBelowBars:self.currentStepViewController])
        y = self.stepsBar.frame.origin.y + self.stepsBar.frame.size.height;
    
    self.currentStepViewController.view.frame = CGRectMake(0, y, self.stepViewControllerContainer.frame.size.width, self.stepViewControllerContainer.frame.size.height - y);
    [self updateContentInsetsForViewController:self.currentStepViewController];
}

#pragma mark - Actions
- (void)showNextStep {
    NSInteger index = [self.childViewControllers indexOfObject:self.currentStepViewController];
    if(index < [self.childViewControllers count]-1) {
        UIViewController *nextStepViewController = [self.childViewControllers objectAtIndex:index+1];
        [self showStepViewController:nextStepViewController animated:YES];
    } else {
        [self finishedAllSteps];
    }
}

- (void)showPreviousStep {
    NSInteger index = [self.childViewControllers indexOfObject:self.currentStepViewController];
    if(index > 0) {
        UIViewController *nextStepViewController = [self.childViewControllers objectAtIndex:index-1];
        [self showStepViewController:nextStepViewController animated:YES];
    } else {
        [self canceled];
    }
}

- (void)showStepForIndex:(NSInteger)index {
    UIViewController *stepViewController = [self.childViewControllers objectAtIndex:index];
    [self showStepViewController:stepViewController animated:YES];
}

- (void)finishedAllSteps {
    NSLog(@"Finished");
}

- (void)canceled {
    NSLog(@"Canceled");
}

#pragma mark - RMStepsBar Delegates
- (NSUInteger)numberOfStepsInStepsBar:(RMStepsBar *)bar {
    return [self.childViewControllers count];
}

- (RMStep *)stepsBar:(RMStepsBar *)bar stepAtIndex:(NSUInteger)index {
    return [(UIViewController *)[self.childViewControllers objectAtIndex:index] step];
}

- (void)stepsBarDidSelectCancelButton:(RMStepsBar *)bar {
    [self canceled];
}

- (void)stepsBar:(RMStepsBar *)bar shouldSelectStepAtIndex:(NSInteger)index {
    [self showStepViewController:[self.childViewControllers objectAtIndex:index] animated:YES];
}

@end

#pragma mark - Helper Categories

#import <objc/runtime.h>

static char const * const stepsControllerKey = "stepsControllerKey";
static char const * const stepKey = "stepKey";

@implementation UIViewController (RMStepsController)

@dynamic stepsController, step;

#pragma marl - Properties
- (RMStepsController *)stepsController {
    return objc_getAssociatedObject(self, stepsControllerKey);
}

- (void)setStepsController:(RMStepsController *)stepsController {
    objc_setAssociatedObject(self, stepsControllerKey, stepsController, OBJC_ASSOCIATION_ASSIGN);
}

- (RMStep *)step {
    RMStep *aStep = objc_getAssociatedObject(self, stepKey);
    if(!aStep) {
        aStep = [[RMStep alloc] init];
        self.step = aStep;
    }
    
    return aStep;
}

- (void)setStep:(RMStep *)step {
    objc_setAssociatedObject(self, stepKey, step, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Helper
- (void)adaptToEdgeInsets:(UIEdgeInsets)newInsets {
    
}

@end

@interface UITableViewController (RMMultipleViewsController)
@end

@implementation UITableViewController (RMMultipleViewsController)

#pragma mark - Helper
- (void)adaptToEdgeInsets:(UIEdgeInsets)newInsets {
    self.tableView.contentInset = newInsets;
    self.tableView.scrollIndicatorInsets = newInsets;
}

@end

@interface UICollectionViewController (RMMultipleViewsController)
@end

@implementation UICollectionViewController (RMMultipleViewsController)

#pragma mark - Helper
- (void)adaptToEdgeInsets:(UIEdgeInsets)newInsets {
    self.collectionView.contentInset = newInsets;
    self.collectionView.scrollIndicatorInsets = newInsets;
}

@end
