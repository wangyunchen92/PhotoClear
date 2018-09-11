//
//  ImageCompare.m
//  imageShow
//
//  Created by admin on 2017/1/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ImageCompare.h"
#import <opencv2/opencv.hpp>

@implementation ImageCompare

// 是否相似
+ (BOOL)isImage:(UIImage *)image1 likeImage:(UIImage *)image2 {
    IplImage *iplimage1 = [self convertToIplImage:[self OriginImage:image1 scaleToSize:CGSizeMake(320, 320)]];
    IplImage *iplimage2 = [self convertToIplImage:[self OriginImage:image2 scaleToSize:CGSizeMake(320, 320)]];
    double sililary = [self ComparePPKHist:iplimage1 withParam2:iplimage2];
    cvReleaseImage(&iplimage1);
    cvReleaseImage(&iplimage2);
    if (sililary < 0.1) {
        return YES;
    }
    return NO;
    
    //    NSMutableArray *str1 = [self myHash:[self getGrayImage:[self OriginImage:image1 scaleToSize:CGSizeMake(8, 8)]]];
    //    NSMutableArray *str2 = [self myHash:[self getGrayImage:[self OriginImage:image2 scaleToSize:CGSizeMake(8, 8)]]];
    //
    //    NSInteger tag = 0;
    //    for (NSInteger i =0; i< str1.count; i++) {
    //        if (str1[i] != str2[i]) {
    //            tag++;
    //        }
    //
    //    }
    //    if (tag < 5) {
    //        return YES;
    //    }
    //    return NO;
    
}

// 缩小尺寸
+ (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
    // size 为CGSize类型，即你所需要的图片尺寸
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    
    return image;
    
    
}

// 图片灰度 简化色彩
+(UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}


+ (unsigned char*)grayscalePixels:(UIImage *) image
{
    // The amount of bits per pixel, in this case we are doing grayscale so 1 byte = 8 bits
#define BITS_PER_PIXEL 8
    // The amount of bits per component, in this it is the same as the bitsPerPixel because only 1 byte represents a pixel
#define BITS_PER_COMPONENT (BITS_PER_PIXEL)
    // The amount of bytes per pixel, not really sure why it asks for this as well but it's basically the bitsPerPixel divided by the bits per component (making 1 in this case)
#define BYTES_PER_PIXEL (BITS_PER_PIXEL/BITS_PER_COMPONENT)
    
    // Define the colour space (in this case it's gray)
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceGray();
    
    // Find out the number of bytes per row (it's just the width times the number of bytes per pixel)
    size_t bytesPerRow = image.size.width * BYTES_PER_PIXEL;
    // Allocate the appropriate amount of memory to hold the bitmap context
    unsigned char* bitmapData = (unsigned char*) malloc(bytesPerRow*image.size.height);
    
    // Create the bitmap context, we set the alpha to none here to tell the bitmap we don't care about alpha values
    CGContextRef context = CGBitmapContextCreate(bitmapData,image.size.width,image.size.height,BITS_PER_COMPONENT,bytesPerRow,colourSpace,kCGImageAlphaNone);
    
    // We are done with the colour space now so no point in keeping it around
    CGColorSpaceRelease(colourSpace);
    
    // Create a CGRect to define the amount of pixels we want
    CGRect rect = CGRectMake(0.0,0.0,image.size.width,image.size.height);
    // Draw the bitmap context using the rectangle we just created as a bounds and the Core Graphics Image as the image source
    CGContextDrawImage(context,rect,image.CGImage);
    // Obtain the pixel data from the bitmap context
    unsigned char* pixelData = (unsigned char*)CGBitmapContextGetData(context);
    
    // Release the bitmap context because we are done using it
    CGContextRelease(context);
    
    return pixelData;
#undef BITS_PER_PIXEL
#undef BITS_PER_COMPONENT
}


+(NSMutableArray *)myHash:(UIImage *) img
{
    unsigned char* pixelData = [self grayscalePixels:img];
    
    int total = 0;
    int ave = 0;
    for (int i = 0; i < img.size.height; i++) {
        for (int j = 0; j < img.size.width; j++) {
            total += (int)pixelData[(i*((int)img.size.width))+j];
        }
    }
    ave = total/64;
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < img.size.height; i++) {
        for (int j = 0; j < img.size.width; j++) {
            int a = (int)pixelData[(i*((int)img.size.width))+j];
            if(a >= ave)
            {
                [result addObject:@"1"];
            }
            else
            {
                [result addObject:@"0"];
            }
        }
    }
    return result;
}


// 获取相似度
+ (float)isImageFloat:(UIImage *)image1 likeImage:(UIImage *)image2 {
    IplImage *iplimage1 = [self convertToIplImage:image1];
    IplImage *iplimage2 = [self convertToIplImage:image2];
    double sililary = [self ComparePPKHist:iplimage1 withParam2:iplimage2];
    return sililary;
}

