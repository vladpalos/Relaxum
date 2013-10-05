//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc. 
// All Rights Reserved. 
// http://getmoai.com
//----------------------------------------------------------------//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

//  Quick and dirty gyro support:
//  If you want to use gyroscope input instead of accelerometer
//  add "-DUSE_GYRO" to Project > Build Settings > Other C Flags
#ifdef USE_GYRO
#import <CoreMotion/CoreMotion.h> // Required to add gyroscope
#endif

#import <aku/AKU.h>

#import "OpenGLView.h"
#import "RefPtr.h"

//  Location services are optional now. If you want to use them,
//  add "-DUSE_LOCATION" to Project > Build Settings > Other C Flags
#ifdef USE_LOCATION
@class LocationObserver;
#endif

//================================================================//
// MoaiView
//================================================================//
@interface MoaiView : OpenGLView < UIAccelerometerDelegate > {
@private
	
	AKUContextID					mAku;
	NSTimeInterval					mAnimInterval;
    RefPtr < CADisplayLink >		mDisplayLink;
#ifdef USE_LOCATION
	RefPtr < LocationObserver >		mLocationObserver;
#endif
#ifdef USE_GYRO
    CMMotionManager *               motionManager;          // NenadK: Motion interval
#endif
    bool                            mShouldUpdateGyro;      // NenadK: Should Update Gyrpo
}

	//----------------------------------------------------------------//
    -( AKUContextID )   akuInitialized  ;
	-( void )	moaiInit            :( UIApplication* )application;
	-( void )	pause               :( BOOL )paused;
	-( void )	run                 :( NSString* )filename;

#ifdef USE_GYRO
    -( void )   startGyroscope;
    -( void )   stopGyroscope;
#endif
    PROPERTY_READONLY ( GLint, width );
    PROPERTY_READONLY ( GLint, height );

@end
