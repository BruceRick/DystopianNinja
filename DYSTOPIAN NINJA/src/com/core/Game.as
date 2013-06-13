package com.core
{
	import com.actors.Boss;
	import com.actors.Flyer;
	import com.actors.Player;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	import flash.geom.Orientation3D;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	public class Game extends MovieClip
	{		
		private var player:Player;
		//private var flyer:Flyer;
		private var previousTime:Number;
		private var physicsManager:PhysicsManager;
		public var mc_Level:MovieClip;
		private var BackgroundMusic:Sound;
		private var __SoundChannel:SoundChannel;
		private var __OriginalPosition:Vector3D = new Vector3D();
		private var DeathTime:Number = 3000;
		private var timeToRespawn:Number = 0;
		public var __BossTrigger:MovieClip;
		private var BossFight:Boolean = false;
		private var __Boss:Boss;
		private var __Respawn:Boolean = false;;
		
		
		public function Game()
		{
			super();			
		}
		
		public function Initialize():void
		{
			trace("INITIALIZE");
			
			BackgroundMusic = new Sound();
			BackgroundMusic.load(new URLRequest("BackgroundMusic.mp3"));
			__SoundChannel = new SoundChannel();
			__SoundChannel = BackgroundMusic.play(0,0);
			
			
			trace(BackgroundMusic.length);
			
			player = new Player();
			//flyer = new Flyer();
			
			physicsManager = new PhysicsManager(mc_Level);
			
			stage.addChild(player);
			//addChild(flyer);
			stage.addChild(physicsManager);
			
			player.initialize(Keyboard.W, Keyboard.SPACE, Keyboard.A,Keyboard.D);
			addEventListener(Event.ENTER_FRAME, update);
			
			//flyer.initialize(stage.width/2, stage.height/2);
			
			physicsManager.AddPhysicsTo(player);	
			
			previousTime = getTimer();
			
			__OriginalPosition.x = mc_Level.getChildAt(0).x;
			__OriginalPosition.y = mc_Level.getChildAt(0).y;
			
			
			mc_Level.addChild(__BossTrigger);
			__Boss = new Boss();
			//__BossTrigger.pa;
			
			
			
		}
		
		protected function update(event:Event):void
		{			
			
			
			trace(__SoundChannel.position);
			
			var elapsedTime:Number = getTimer();
			
			
			
			
			elapsedTime -= previousTime;
			elapsedTime /= 1000;		
			
			
			
			player.update();
			
			
			
			physicsManager.UpdatePhysics(elapsedTime);			
			
			
			
			//trace(mc_Level);
			previousTime = getTimer();
			
			var MoveLevelX:Number = 0;
			MoveLevelX = (player.x) - stage.stageWidth/2;
			var MoveLevelY:Number = 0;
			MoveLevelY = (player.y) - stage.stageHeight/2 ;
			
			
			
			player.previousPositionX = player.x;
			player.previousPositionY = player.y - MoveLevelY;
			//
			
			
			
			
			
			
			
			if(!BossFight)
			{
			
				if((__OriginalPosition.y - mc_Level.getChildAt(0).y) > 235)
				{
					
						__Respawn = true;
						Reset();
						
					
					
					
					
				}	
				else
				{
					
					//timeToRespawn = DeathTime + getTimer();
					
					
					player.x = stage.stageWidth/2;
					player.y = stage.stageHeight/2;
					
					for( var levelChild:Number = 0; levelChild < mc_Level.numChildren; levelChild++)
					{
							
						mc_Level.getChildAt(levelChild).x -= MoveLevelX;
						mc_Level.getChildAt(levelChild).y -= MoveLevelY;
						
					}
				}
			}
			
			
			if(player.hitTestObject(__BossTrigger) && !BossFight)
			{
				BossFight = true;
				
				
				stage.addChild(__Boss);
				__Boss.Initialize(player);
				__Boss.x = 0;
				__Boss.y = 0;
				physicsManager.AddPhysicsTo(__Boss);	
				
				
				trace("BOSS FIGHT");
			}
			
			if(__Boss != null)
			{
				if(!__Boss.isAlive)
				{
					__Respawn = true;
					physicsManager.RemovePhysicsFrom(__Boss);
					__Boss = null;
					timeToRespawn = DeathTime*2 + getTimer();
			
				}
			}
			else
			{
				
				if(timeToRespawn < getTimer())
				{
					
					for(var i:Number; i < stage.numChildren; i++)
					{
						stage.removeChildren(0,stage.numChildren);
						//stage.removeChildAt(stage.getChildAt(i));
						
						
					}
					
					
					
					var __MainMenu:MainMenu = new MainMenu();
					stage.addChild(__MainMenu);
					__MainMenu.Initialize();
					
					removeEventListener(Event.ENTER_FRAME, update);
					stage.removeChild(this);
					
					
					
					
					
				}
				
				
			}
			
			
			if(!player.isAlive)
			{
				__Respawn = true;
				if(timeToRespawn < getTimer())
				{
					
					for(var i:Number; i < stage.numChildren; i++)
					{
						stage.removeChildren(0,stage.numChildren);
						//stage.removeChildAt(stage.getChildAt(i));
						
						
					}
					
				
					
					var __MainMenu:MainMenu = new MainMenu();
					stage.addChild(__MainMenu);
					__MainMenu.Initialize();
					
					removeEventListener(Event.ENTER_FRAME, update);
					stage.removeChild(this);
					
					
					
				
					
				}
				
				
				
			
			}
			
			
			
			
			if(!__Respawn)
			{
				timeToRespawn = DeathTime + getTimer();
			}
			
			
		}
		
		public function Reset():void
		{
			if(timeToRespawn < getTimer())
			{
				
				__Respawn = false;
				player.isAlive = true;
			
				var MoveLevelX:Number = __OriginalPosition.x - mc_Level.getChildAt(0).x;
				
				var MoveLevelY:Number = __OriginalPosition.y - mc_Level.getChildAt(0).y;
				
				player.x = stage.stageWidth/2;
				player.y = stage.stageHeight/2;
				
				for( var levelChild:Number = 0; levelChild < mc_Level.numChildren; levelChild++)
				{
					
					mc_Level.getChildAt(levelChild).x += MoveLevelX;
					mc_Level.getChildAt(levelChild).y += MoveLevelY;
					
				}
			
			}
			
		}
		
		
		
	}
	
	
	
	
	
}