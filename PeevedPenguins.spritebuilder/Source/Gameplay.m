//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by apple on 7/10/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
    CCNode *_levelNode;
}

//this is automatically called when CCB completes loading
-(void)didLoadFromCCB{
    
    //enable touch
    self.userInteractionEnabled = YES;
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
}

//automatically called when touch happens
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
    //launch without directions
    [self launchPenguin];
}

-(void)launchPenguin{
    // load the penguin
    CCNode *penguin = [CCBReader load:@"Penguin"];
    
    //move its position to the catapult
    penguin.position = ccpAdd(_catapultArm.position, ccp(_catapultArm.contentSize.width*.7,_catapultArm.contentSize.height*.7));
    
    // give the penguin physics
    [_physicsNode addChild:penguin];
    
    //apply a force to it using the built-in physics
    CGPoint launchDirection = ccp(1,0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    
    //make the scene follow the penguin using CCAction
    //reposition the scene before we start following
    self.position = ccp(0,0);
    
    CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [self runAction:follow];
}

-(void)retry{
    
    //use CCDirector to reload the whole scene
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Gameplay"]];
}

@end