// 比较
+ (double)ComparePPKHist:(IplImage *)srcIpl withParam2:(IplImage *)srcIpl1 {
    if (srcIpl->width==srcIpl1->width && srcIpl->height==srcIpl1->height) {
        return [self CompareHist:srcIpl withParam2:srcIpl1];
    }
    else if (srcIpl->width<srcIpl1->width && srcIpl->height==srcIpl1->height) {
        return [self CompareHistWithSmallWidthIpl:srcIpl withBigWidthIplImg:srcIpl1];
    }
    else if (srcIpl->width>srcIpl1->width && srcIpl->height==srcIpl1->height) {
        return [self CompareHistWithSmallWidthIpl:srcIpl1 withBigWidthIplImg:srcIpl];
    }
    else if (srcIpl->width==srcIpl1->width && srcIpl->height<srcIpl1->height) {
        return [self CompareHistWithSmallHeightIpl:srcIpl withBigHeightIplImg:srcIpl1];
    }
    else if (srcIpl->width==srcIpl1->width && srcIpl->height>srcIpl1->height) {
        return [self CompareHistWithSmallHeightIpl:srcIpl1 withBigHeightIplImg:srcIpl];
    }
    else if (srcIpl->width<srcIpl1->width && srcIpl->height<srcIpl1->height) {
        return [self CompareHistWithSmallIpl:srcIpl withBigIplImg:srcIpl1];
    }
    else if (srcIpl->width>srcIpl1->width && srcIpl->height>srcIpl1->height)
    {
        return [self CompareHistWithSmallIpl:srcIpl1 withBigIplImg:srcIpl];
    }
    
    return 1.f;
}

+ (double)CompareHistWithSmallWidthIpl:(IplImage*)srcIpl withBigWidthIplImg:(IplImage*)srcIpl1 {
    // 当前匹配结果，越接近于0.0匹配度越高
    double dbRst=1.0;
    // 匹配结果，-1表示正在匹配，0表示匹配失败，1表示匹配成功
    //    int tfFound = -1;
    // 裁剪后的图片
    IplImage *cropImage;
    for (int j=0; j<srcIpl1->width-srcIpl->width; j++) {
        // 裁剪图片
        cvSetImageROI(srcIpl1, cvRect(j, 0, srcIpl->width, srcIpl->height));
        cropImage = cvCreateImage(cvGetSize(srcIpl), IPL_DEPTH_8U, 3);
        cvCopy(srcIpl1, cropImage);
        cvResetImageROI(srcIpl1);
        
        // 匹配图片
        double dbRst1 =[self CompareHist:srcIpl withParam2:cropImage];
        printf("匹配结果为:%f\n",dbRst1);
        if (dbRst1<=0.01) {
            // 匹配成功
            //            tfFound = 1;
            break;
        }
        
        else if(dbRst==1.0 || dbRst1<dbRst) {
            // 本次匹配有进步，更新结果
            cvReleaseImage(&cropImage);
            dbRst = dbRst1;
        }
        
        else if(dbRst1>dbRst) {
            cvReleaseImage(&cropImage);
        }
    }
    
    return dbRst;
}

+ (double)CompareHistWithSmallHeightIpl:(IplImage*)srcIpl withBigHeightIplImg:(IplImage*)srcIpl1 {
    // 当前匹配结果，越接近于0.0匹配度越高
    double dbRst=1.0;
    // 匹配结果，-1表示正在匹配，0表示匹配失败，1表示匹配成功
    //    int tfFound = -1;
    // 裁剪后的图片
    IplImage *cropImage;
    for (int j=0; j<srcIpl1->height-srcIpl->height; j++) {
        // 裁剪图片
        cvSetImageROI(srcIpl1, cvRect(0, j, srcIpl->height, srcIpl->height));
        cropImage = cvCreateImage(cvGetSize(srcIpl), IPL_DEPTH_8U, 3);
        cvCopy(srcIpl1, cropImage);
        cvResetImageROI(srcIpl1);
        
        // 匹配图片
        double dbRst1 =[self CompareHist:srcIpl withParam2:cropImage];
        printf("匹配结果为:%f\n",dbRst1);
        if (dbRst1<=0.01) {
            // 匹配成功
            //            tfFound = 1;
            break;
        }
        else if(dbRst==1.0 || dbRst1<dbRst) {
            // 本次匹配有进步，更新结果
            cvReleaseImage(&cropImage);
            dbRst = dbRst1;
        }
        
        else if(dbRst1>dbRst) {
            cvReleaseImage(&cropImage);
        }
    }
    
    return dbRst;
}

