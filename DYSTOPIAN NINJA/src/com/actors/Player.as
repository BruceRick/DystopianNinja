package com.actors
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;	
	
	public class Player extends Entity
	{		
		private var __keyUp:Boolean = false;
		private var __keyDown:Boolean = false;
		private var __keyLeft:Boolean = false;
		private var __keyRight:Boolean = false;
		private var __previousKey:Boolean = false;
		
		private var __keyCodeArray:Array = [];
		
		public var __Movement:Number;
		public var scale:Number	
		
		public var isAttacking:Boolean = false;
		public var AttackAnimation:MovieClip;
		
		public function Player()
		{
			super();
		}		
		
		public function initialize(_up:int, _down:int, _left:int, _right:int):void
		{			
			this.Type = "Player";
			
			__keyCodeArray = [_up, _down, _left, _right];
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			this.scaleX *= 1.3;
			this.scaleY *= 1.3;
			scale = this.scaleX;
			
			this.x = stage.stageWidth/2;
			this.y = 100;
			
			isAlive = true;
			isOnGround = true;			
			
			//JumpingControl
			isJumping = false;			
			
			//Horizontal Movement Control
			MoveAcceleration = 15000.0;
			MaxMoveSpeed = 40000.0;
			GroundDragFactor = 0.5;
			AirDragFactor = 0.6;
			
			//Vertical Movement Control
			MaxJumpTime = 0.25;
			JumpLaunchVelocity = -7500.0;
			GravityAcceleration = 37000.0;
			MaxFallSpeed =  1000.0;
			JumpControlPower = 0.14;
			
			this.velocityX = 0;
			this.velocityY = 0;
			
			constHeight = this.height;
			constWidth = this.width;	
			
			previousPositionX = 0;
			previousPositionY = 0;
			
			__Movement = 2.5;
			
			
			
		}
		
		public function update():void
		{			
			
			if(isAlive)
			{
			
			
			
				if(__keyLeft == true && !isAttacking)
				{				
					this.movement = -__Movement;
					this.play();
					this.scaleX = scale;
					if(!isJumping && !isAttacking)
					{
						
						this.gotoAndStop(2);
					}
					
				}
				else if(__keyRight == true && !isAttacking)
				{
					this.movement = __Movement;
					this.play();
					this.scaleX = -scale;
					if(!isJumping && !isAttacking)
					{
						
						this.gotoAndStop(2);
					}
					
				}
				else if(!isJumping && !isAttacking)
				{
					
					this.gotoAndStop(1);
				}
	
				
				if(__keyUp == true )
				{
					
					this.isJumping = true;
				
					
				}
				else 
				{
					this.isJumping = false;
				}
				
				
				//trace(this.velocityX + " - x / y - " + this.velocityY);
			
				
				if(velocityY > 0)
				{
					if(!isAttacking)
					{
						
						this.gotoAndStop(4);
					}
				}
				else if(!this.isOnGround && this.isJumping)
				{
					if(!isAttacking)
					{
						
						this.gotoAndStop(3);
					}
				}
				
				if(__keyDown == true && !__previousKey && !isAttacking )
				{
					__previousKey = true;
					//AttackAnimation = getChildAt(0);
					
					gotoAndStop(5);
					isAttacking = true;
					
					
					
						
				}
				
				
				
				__previousKey = __keyDown;
			}
			
			
			
			
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{	
			keySwitch(event.keyCode, false);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			keySwitch(event.keyCode, true);
		}		
				
		private function keySwitch(_key:int, _press:Boolean):void
		{
			switch(_key)
			{
				case __keyCodeArray[0]: //up key
					__keyUp = _press;
					break;
				case __keyCodeArray[1]: //down key
					__keyDown = _press;
					break;
				case __keyCodeArray[2]: //left key
					__keyLeft = _press;
					break;
				case __keyCodeArray[3]: //right
					__keyRight = _press;
					break;
			}
		}	
		
		private function Attack():void
		{
			
			
		}
		
		
	}
}