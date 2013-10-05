//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc. 
// All Rights Reserved. 
// http://getmoai.com
//----------------------------------------------------------------//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

//extern "C" {
//	#include <lua.h>
//	#include <lauxlib.h>
//	#include <lualib.h>
//}

#import <aku/AKU-iphone.h>
#import <aku/AKU-luaext.h>
#import <aku/AKU-audiosampler.h>
#import <lua-headers/moai_lua.h>

// Conditional use of UNTZ sound system.
// If you want to use UNTZ sound,
//  add "-DUSE_UNTZ" to Project > Build Settings > Other C Flags
#ifdef USE_UNTZ
#import <aku/AKU-untz.h>
#endif

#ifdef USE_LOCATION
#import "LocationObserver.h"
#endif

#import "MoaiView.h"
#import "ParticlePresets.h"

#define DEGREES_PER_RADIAN (180.0/3.14159265)

namespace MoaiInputDeviceID {
	enum {
		DEVICE,
		TOTAL,
	};
}

namespace MoaiInputDeviceSensorID {
	enum {
		COMPASS,
		LEVEL,
		LOCATION,
		TOUCH,
		TOTAL,
	};
}

//================================================================//
// MoaiView ()
//================================================================//
@interface MoaiView ()

	//----------------------------------------------------------------//
	-( void )	drawView;
	-( void )	handleTouches		:( NSSet* )touches :( BOOL )down;
	-( void )	onUpdateAnim;
#ifdef USE_LOCATION
	-( void )	onUpdateHeading		:( LocationObserver* )observer;
	-( void )	onUpdateLocation	:( LocationObserver* )observer;
#endif
	-( void )	startAnimation;
	-( void )	stopAnimation;
    -( void )   dummyFunc;

@end

//================================================================//
// MoaiView
//================================================================//
@implementation MoaiView
    SYNTHESIZE	( GLint, width, Width );
    SYNTHESIZE	( GLint, height, Height );

#ifndef USE_GYRO
	//----------------------------------------------------------------//
	-( void ) accelerometer:( UIAccelerometer* )acel didAccelerate:( UIAcceleration* )acceleration {
		( void )acel;


		AKUEnqueueLevelEvent (
			MoaiInputDeviceID::DEVICE,
			MoaiInputDeviceSensorID::LEVEL,
			( float )acceleration.x,
			( float )acceleration.y,
			( float )acceleration.z
		);

	}