+ (double)CompareHistWithSmallIpl:(IplImage*)srcIpl withBigIplImg:(IplImage*)srcIpl1 {
    // 当前匹配结果，越接近于0.0匹配度越高
    double dbRst=1.0;
    // 水平、竖直偏移量
    int xSub=0,ySub=0;
    // 匹配结果，-1表示正在匹配，0表示匹配失败，1表示匹配成功
    int tfFound = -1;
    // 裁剪后的图片
    IplImage *cropImage;
    
    // 遍历方式：先竖后横
    for (int j=0; j<srcIpl1->width-srcIpl->width; j++) {
        for (int i=ySub; i<srcIpl1->height-srcIpl->height; i++) {
            // 裁剪图片
            cvSetImageROI(srcIpl1, cvRect(j, i, srcIpl->width, srcIpl->height));
            cropImage = cvCreateImage(cvGetSize(srcIpl), IPL_DEPTH_8U, 3);
            cvCopy(srcIpl1, cropImage);
            cvResetImageROI(srcIpl1);
            
            // 匹配图片
            double dbRst1 =[self CompareHist:srcIpl withParam2:cropImage];
            
            printf("(x=%d,y=%d),竖直匹配结果为:%f\n",j,i,dbRst1);
            if (dbRst1<=0.0375) {
                // 匹配成功
                tfFound = 1;
                break;
            } else if(dbRst==1.0 || dbRst1<dbRst) {
                // 本次匹配有进步，更新结果
                cvReleaseImage(&cropImage);
                dbRst = dbRst1;
            } else if(dbRst1>dbRst) {
                cvReleaseImage(&cropImage);
                // 竖直移动到点了,该水平移动了
                ySub = i-1;
                for (int k=j+1;k<srcIpl1->width-srcIpl->width; k++) {
                    // 裁切图片
                    cvSetImageROI(srcIpl1, cvRect(k, i, srcIpl->width, srcIpl->height));
                    cropImage = cvCreateImage(cvGetSize(srcIpl), IPL_DEPTH_8U, 3);
                    cvCopy(srcIpl1, cropImage);
                    cvResetImageROI(srcIpl1);
                    
                    // 匹配图片
                    double dbRst1 =[self CompareHist:srcIpl withParam2:cropImage];
                    printf("(x=%d,y=%d),水平移动匹配结果为:%f\n",k,i,dbRst1);
                    if (dbRst1<=0.0375) {
                        // 匹配成功
                        tfFound = 1;
                        //                        xSub = k;
                        break;
                    } else if(dbRst1<dbRst) {
                        // 本次匹配有进步，更新结果
                        cvReleaseImage(&cropImage);
                        //                        xSub = k;
                        j = xSub;
                        dbRst = dbRst1;
                    } else {
                        cvReleaseImage(&cropImage);
                        //                        xSub = k;
                        j = xSub;
                        break;
                    }
                }
            }
            
            if (tfFound==1 || tfFound==0) {
                break;
            }
        }
        
        if (tfFound==1 || tfFound==0) {
            break;
        }
    }
    
    return dbRst;
}

// 多通道彩色图片的直方图比对
+ (double)CompareHist:(IplImage*)image1 withParam2:(IplImage*)image2 {
    int hist_size = 256;
    IplImage *gray_plane = cvCreateImage(cvGetSize(image1), 8, 1);
    cvCvtColor(image1, gray_plane, CV_BGR2GRAY);
    CvHistogram *gray_hist = cvCreateHist(1, &hist_size, CV_HIST_ARRAY);
    cvCalcHist(&gray_plane, gray_hist);
    
    IplImage *gray_plane2 = cvCreateImage(cvGetSize(image2), 8, 1);
    cvCvtColor(image2, gray_plane2, CV_BGR2GRAY);
    CvHistogram *gray_hist2 = cvCreateHist(1, &hist_size, CV_HIST_ARRAY);
    cvCalcHist(&gray_plane2, gray_hist2);
    
    cvReleaseImage(&gray_plane);
    cvReleaseImage(&gray_plane2);
    double reD = cvCompareHist(gray_hist, gray_hist2, CV_COMP_BHATTACHARYYA);
    
    cvReleaseHist(&gray_hist);
    cvReleaseHist(&gray_hist2);
    
    return reD;
}

// 单通道彩色图片的直方图
+ (double)CompareHistSignle:(IplImage*)image1 withParam2:(IplImage*)image2 {
    int hist_size = 256;
    CvHistogram *gray_hist = cvCreateHist(1, &hist_size, CV_HIST_ARRAY);
    cvCalcHist(&image1, gray_hist);
    
    CvHistogram *gray_hist2 = cvCreateHist(1, &hist_size, CV_HIST_ARRAY);
    cvCalcHist(&image2, gray_hist2);
    
    return cvCompareHist(gray_hist, gray_hist2, CV_COMP_BHATTACHARYYA);
}

