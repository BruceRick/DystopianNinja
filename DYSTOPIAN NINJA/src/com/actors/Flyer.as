package com.actors
{
	import com.core.Game;
	import com.core.Preloader;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Flyer extends Entity
	{
		// Moving left or right
		public var isMovingLeft:Boolean;
		// Rising or falling
		public var isFalling:Boolean;
		public var timeToMove:Number;
		public  var currentMovementTime:Number;
		
		public var timeToFall:Number;
		public var currentFallingTime:Number;
		
		public var distanceToFall:Number;
		public var distanceToMove:Number;
		public var deltaDistanceToFall:Number;
		public var deltaDistanceToMove:Number;
		
		public var _Game:Game;
		
		public function Flyer()
		{
			super();
			
			this.Type = "Flyer";
			this.name = "Flyer";
			
			isAlive = true;
			isFalling = true;
			velocityX = -5;
			velocityY = 5;
			
			timeToMove = 1.5;
			currentMovementTime = 0;			
			
			timeToFall = 1.5;
			currentFallingTime = 0;
			
			distanceToFall = 50;
			distanceToMove = 50;
			
			deltaDistanceToFall = 0;
			deltaDistanceToMove = 0;
			
			
			
			trace("game: " + _Game);
			
			
			this.addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function Update(e:Event):void
		{			
			//trace("x: " + x + ", y: + " + y);
			var game:Game = parent.parent as Game;
		
			//trace("game: " + game);
			var __elapsedTime:Number = 0;
			//var __elapsedTime:Number = game.GetTime();
			//trace("Elapsed time: " + game.elapsedTime);
			//trace("Elapsed time: " + elapsedTime);
			
			if(isAlive)
			{
				
				//trace("IsFalling? " + isFalling);
				//currentMovementTime +=  0.01;
				
				if(isFalling)
				{
					currentFallingTime += __elapsedTime;
					
					// If still falling
					if( currentFallingTime < timeToFall )
					{
						this.y += velocityY;
					}
					else
					{
						currentFallingTime = 0;
						isFalling = false;
					}
				}
				else
				{
					currentMovementTime += __elapsedTime
					
					if(currentMovementTime > timeToMove)
					{
						currentMovementTime = 0;
						isMovingLeft = !isMovingLeft;
						isFalling = true;
						
					}
					else
					{
						if(isMovingLeft)
						{
							this.x -= velocityX;
							this.y -= velocityY;
						}
						else
						{
							this.x += velocityX;
							this.y -= velocityY;
						}
						//trace("currentMovementTime: " + currentMovementTime);
					}
				}								
			}
			// Is dead
			else
			{
				
			}
		}
	}
}