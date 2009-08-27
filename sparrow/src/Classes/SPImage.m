//
//  SPImage.m
//  Sparrow
//
//  Created by Daniel Sperl on 19.06.09.
//  Copyright 2009 Incognitek. All rights reserved.
//

#import "SPImage.h"
#import "SPPoint.h"
#import "SPTexture.h"
#import "SPStaticTexture.h"

@implementation SPImage

@synthesize texture = mTexture;

- (id)initWithTexture:(SPTexture*)texture;
{
    if (self = [super initWithWidth:texture.width height:texture.height])
    {
        self.texture = texture;
        mTexCoords[0] = 0.0f; mTexCoords[1] = 0.0f;
        mTexCoords[2] = 1.0f; mTexCoords[3] = 0.0f;
        mTexCoords[4] = 1.0f; mTexCoords[5] = 1.0f;
        mTexCoords[6] = 0.0f; mTexCoords[7] = 1.0f;
    }
    return self;
}

- (id)initWithContentsOfFile:(NSString*)path
{
    return [self initWithTexture:[SPStaticTexture textureWithContentsOfFile:path]];
}

- (id)initWithWidth:(float)width height:(float)height
{
    return [self initWithTexture:[SPStaticTexture textureWithData:NULL width:width height:height]];
}

- (void)setTexCoords:(SPPoint*)coords ofVertex:(int)vertexID
{
    mTexCoords[2*vertexID  ] = coords.x;
    mTexCoords[2*vertexID+1] = coords.y;
}

- (SPPoint*)texCoordsOfVertex:(int)vertexID
{
    return [SPPoint pointWithX:mTexCoords[vertexID*2] y:mTexCoords[vertexID*2+1]];
}

+ (SPImage*)imageWithTexture:(SPTexture*)texture
{
    return [[[SPImage alloc] initWithTexture:texture] autorelease];
}

+ (SPImage*)imageWithContentsOfFile:(NSString*)path
{
    return [[[SPImage alloc] initWithContentsOfFile:path] autorelease];
}

- (void)dealloc
{
    [mTexture release];
    [super dealloc];
}

@end