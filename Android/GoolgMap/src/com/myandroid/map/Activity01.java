package com.myandroid.map;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Point;
import android.location.Address;
import android.location.Criteria;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapActivity;
import com.google.android.maps.MapController;
import com.google.android.maps.MapView;
import com.google.android.maps.Overlay;

public class Activity01 extends MapActivity {
	private MapView mMapView;
	private MapController mMapController;
	private MyLocationOverlay myPosition;

	private final static int ZOOM_IN=Menu.FIRST;
	private final static int ZOOM_OUT=Menu.FIRST+1;
	private TextView tv;
	private String loc;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        tv=(TextView)findViewById(R.id.tv);
        
        //获得地图的定位管理器
        LocationManager locationManager=(LocationManager)getSystemService(Context.LOCATION_SERVICE);
        
        mMapView=(MapView)findViewById(R.id.MapView01);
        
        //设定地图模式：交通、卫星、街道
        mMapView.setTraffic(true);
       //mMapView.setSatellite(true);
     //   mMapView.setStreetView(true);
        
        //得到地图视图的控制器
        mMapController =mMapView.getController();
        
        //设定地图视图的相关属性
        mMapView.setEnabled(true);
        mMapView.setClickable(true);
        mMapView.displayZoomControls(false);
       // mGeoPoint=new GeoPoint((int)30.659259*1000000,(int)104.065762*1000000);
        
        //设定地图的最大的放大倍数
        mMapController.setZoom(17);
        
        //根据用户重写的overlay子类来定义一个覆盖对象
        myPosition=new MyLocationOverlay();
        
        //获得地图视图的覆盖对象集合，这个集合将被画到地图上，并会对一些事件做出响应
        List<Overlay> list=mMapView.getOverlays();
        
        //将我们自定义的覆盖对象加入到这个集合中
        list.add(myPosition);   
        
        //地图服务商（标准）的定义，用来区分各种providers       
        Criteria criteria=new Criteria();
        criteria.setAccuracy(Criteria.ACCURACY_FINE);	//精确速度
        criteria.setAltitudeRequired(false);			//海拔
        criteria.setBearingRequired(false);				//方向
        criteria.setCostAllowed(false);					//是否计费
        criteria.setPowerRequirement(Criteria.POWER_LOW);
        
        //获得最符合以上标准的provider的名称  
        String provider=locationManager.getBestProvider(criteria, true);
        
        //获得这个provider的最后的定位信息
        Location location=locationManager.getLastKnownLocation(provider);
        
        //更新定位信息
        updateWithNewLocation(location);
        
