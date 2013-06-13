package com.core
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class MainMenu extends MovieClip
	{		
		public var __PlayButton:SimpleButton;
		
		
		
		
		
		
		public function MainMenu()
		{
			trace("Initialize");
			
			super();	
		}
		
		public function Initialize():void 
		{
			
			
			
			__PlayButton.addEventListener(MouseEvent.CLICK, StartGame);
			
		}		
	
		
		
		protected function StartGame(event:Event):void
		{			
			
			__PlayButton.removeEventListener(MouseEvent.CLICK, StartGame);
			
			var __Game:Game = new Game();
			
			stage.addChild(__Game);
			
			__Game.Initialize();
			stage.removeChild(this);
			
		}
		
		
	}
}