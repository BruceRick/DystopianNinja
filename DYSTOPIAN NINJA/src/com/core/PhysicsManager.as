package com.core
{
	import com.actors.Entity;
	import com.actors.Flyer;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class PhysicsManager extends MovieClip
	{		
		public var EntityUpdatePhysicsList:Array = [];		
		public var currentLevel:MovieClip;	
		
		
		
		public function PhysicsManager( Level:MovieClip )
		{
			currentLevel = Level;
			
			
			 
			super();			
		}		
		
		public function AddPhysicsTo(__pEntity:Entity): void
		{			
			EntityUpdatePhysicsList.push(__pEntity);
		}
		
		public function RemovePhysicsFrom(__pEntity:Entity): void
		{
			for( var i:Number = 0; i < EntityUpdatePhysicsList.length; i++)
			{
				if(__pEntity == EntityUpdatePhysicsList[i])
				{
					EntityUpdatePhysicsList.splice(i);					
				}
				else if( i == EntityUpdatePhysicsList.length - 1)
				{					
					trace(__pEntity + " NOT IN ARRAY");					
				}				
			}
		}
		
		public function UpdatePhysics(__elapsedTime:Number):void
		{			
			for( var i:Number = 0; i < EntityUpdatePhysicsList.length; i++)
			{			
				 var __entity:Entity = EntityUpdatePhysicsList[i];
				 
				
				 var previousPosition:Vector3D = new Vector3D( __entity.x, __entity.y, 0 , 0 );
				 
				 // var velocityX:Number = __entity.velocityX;
				 //var velocityY:Number = __entity.velocityY;				
				
				 var velocityIncrease:Number = 0;
				 
				
				 
				 
				velocityIncrease = __entity.movement * __entity.MoveAcceleration * __elapsedTime;
				
				if(isNaN(velocityIncrease))
				{
					trace("INCREASE IS NAN");
					velocityIncrease = 0;
				}
				 
				 
				//trace(velocityIncrease);
				//trace(__entity.velocityX , " = x/ y = ", __entity.y);
				
				//trace(__elapsedTime);
				 
				 
				 
				
				__entity.velocityX += velocityIncrease;
					
					
				
				
				 //trace("VELOCITY AFTER MATH", __entity.velocityX);
				 
				 
				//trace(__entity.velocityX);
				//__entity.velocityX = velocityIncrease;
				
				
				
				//trace(__entity.velocityX);
				
				__entity.velocityY = clamp(__entity.velocityY + __entity.GravityAcceleration * __elapsedTime, -__entity.MaxFallSpeed, __entity.MaxFallSpeed);		 
				
				
				
				
				
				__entity.velocityY = Jump(__entity, __entity.velocityY, __elapsedTime);
				
				
				
				
				//trace("velocity x = " + __entity.velocityX);
				
				
				 if (__entity.isOnGround)
					 __entity.velocityX *= __entity.GroundDragFactor;
				 else
					 __entity.velocityX *= __entity.AirDragFactor;
					 
				 __entity.velocityX = clamp(__entity.velocityX, - __entity.MaxMoveSpeed, __entity.MaxMoveSpeed);
				 
				 if(__entity.velocityX < 0.05 && __entity.velocityX > -0.05)
				 {
				 	__entity.velocityX = 0;
				 }
				 
				
				__entity.x += __entity.velocityX * __elapsedTime;
				__entity.y += __entity.velocityY * __elapsedTime;
				
				
				
				
				//trace("PREVIOUS POSITION " , previousPosition.y)
				//trace("ENTITY Y " ,__entity.y);
				
				
				
				
				
				//__entity.y = clamp(__entity.y,0,stage.stageHeight - __entity.height - 124);
				__entity.x = clamp(__entity.x, __entity.constWidth/2, stage.stageWidth - __entity.constWidth/2);
				
				__entity.movement = 0;
				
				
								
				__entity.isJumping = false;		
				__entity.isOnGround = false;
				
				//trace("ENTITY: " + __entity.y);
				for( var levelChild:Number = 0; levelChild < currentLevel.numChildren; levelChild++)
				{
					
					
					var block:DisplayObject = currentLevel.getChildAt(levelChild);
					
					
					
					
					if(__entity.hitTestObject(block))
					{
						
						
						
						
						
						
						
						
						
						if(__entity.previousPositionY + __entity.constHeight <= block.y)
						{
							
							
							
							
								__entity.isOnGround = true;
								
								var depthY:Number = (__entity.y +  __entity.constHeight) - block.y;
								
								
								
								
								
								
								
								__entity.y -=  depthY;
						
							
						}
						
						
						
						
						
					}
					
					
					
					
					
				}
				
				
				
				
				
				
				
				
				if( __entity.x == previousPosition.x)
					__entity.velocityX = 0;
				
				
				//trace("PREVIOUS POSITION " , previousPosition.y)
				//trace("ENTITY Y " ,__entity.y);
				
				
				
				if( __entity.y == previousPosition.y)
				{
					
					__entity.velocityY = 0;	
				}
				
				
				
			}			
		}
		
		public function Jump(__entity:Entity, velocityY:Number, elapsedTime:Number):Number
		{
			if(__entity.isJumping)
			{				
				if((!__entity.wasJumping && __entity.isOnGround) || __entity.JumpTime > 0.0)
				{					
					__entity.JumpTime += elapsedTime;						
				}
				
				if(0.0 < __entity.JumpTime && __entity.JumpTime <= __entity.MaxJumpTime)
				{
					velocityY = __entity.JumpLaunchVelocity * (1.0 - Math.pow(__entity.JumpTime/__entity.MaxJumpTime,__entity.JumpControlPower));
				}
				else
				{
					__entity.JumpTime = 0.0;
				}				
			}
			else
			{
				__entity.JumpTime = 0.0;				
			}
			
			__entity.wasJumping = __entity.isJumping;
			return velocityY;
		}
				
		public function clamp(val:Number, min:Number, max:Number):Number
		{			
			return Math.max(min, Math.min(max, val))
		}		
	}
}