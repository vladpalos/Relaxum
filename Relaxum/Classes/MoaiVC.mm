//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc. 
// All Rights Reserved. 
// http://getmoai.com
//----------------------------------------------------------------//

#import <aku/AKU.h>
#import <aku/AKU-iphone.h> // NenadK
#import "MoaiVC.h"
#import "MoaiView.h"

//================================================================//
// MoaiVC ()
//================================================================//
@interface MoaiVC ()

	//----------------------------------------------------------------//	
	-( void ) updateOrientation :( UIInterfaceOrientation )orientation;

@end

//================================================================//
// MoaiVC
//================================================================//
@implementation MoaiVC

	//----------------------------------------------------------------//
	-( void ) willRotateToInterfaceOrientation :( UIInterfaceOrientation )toInterfaceOrientation duration:( NSTimeInterval )duration {
		
		[ self updateOrientation:toInterfaceOrientation ];
	}

	//----------------------------------------------------------------//
	- ( id ) init {
	
		self = [ super init ];
		if ( self ) {
		
		}
		return self;
	}

	//----------------------------------------------------------------//
    // Beware! Below method is depreciated in iOS6!
	- ( BOOL ) shouldAutorotateToInterfaceOrientation :( UIInterfaceOrientation )interfaceOrientation {
		
        // Conditional landscape code.
        // Add -DIS_LANDSCAPE in Project Build Settings > Other Linker Flags
#ifdef IS_LANDSCAPE
        return (( interfaceOrientation == UIInterfaceOrientationPortrait ) || ( interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ));
#else
        return (( intefaceOrientation == UIInterfaceOrientationLandscapeLeft ) || ( intefaceOrientation == UIInterfaceOrientationLandscapeRight ));
#endif

    }

	//----------------------------------------------------------------//
    -( void ) updateOrientation :( UIInterfaceOrientation )orientation {
        
    }

@end