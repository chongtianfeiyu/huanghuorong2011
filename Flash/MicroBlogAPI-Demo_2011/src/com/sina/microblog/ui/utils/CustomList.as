package com.sina.microblog.ui.utils
{
	import com.sina.microblog.core.MainController;
	
	import flash.display.DisplayObject;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.VBox;
	import mx.core.IFactory;
	import mx.events.CollectionEvent;

	public class CustomList extends Canvas
	{
		private var _dataProvider:ArrayCollection;
		private var _controller:MainController;	
		private var _itemRenderer:IFactory
		private var ifNeedUpdate:Boolean = false;
		
		private var container:VBox;
		
		public function CustomList()
		{
			super();
			verticalScrollPolicy = "on";
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			container = new VBox();
			container.setStyle("verticalGap", 10);
			container.percentWidth = 100;
			addChild(container);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(ifNeedUpdate)
			{
				update();
			}
		}
		
		public function set controller(value:MainController):void
		{
			_controller = value;
			if(!_controller)
			{
				return;
			}
			BindingUtils.bindProperty(this, "dataProvider", _controller.mainData, "mainList");
		}
		
		public function set itemRenderer(value:IFactory):void
		{
			_itemRenderer = value;
		}
		
		public function set dataProvider(value:ArrayCollection):void
		{
			if(_dataProvider)
			{
				_dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionChange);
			}
			_dataProvider = value;
			if(_dataProvider)
			{
				_dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionChange);
			}
			
			needUpdate();
		}
		
		private function onCollectionChange(event:CollectionEvent):void
		{
			needUpdate();
		}
		
		private function needUpdate():void
		{
			ifNeedUpdate = true;
			invalidateProperties();
		}
		
		private function update():void
		{
			if(!container)
			{
				return;
			}
			container.removeAllChildren();
			for each(var data:Object in _dataProvider)
			{
				var obj:Object = _itemRenderer.newInstance();
				obj.controller = _controller;
				obj.data = data;
				container.addChild(obj as DisplayObject);
			}
		}
	}
}