#endif

    //----------------------------------------------------------------//
    -( AKUContextID ) akuInitialized {

        return mAku;
    }

	//----------------------------------------------------------------//
	-( void ) dealloc {
	
		AKUDeleteContext ( mContext );
		
		[ super dealloc ];
	}

	//----------------------------------------------------------------//
	-( void ) drawView {
		
		[ self beginDrawing ];
		
		AKUSetContext ( mAku );
		AKURender ();

		[ self endDrawing ];
	}
	
    //----------------------------------------------------------------//
    -( void ) dummyFunc {
        //dummy to fix weird input bug
    }

	//----------------------------------------------------------------//
	-( void ) handleTouches :( NSSet* )touches :( BOOL )down {
	
		for ( UITouch* touch in touches ) {
			
			CGPoint p = [ touch locationInView:self ];
			
			AKUEnqueueTouchEvent (
				MoaiInputDeviceID::DEVICE,
				MoaiInputDeviceSensorID::TOUCH,
				( int )touch, // use the address of the touch as a unique id
				down,
				p.x * [[ UIScreen mainScreen ] scale ],
				p.y * [[ UIScreen mainScreen ] scale ]
			);
		}
	}
	
	//----------------------------------------------------------------//
	-( id )init {
		
        mAku = 0;
		self = [ super init ];
		if ( self ) {
		}
		return self;
	}

	//----------------------------------------------------------------//
	-( id ) initWithCoder:( NSCoder* )encoder {

        mAku = 0;
		self = [ super initWithCoder:encoder ];
		if ( self ) {
		}
		return self;
	}
	
	//----------------------------------------------------------------//
	-( id ) initWithFrame :( CGRect )frame {

        mAku = 0;
		self = [ super initWithFrame:frame ];
		if ( self ) {
		}
		return self;
	}
	
	//----------------------------------------------------------------//
	-( void ) moaiInit :( UIApplication* )application {
	
		mAku = AKUCreateContext ();
		AKUSetUserdata ( self );
		
		AKUExtLoadLuasql ();
		AKUExtLoadLuacurl ();
		AKUExtLoadLuacrypto ();
		AKUExtLoadLuasocket ();
		
		#ifdef USE_UNTZ
			AKUUntzInit ();
		#endif
        
		#ifdef USE_FMOD_EX
			AKUFmodExInit ();
		#endif
        
		AKUAudioSamplerInit ();
        
		AKUSetInputConfigurationName ( "iPhone" );

		AKUReserveInputDevices			( MoaiInputDeviceID::TOTAL );
		AKUSetInputDevice				( MoaiInputDeviceID::DEVICE, "device" );
		
		AKUReserveInputDeviceSensors	( MoaiInputDeviceID::DEVICE, MoaiInputDeviceSensorID::TOTAL );
		AKUSetInputDeviceCompass		( MoaiInputDeviceID::DEVICE, MoaiInputDeviceSensorID::COMPASS,		"compass" );
		AKUSetInputDeviceLevel			( MoaiInputDeviceID::DEVICE, MoaiInputDeviceSensorID::LEVEL,		"level" );
		AKUSetInputDeviceLocation		( MoaiInputDeviceID::DEVICE, MoaiInputDeviceSensorID::LOCATION,		"location" );
		AKUSetInputDeviceTouch			( MoaiInputDeviceID::DEVICE, MoaiInputDeviceSensorID::TOUCH,		"touch" );
		
		CGRect screenRect = [[ UIScreen mainScreen ] bounds ];
		CGFloat scale = [[ UIScreen mainScreen ] scale ];
		CGFloat screenWidth = screenRect.size.width * scale;
		CGFloat screenHeight = screenRect.size.height * scale;
		
		AKUSetScreenSize ( screenWidth, screenHeight );
		AKUSetViewSize ( mWidth, mHeight );
		
		AKUSetFrameBuffer ( mFramebuffer );         //NenadK, there was a call to a missing function here
		AKUDetectGfxContext ();
		
		mAnimInterval = 1; // 1 for 60fps, 2 for 30fps
#ifdef USE_LOCATION
		mLocationObserver = [[[ LocationObserver alloc ] init ] autorelease ];
		
		[ mLocationObserver setHeadingDelegate:self :@selector ( onUpdateHeading: )];
		[ mLocationObserver setLocationDelegate:self :@selector ( onUpdateLocation: )];
#endif
        
        
#ifdef USE_GYRO
        // Set up gyroscope via Core Motion framework
        motionManager = [[CMMotionManager alloc] init];
        
        if([ motionManager isGyroAvailable])
        {
            motionManager.deviceMotionUpdateInterval = mAnimInterval / 60.0 ;
            [ self startGyroscope ];
            NSLog(@"Gyroscope linked to level event successfully.");
        }
        else
        {
            NSLog(@"Gyroscope not available at this device!");
        }
#else
        // Set up accelerometer via Core Motion framework        
        UIAccelerometer* accel = [ UIAccelerometer sharedAccelerometer ];
		accel.delegate = self;
		accel.updateInterval = mAnimInterval / 60.0 ;
#endif
        
		// init aku
		AKUIphoneInit ( application );
        
        // Run Lua!
		AKURunBytecode ( moai_lua, moai_lua_SIZE );
		
		// add in the particle presets
		ParticlePresets ();
	}
	
	//----------------------------------------------------------------//
	-( void ) onUpdateAnim {
        
#ifdef USE_GYRO
        //  Important note about gyroscope support in this version of the host:
        //  It's a quick fix to let you read gyro data *instead of* accelerometer,
        //  in a case that you, for different reasons, don't want to touch Moai source code
        //  and compile libmoai yourself.
        //  This host will let you read gyroscope roll, pitch, and yaw
        //  instead of accelerometer's gravity.x, .y and .z
        if ( mShouldUpdateGyro&&(motionManager!=nil)&&([motionManager isDeviceMotionActive])) {
            CMAttitude *currentAttitude = motionManager.deviceMotion.attitude;
            AKUEnqueueLevelEvent (
                                  MoaiInputDeviceID::DEVICE,
                                  MoaiInputDeviceSensorID::LEVEL,
                                  ( float )currentAttitude.roll * DEGREES_PER_RADIAN,
                                  ( float )currentAttitude.pitch * DEGREES_PER_RADIAN,
                                  ( float )currentAttitude.yaw * DEGREES_PER_RADIAN
                                  );
        }
#endif
        
		[ self openContext ];
		AKUSetContext ( mAku );
		AKUUpdate ();
		[ self drawView ];
        
        //sometimes the input handler will get 'locked out' by the render, this will allow it to run
        [ self performSelector: @selector(dummyFunc) withObject:self afterDelay: 0 ];
	}


