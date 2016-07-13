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
    
    self.cell = [[CollectionViewCell alloc] init];
    
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
    
    [self.userPhotoArray addObject:image];
    
    [self.userPhotoCollection reloadData];
    
    NSData* data = UIImagePNGRepresentation(image);
    
    //NSString *stringForm = [data base64EncodedStringWithOptions:0]; //3

    /*[FIRAnalytics logEventWithName:kFIREventSelectContent parameters:@{
                                                                       kFIRParameterContentType:@"Added Picture",
                                                                       kFIRParameterItemID:stringForm
                                                                       }];
*/
    
    //[FIRAnalytics setUserPropertyString:@"" forName:<#(nonnull NSString *)#>]
    
}


- (UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width{
    
    float newWidth = i_width;
    float newHeight = newWidth;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//Setting the number of cells to match the objects in the array
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPhotoArray.count;
    
}

//Editing the cells
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"Photo" forIndexPath:indexPath];
    
    UIImage* imageFromArray = [self.userPhotoArray objectAtIndex:indexPath.row];
    
    self.cell.backgroundColor=[UIColor colorWithPatternImage:[self imageWithImage:imageFromArray scaledToWidth:125]];
    
    return self.cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(125.f, 125.f);
}

/*
 1 = removed http://stackoverflow.com/questions/12143028/add-to-nsdictionary-entries-to-nsmutabledictionary
 2 = http://stackoverflow.com/questions/11131050/how-can-i-save-an-image-to-the-camera-roll
 3 = http://stackoverflow.com/questions/25923567/nsdata-on-firebase
 4 = adjusting size based on orinetation: http://stackoverflow.com/questions/13556554/change-uicollectionviewcell-size-on-different-device-orientations
 
 URL = :@"https://quicpic-aeb2d.firebaseio.com"

 //data = [[NSData alloc] initWithBase64EncodedString:stringForm options:0]; //for conversion to image
 //http://stackoverflow.com/questions/25923567/nsdata-on-firebase
 
*/


@end