        //定位管理器请求定位更新
        locationManager.requestLocationUpdates(provider, 3000, 0, locationListener);
    }

    
    
    
    public void updateWithNewLocation(Location location)
    {
    	String latLongString;
    	//TextView tv=(TextView)findViewById(R.id.tv);
    	String  addressString="can not find the address\n";
    	if(location!=null)
    	{
    		myPosition.setLocation(location);
    		
    		// 得到定位信息的经度、纬度数据
    		Double  geoLat=location.getLatitude()*1E6;
    		Double  geoLng=location.getLongitude()*1E6;
    		
    		//把经度、纬度数据封装在一个GeoPoint对象里，就是经纬度坐标
    		GeoPoint point=new GeoPoint(geoLat.intValue(),geoLng.intValue());
    		
    		//地图定位到该经纬度坐标
    		mMapController.animateTo(point);
    		
    		//获得该点的经度和纬度信息
    		double lat=location.getLatitude();
    		double lng=location.getLongitude();
    		latLongString="jingdu："+lat+"  weidu"+lng;
    		
    		double latitude=location.getLatitude();
    		double longitude=location.getLongitude();
    		
    		//根据给定的语言环境，本地化生成一个地理编码对象
    		Geocoder gc=new Geocoder(this,Locale.CHINA);
    		
    		try
    		{
    			//从一个经度和纬度获得这一个地理坐标的地理名称信息
    			List<Address> addresses=gc.getFromLocation(latitude, longitude, 1);
    			StringBuffer sb=new StringBuffer();
    			if(addresses.size()>0)
    			{
    			

    				//获得地理位置详细信息
    				Address address = addresses.get(0);
    				for(int i=1;i<address.getMaxAddressLineIndex();i++)
	    			{
    					System.out.println("begin to read the "+i+" line");
    					sb.append(address.getCountryName()+address.getAddressLine(i)+address.getThoroughfare()+address.getFeatureName() );
	    				
						//sb.append(address.getAddressLine(i));//.append("\n");			//第一行“中国”，第二行“广东省深圳市福田区“
	    				//sb.append(address.getLocality());//.append("\n");				//第一行“深圳市”，第二行“深圳市“
	    				//sb.append(address.getPostalCode());//.append("\n");			//第一行“null”，第二行“null“
	    				//sb.append(address.getCountryName());							//第一行“null”，第二行“null“
    					//sb.append(address.getThoroughfare()    );						//农林路
    					
    					addressString=sb.toString();
	    				Toast.makeText(Activity01.this, addressString, Toast.LENGTH_LONG).show();
	    				System.out.println(addressString);
	    			}
    			}
    			
    		}
    		catch(IOException e)
    		{
    			
    		}
    	}
    	else
    	{
    		latLongString="can find the coods\n";
    		
    	}
    	tv.setText("你当前的坐标如下：\n"+latLongString+"\n"+addressString);
    	System.out.println("your coords:\n"+latLongString+"\n"+addressString);
    	loc=addressString;
    	
    	
    }
    
    private final LocationListener locationListener=new LocationListener(){
    	public void onLocationChanged(Location location)
    	{
    		updateWithNewLocation(location);
    	}
    	
    	public void onProviderDisabled(String provider)
    	{
    		updateWithNewLocation(null);
    	}
    	public void onProviderEnabled(String provider)
    	{
    		
    	}
    	public void onStatusChanged(String provider,int status,Bundle extras){}  	
    };
    
    protected boolean isRouteDisplayed() {
		// TODO Auto-generated method stub
		return false;
	}
    
    
    
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// TODO Auto-generated method stub
		super.onCreateOptionsMenu(menu);
		menu.add(0, ZOOM_IN, Menu.NONE, "放大");
		menu.add(0, ZOOM_OUT, Menu.NONE, "缩小");
		return true;
		
	}
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// TODO Auto-generated method stub
		super.onOptionsItemSelected(item);
		switch(item.getItemId())
		{
			case(ZOOM_IN):
			  mMapController.zoomIn();
			  return true;
			case(ZOOM_OUT):
				mMapController.zoomOut();
			    return true;
		}
		return true;
	}


    
class MyLocationOverlay extends Overlay
    {
				Location mlocation;
				public void setLocation(Location location)
				{
					mlocation=location;
				}
			
					@Override
					public boolean draw(Canvas canvas, MapView mapView, boolean shadow,
							long when) {
						
						// TODO Auto-generated method stub
						 super.draw(canvas, mapView, shadow);
						 Paint  paint=new Paint();
						 //声明一个屏幕坐标对象
						 Point myScreenCoords=new Point();
						GeoPoint tmpGeoPoint =  new GeoPoint((int)(mlocation.getLatitude()*1E6),(int)(mlocation.getLongitude()*1E6));
						//把地理坐标放到屏幕坐标里
						mapView.getProjection().toPixels(tmpGeoPoint, myScreenCoords);
						
						paint.setStrokeWidth(1);//线条宽度设置
						paint.setARGB(255, 255, 0, 0);//色彩透明度和颜色设置
						paint.setStyle(Paint.Style.STROKE);//风格设置
						
						//生成指定位置的小图标
						 Bitmap bmp=BitmapFactory.decodeResource(getResources(), R.drawable.home);
						 
						 //把小图标显示到屏幕坐标上
						 canvas.drawBitmap(bmp, myScreenCoords.x,myScreenCoords.y, paint);
						 
						 //把地理名称文本信息显示到屏幕坐标上
						 canvas.drawText(loc, myScreenCoords.x, myScreenCoords.y, paint);
						 return true;
					}
    	
    }

	
	
}