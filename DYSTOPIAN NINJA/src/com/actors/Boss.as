package com.actors
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getTimer;
	

	
	
	
	public class Boss extends Entity
	{
		
		private var __Movement:Number = -2.5;
		
	
		
		private var __WaitTime:Number = 3000;
		private var __TimetoWait:Number = 0;
		
		private var Charging:Boolean = false;
		private var Attacking:Boolean = false;
		
		private var __player:Player; 
		private var TakingDamage:Boolean = false;
		
		private var Health:Number = 100;
		
		private var CurrentMode:Number = 1;
		
		public function Boss()
		{
			
			isAlive = true;
			super();
		}
		
		public function Initialize(player:Player):void
		{
			
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
			
				
			
			previousPositionX = 0;
			previousPositionY = 0;
			
			gotoAndStop(1);
			__TimetoWait = __WaitTime + getTimer();
			
			constHeight = height;
			constWidth = width;
			
			addEventListener(Event.ENTER_FRAME, update);
			
			
			//__TimetoAttack = getTimer() + __AttackTime;
			__player = player;
			
		}
		
		protected function update(event:Event):void
		{
			
			
			// TODO Auto-generated method stub
			if(!TakingDamage)
			{
				if(!Charging && !Attacking)
				{
					
					this.movement = __Movement;
					
					if(this.x < this.width)
					{
						
						this.x = this.width + 20;
						__Movement *= -1;
					}
					
					if( this.x > stage.stageWidth  - this.width)
					{
						
						this.x = (stage.stageWidth - this.width) - 20;
						__Movement *= -1;
						
					}
				}
				
				if(getTimer() > __TimetoWait)
				{
					
					__TimetoWait = __WaitTime + getTimer();
					
					
					
					CurrentMode+= 1;
					
					
					if(CurrentMode > 3)
					{
						
						CurrentMode = 1;
					}
					
					
					
					
					gotoAndStop(CurrentMode);
					
					
					
					
					
				}
				
				
				if(currentFrame == 1)
				{
					Charging = false;
					Attacking = false;
					
				}
				else if(currentFrame == 2)
				{
					
					Charging = false;
					Attacking = true;
					
					
				}
				else
				{
					Charging = true;
					Attacking = false;
					
				}
				
				
				if(this.hitTestObject(__player))
				{
					
					
					if(__player.currentFrame == 5 && Charging)
					{
					
						
							
							
						TakingDamage = true;
							
							
						
						
						
					}
					else if(!Charging)
					{
						
						
						
						removeEventListener(Event.ENTER_FRAME, update);
						__player.isAlive = false;
						__player.gotoAndStop(6);
						
						
					}
					
					
					
					
				}
			}
			else
			{
				Attacking = true;
				Damage();
			}
			
			
			if(!isAlive)
			{
				this.y += 10;
			}
			
		}
		
		private function Damage():void
		{	
			
			trace("BOSS DAMAGED: "  + this.alpha);
			
			
			
			
				
			
			this.alpha -= 0.05;
			
			if(this.alpha <= 0)
			{
				TakingDamage = false;
				this.alpha = 1;
				this.Health -= 50;
				if(this.Health <= 0)
					this.isAlive = false;
				
			}
				
		
		}
		
	}
}