#ifdef USE_LOCATION
	//----------------------------------------------------------------//
	-( void ) onUpdateHeading :( LocationObserver* )observer {
	
		AKUEnqueueCompassEvent (
			MoaiInputDeviceID::DEVICE,
			MoaiInputDeviceSensorID::COMPASS,
			( float )[ observer heading ]
		);
	}
	
	//----------------------------------------------------------------//
	-( void ) onUpdateLocation :( LocationObserver* )observer {
	
		AKUEnqueueLocationEvent (
			MoaiInputDeviceID::DEVICE,
			MoaiInputDeviceSensorID::LOCATION,
			[ observer longitude ],
			[ observer latitude ],
			[ observer altitude ],
			( float )[ observer hAccuracy ],
			( float )[ observer vAccuracy ],
			( float )[ observer speed ]
		);
	}
#endif

	//----------------------------------------------------------------//
	-( void ) pause :( BOOL )paused {
	
		if ( paused ) {
			AKUPause ( YES );
			[ self stopAnimation ];
		}
		else {
			[ self startAnimation ];
			AKUPause ( NO );
		}
	}
	
	//----------------------------------------------------------------//
	-( void ) run :( NSString* )filename {
		AKUSetContext ( mAku );
		AKURunScript ([ filename UTF8String ]);
	}


	//----------------------------------------------------------------//
	-( void ) startAnimation {

#ifdef USE_GYRO
        [self startGyroscope];
#endif
		if ( !mDisplayLink ) {
			CADisplayLink* aDisplayLink = [[ UIScreen mainScreen ] displayLinkWithTarget:self selector:@selector( onUpdateAnim )];
			[ aDisplayLink setFrameInterval:mAnimInterval ];
			[ aDisplayLink addToRunLoop:[ NSRunLoop currentRunLoop ] forMode:NSDefaultRunLoopMode ];
			mDisplayLink = aDisplayLink;
		}
	}


	//----------------------------------------------------------------//
	-( void ) stopAnimation {
#ifdef USE_GYRO
        [self stopGyroscope];
#endif
        [ mDisplayLink invalidate ];
        mDisplayLink = nil;
	}

#ifdef USE_GYRO
    //----------------------------------------------------------------//
    // NenadK
    -( void ) startGyroscope {
        if (motionManager && motionManager.isGyroAvailable && motionManager.isDeviceMotionAvailable) {
            mShouldUpdateGyro = true;
            [motionManager startDeviceMotionUpdates];
        }
    }

    //----------------------------------------------------------------//
    // NenadK
    -( void ) stopGyroscope {
        if (motionManager && motionManager.isGyroAvailable && motionManager.isDeviceMotionAvailable) {
            mShouldUpdateGyro = false;
            [motionManager stopDeviceMotionUpdates];
        }
    }
#endif
	//----------------------------------------------------------------//
	-( void )touchesBegan:( NSSet* )touches withEvent:( UIEvent* )event {
		( void )event;
		
		[ self handleTouches :touches :YES ];
	}
	
	//----------------------------------------------------------------//
	-( void )touchesCancelled:( NSSet* )touches withEvent:( UIEvent* )event {
		( void )touches;
		( void )event;
		
		AKUEnqueueTouchEventCancel ( MoaiInputDeviceID::DEVICE, MoaiInputDeviceSensorID::TOUCH );
	}
	
	//----------------------------------------------------------------//
	-( void )touchesEnded:( NSSet* )touches withEvent:( UIEvent* )event {
		( void )event;
		
		[ self handleTouches :touches :NO ];
	}

	//----------------------------------------------------------------//
	-( void )touchesMoved:( NSSet* )touches withEvent:( UIEvent* )event {
		( void )event;
		
		[ self handleTouches :touches :YES ];
	}
	
@end