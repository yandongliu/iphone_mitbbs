//
//  MyUtils.m
//  multiview1
//
//  Created by Yandong Liu on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyUtils.h"
#import "iconv.h"

@implementation MyUtils

+ (NSData *)convert_gbk2utf8:(NSData *)data {
    iconv_t cd = iconv_open("UTF8", "GBK"); // convert to UTF-8 from UTF-8
    if (cd == (iconv_t)-1) {
        perror ("-1 iconv_open");
    }
    int one = 1;
    iconvctl(cd, ICONV_SET_DISCARD_ILSEQ, &one); // discard invalid characters
    
    size_t inbytesleft, outbytesleft;
    inbytesleft = outbytesleft = data.length;
    char *inbuf  = (char *)data.bytes;
    char *outbuf = malloc(sizeof(char) * data.length*2);
    outbytesleft*=2;
    char *outptr = outbuf;
    //NSLog(@"source length1:%lu", inbytesleft);
    //NSLog(@"target length1:%lu", outbytesleft);
    if (iconv(cd, &inbuf, &inbytesleft, &outptr, &outbytesleft)
        == (size_t)-1) {
        NSLog(@"Errno 2:%d", errno);
        if (errno == EINVAL)
            NSLog(@"conversion from to wchar_t not available");
        else
            perror ("iconv");
        NSLog(@"this should not happen, seriously:%d", errno);
        return nil;
    }
    //NSLog(@"source length2:%lu", inbytesleft);
    //NSLog(@"target length2:%lu", outbytesleft);
    NSData *result = [NSData dataWithBytes:outbuf length:data.length*2 - outbytesleft];
    iconv_close(cd);
    free(outbuf);
    return result;
}

@end
