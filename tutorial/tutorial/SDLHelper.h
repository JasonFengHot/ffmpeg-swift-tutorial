//
//  SDL.h
//  tutorial
//
//  Created by jayios on 2016. 8. 9..
//  Copyright © 2016년 gretech. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isSDLError(int err);

@interface SDLHelper : NSObject

- (BOOL)SDL_init:(UInt32)flags;

@end
