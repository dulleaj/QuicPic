//
//  HomePage.m
//  QuicPic
//
//  Created by Andrew Dulle on 6/29/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "HomePage.h"
#import "Firebase.h"
#import "CollectionViewCell.h"

@interface HomePage () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property NSMutableArray* userPhotoArray;
@property (weak, nonatomic) IBOutlet UICollectionView *userPhotoCollection;
@property CollectionViewCell* cell;

@end


@implementation HomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userPhotoArray = [[NSMutableArray alloc] init];
    
    [self.userPhotoCollection reloadData];
    
    [self.userPhotoCollection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Photo"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//Launching camera
- (IBAction)goToCameraWasPressed:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:picker animated:YES completion:NULL];
    
}

//Dismissing camera
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); //2
    
    //[image setItemSize:CGSizeMake(320, 548)];
    
    [self.userPhotoArray addObject:image];
    
    NSData* data = UIImagePNGRepresentation(image);
    
    //NSString *stringForm = [data base64EncodedStringWithOptions:0]; //3

    /*[FIRAnalytics logEventWithName:kFIREventSelectContent parameters:@{
                                                                       kFIRParameterContentType:@"Added Picture",
                                                                       kFIRParameterItemID:stringForm
                                                                       }];
*/
    
}

//Adjusting an image's size
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

//Setting the number of cells to match the objects in the array
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPhotoArray.count;
    
}

//Editing the cells
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"Photo" forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[self.cell viewWithTag:100];
    
    recipeImageView.image = [UIImage imageNamed:[self.userPhotoArray objectAtIndex:indexPath.row]];
    
    //recipeImageView.image = [self imageWithImage:recipeImageView.image convertToSize:??];
    
    self.cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border"]];
    
    [self.view addSubview:recipeImageView];
    
    self.cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[self.userPhotoArray objectAtIndex:indexPath.row]]];
    
    //self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    //self.cell.cellImage = (UIImageView *)[self.cell viewWithTag:100];
    //self.cell.cellImage.image = [self.userPhotoArray objectAtIndex:indexPath.row];
    
    return self.cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
 1 = removed http://stackoverflow.com/questions/12143028/add-to-nsdictionary-entries-to-nsmutabledictionary
 2 = http://stackoverflow.com/questions/11131050/how-can-i-save-an-image-to-the-camera-roll
 3 = http://stackoverflow.com/questions/25923567/nsdata-on-firebase
 
 URL = :@"https://quicpic-aeb2d.firebaseio.com"

 //data = [[NSData alloc] initWithBase64EncodedString:stringForm options:0]; //for conversion to image
 //http://stackoverflow.com/questions/25923567/nsdata-on-firebase
 
*/


@end
