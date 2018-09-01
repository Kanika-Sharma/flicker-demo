//
//  WebServices.m
//  FlickerDemo
//
//  Created by Kanika Sharma on 31/08/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices

static WebServices* _sharedServerController;


+ (WebServices*)sharedController
{
    @synchronized(self)
    {
        if (_sharedServerController == nil)
        {
            _sharedServerController=[[self alloc] init];
        }
    }
    return _sharedServerController;
}

- (void) getDataFrom:(NSString *)url userInfo:(NSMutableDictionary *)userParams withSelector:(SEL)selector delegate:(id)delegate
{
    self.delegate = delegate;
    self.selectorMethod = selector;
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            
            [self dictionaryForJsonString:nil errorServer:nil userInfo:responseDictionary];
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

- (void)dictionaryForJsonString:(NSData *)data errorServer:(NSError *)serverdataError userInfo:(id)dataReceived
{
    id response_dict = dataReceived;
    
    if(response_dict == nil)
    {
        [self.delegate performSelector:self.selectorMethod withObject:response_dict];
    }
    else
    {
        [self.delegate performSelector:self.selectorMethod withObject:response_dict];
    }
}


@end