// 进行肤色检测
+ (void)SkinDetect:(IplImage*)src withParam:(IplImage*)dst {
    // 创建图像头
    // 用于存图像的一个中间变量，是用来分通道用的，分成hsv通道
    IplImage* hsv = cvCreateImage(cvGetSize(src), IPL_DEPTH_8U, 3);
    // 通道的中间变量，用于肤色检测的中间变量
    IplImage* tmpH1 = cvCreateImage( cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* tmpS1 = cvCreateImage(cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* tmpH2 = cvCreateImage(cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* tmpS2 = cvCreateImage(cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* tmpH3 = cvCreateImage(cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* tmpS3 = cvCreateImage(cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* H = cvCreateImage( cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* S = cvCreateImage( cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* V = cvCreateImage( cvGetSize(src), IPL_DEPTH_8U, 1);
    IplImage* src_tmp1=cvCreateImage(cvGetSize(src),8,3);
    
    // 高斯模糊
    cvSmooth(src,src_tmp1,CV_GAUSSIAN,3,3);
    
    // hue色度，saturation饱和度，value纯度
    cvCvtColor(src_tmp1, hsv, CV_BGR2HSV );
    // 分为3个通道
    cvSplit(hsv,H,S,V,0);
    
    /*********************肤色检测部分**************/
    cvInRangeS(H,cvScalar(0.0,0.0,0,0),cvScalar(20.0,0.0,0,0),tmpH1);
    cvInRangeS(S,cvScalar(75.0,0.0,0,0),cvScalar(200.0,0.0,0,0),tmpS1);
    cvAnd(tmpH1,tmpS1,tmpH1,0);
    
    // Red Hue with Low Saturation
    // Hue 0 to 26 degree and Sat 20 to 90
    cvInRangeS(H,cvScalar(0.0,0.0,0,0),cvScalar(13.0,0.0,0,0),tmpH2);
    cvInRangeS(S,cvScalar(20.0,0.0,0,0),cvScalar(90.0,0.0,0,0),tmpS2);
    cvAnd(tmpH2,tmpS2,tmpH2,0);
    
    // Red Hue to Pink with Low Saturation
    // Hue 340 to 360 degree and Sat 15 to 90
    cvInRangeS(H,cvScalar(170.0,0.0,0,0),cvScalar(180.0,0.0,0,0),tmpH3);
    cvInRangeS(S,cvScalar(15.0,0.0,0,0),cvScalar(90.,0.0,0,0),tmpS3);
    cvAnd(tmpH3,tmpS3,tmpH3,0);
    
    // Combine the Hue and Sat detections
    cvOr(tmpH3,tmpH2,tmpH2,0);
    cvOr(tmpH1,tmpH2,tmpH1,0);
    cvCopy(tmpH1,dst);
    cvReleaseImage(&hsv);
    cvReleaseImage(&tmpH1);
    cvReleaseImage(&tmpS1);
    cvReleaseImage(&tmpH2);
    cvReleaseImage(&tmpS2);
    cvReleaseImage(&tmpH3);
    cvReleaseImage(&tmpS3);
    cvReleaseImage(&H);
    cvReleaseImage(&S);
    cvReleaseImage(&V);
    cvReleaseImage(&src_tmp1);
}

// UIImage类型转换为IPlImage类型
+ (IplImage*)convertToIplImage:(UIImage*)image {
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, image.size.width, image.size.height));
    //    CGImageRef imageRef = image.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    IplImage *iplImage = cvCreateImage(cvSize(image.size.width, image.size.height), IPL_DEPTH_8U, 4);
    CGContextRef contextRef = CGBitmapContextCreate(iplImage->imageData, iplImage->width, iplImage->height, iplImage->depth, iplImage->widthStep, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    IplImage *ret = cvCreateImage(cvGetSize(iplImage), IPL_DEPTH_8U, 3);
    cvCvtColor(iplImage, ret, CV_RGB2BGR);
    cvReleaseImage(&iplImage);
    CGImageRelease(imageRef);
    return ret;
}

// IplImage类型转换为UIImage类型
+ (UIImage*)convertToUIImage:(IplImage*)image {
    cvCvtColor(image, image, CV_BGR2RGB);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSData *data = [NSData dataWithBytes:image->imageData length:image->imageSize];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    CGImageRef imageRef = CGImageCreate(image->width, image->height, image->depth, image->depth * image->nChannels, image->widthStep, colorSpace, kCGImageAlphaNone | kCGBitmapByteOrderDefault, provider, NULL, false, kCGRenderingIntentDefault);
    
    UIImage *ret = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    return ret;
}

@end
