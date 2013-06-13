package com.actors
{
	import flash.display.MovieClip;
	import flash.geom.Vector3D;
	
	public class Entity extends MovieClip
	{		
		public var Type:String;
		
		public var isAlive:Boolean;
		public var isOnGround:Boolean;
		public var velocityX:Number;
		public var velocityY:Number;
		
		//JumpingControl
		public var isJumping:Boolean;
		public var wasJumping:Boolean;
		public var JumpTime:Number;
		
		//Horizontal Movement Control
		public var MoveAcceleration:Number;
		public var MaxMoveSpeed:Number;
		public var GroundDragFactor:Number;
		public var AirDragFactor:Number;
		
		//Vertical Movement Control
		public var MaxJumpTime:Number;
		public var JumpLaunchVelocity:Number;
		public var GravityAcceleration:Number;
		public var MaxFallSpeed:Number;
		public var JumpControlPower:Number;
		
		public var movement:Number;
		public var constHeight:Number;
		public var constWidth:Number;	
		
		public var previousPositionX:Number;
		public var previousPositionY:Number;
		
		public function Entity()
		{			
			super();
		}
	}
}