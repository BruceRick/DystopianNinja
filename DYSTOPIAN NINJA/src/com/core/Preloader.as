package com.core
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	public class Preloader extends MovieClip
	{
		private static var __loadedFiles:Dictionary;		
		
		//loader for loading assets
		private var __loader:Loader;
		
		//file to load; Array of files
		private var __filesToLoad:Array = ["MainMenu.swf", "Game.swf"];		
		private var __filesLoaded:uint = 0;
		private var __totalFiles:uint;
		
		private var __currentFile:String;
		
		private var __prevBytes:uint = 0;
		private var __bytesLoaded:uint = 0;
		
		public var _MainMenu:MainMenu;
		
		////
		//visual representation
		//replace with your content
		
		////
		
		public function Preloader()
		{
			trace("Preloader Constructor");
			
			super();
			
			initialize();
		}
		
		private function initialize():void
		{
			trace("Preloader Initialize()");
			//initialize loader
			__loader = new Loader();
			__loadedFiles = new Dictionary();
			
			__totalFiles = __filesToLoad.length;
			
			//add event listeners to listen for 
			//complete and progress events are dispatched
			__loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);			//Called when asset is complete
			__loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);	//Called during progress of load
			__loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);		//Called when file isnt found
			
			loadFiles();
		}
		
		//this function gets the next file in the array to load
		private function loadFiles():void
		{
			//check to make sure there are files in the array before loading them
			if(__filesToLoad.length > 0)
			{
				//load next file in array of files (first element in array)
				__currentFile = __filesToLoad[0];
				
				//call load() on loader with next file in array
				__loader.load( new URLRequest(__currentFile) );
				
				//remove file from array using array.splice()
				//first parameter is the index of the element to remove (first element)
				//second parameter is the number of elements to remove (remove only one)
				__filesToLoad.splice(0, 1);
			}
			else
			{
				//if there are no files left in the array, loading is done!
				finishLoad();
			}
		}
		
		//loading is finished
		private function finishLoad():void
		{
			trace("finishLoad()");
			//remove event listeners from the loader (loader is no longer loading assets)
			__loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			__loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			
			for each(var k:* in __loadedFiles)
			{
				trace(k);
			}
			
			//percent_txt.text = "Complete. ";
			
			
			_MainMenu = new MainMenu();
			stage.addChild(_MainMenu);
			_MainMenu.Initialize();
			stage.removeChild(this);
			
		}
		
		//returns a file that has been loaded
		public static function getFile(_name:String):*
		{
			return __loadedFiles[_name];
		}
		
		private function onLoadProgress(_event:ProgressEvent):void
		{
			//current progress of asset being loaded
			
			//calculate percentage of current asset being loaded
			//var percentage:Number = (_event.bytesLoaded / _event.bytesTotal) / __totalFiles;
			//offset percentage based on number of files to load
			//percentage += (1/__totalFiles) * __filesLoaded;
			
			//__bytesLoaded += _event.bytesLoaded - __prevBytes;
			//__prevBytes = _event.bytesLoaded;
			
			//trace("Asset is loading...", percentage);
			//showProgress(percentage);
		}
		
		private function onLoadComplete(_event:Event):void
		{
			//loader has loaded an asset!
			trace("Asset loaded! onLoadComplete()");
			
			__loadedFiles[__currentFile] = __loader.content;
			
			//increase the number of files loaded
			__filesLoaded++;
			__prevBytes = 0;
			
			//asset has finished loading, load next asset in array
			loadFiles();
		}
		
		private function onLoadError(event:IOErrorEvent):void
		{
			//flash failed to find file
			trace("failed to load!", event);
		}
		
		//This function displays download progress.
		//replace with your own content
		private function showProgress(_percent:Number):void
		{
			//set text field to display percentage
			//percent_txt.text = Math.round(_percent * 100) + "%";
			//position textfield on screen based on percentage
			
			//var min:Number = 0;
			//var max:Number = stage.stageHeight - percent_txt.height;
			//percent_txt.y = (1 - _percent) * (max - min) + min;
			//move and stretch bar bsed on percentage
			//bar_mc.height = _percent * stage.stageHeight;
			//bar_mc.y = stage.stageHeight - bar_mc.height;
		}
	}
}