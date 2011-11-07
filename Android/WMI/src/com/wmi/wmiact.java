package com.wmi;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.http.util.EncodingUtils;

import android.app.Activity;
import android.app.Service;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.SystemClock;
import android.widget.TextView;
import android.widget.Button;
import android.telephony.TelephonyManager;
import android.telephony.gsm.GsmCellLocation;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Toast;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;

public class wmiact extends Activity {
	// 文字输出
	private TextView myTextView;
	private Button myBtnRefresh;
	private OnClickListener myBtnCallfn;
	
	/** on Refresh Button Click */
    public void clickHandler(View v)
    {
    	downloadAndShowInternetFile();
    }
    
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        // 使用findViewById函数,利用ID找到该TextView对象    
        myTextView = (TextView)findViewById(R.id.myTextView);
        String strTitle = "正在获取";
        
        // 利用setText方法将TextView文字改变为welcom_mes    
        myTextView.setText(strTitle);
        
        // 刷新按钮
        myBtnRefresh = (Button)findViewById(R.id.BtnRefresh);
        strTitle = "刷新";
        myBtnRefresh.setText(strTitle);
        myBtnCallfn = new OnClickListener() {
        	public void onClick(View v) {
        		myBtnRefresh.setEnabled(false);
        		//myBtnRefresh.refreshDrawableState();
        		//myBtnRefresh.invalidate();
        		//myBtnRefresh.setFocusable(false);
        		//myBtnRefresh.setFocusableInTouchMode(false);
        		//SystemClock.sleep(2000);
        		clickHandler(v);
        		myBtnRefresh.setEnabled(true);
        		//myBtnRefresh.refreshDrawableState();
        		//myBtnRefresh.invalidate();
        	}
        };
        myBtnRefresh.setOnClickListener(myBtnCallfn);
        
        // 解码
        downloadAndShowInternetFile();
        
        myBtnRefresh.setEnabled(true);
		//myBtnRefresh.refreshDrawableState();
		//myBtnRefresh.invalidate();
    }
    
    /** on Restart */
    @Override
    public void onRestart() {
    	//downloadAndShowInternetFile();
    }
    
    // 异步网络解码
    class AsyncLoader extends AsyncTask<String, Void, String>{
        @Override
        protected String doInBackground(String... urls) {
        	return GetCIDName(urls[0]);
        }
        
        @Override
        protected void onPostExecute(String result) {
	        // 返回HTML页面的内容
        	myTextView.setText(result);
        }
    }
    
    // 网络解码
    void downloadAndShowInternetFile()
    {
    	myTextView.setText("正在获取");
    	
    	TelephonyManager mTelephonyManager = (TelephonyManager) this.getSystemService(Service.TELEPHONY_SERVICE);
    	if (mTelephonyManager == null) {
    		ShowDebugInfo("mTelephonyManager == null");
    		return;
    	}
    	GsmCellLocation mGsmCellLocation = (GsmCellLocation) mTelephonyManager.getCellLocation();
    	if (mGsmCellLocation == null) {
    		ShowDebugInfo("mGsmCellLocation == null");
    		return;
    	}
        int cid = mGsmCellLocation.getCid();
        int lac = mGsmCellLocation.getLac();
        
        String strOutput = "CellID:" + cid + ", LAC:" + lac + "\n";
        
        if (cid == -1 || lac == -1) {
        	myTextView.setText(strOutput + "无法获取本手机基站数据");
        	return;
        }
        
        strOutput += "基站定位:\n经纬度:";
        String strCid = "http://sltech.8866.org:8081/service.asp?m=11&lac=" + lac + "&cid=" + cid;
        String strRS = GetCIDName(strCid);
        
        if (   strRS.indexOf("@@") == -1) {
        	myTextView.setText(strOutput + "服务器无法获取地址信息,可尝试刷新");
        	return;
    	}
        strRS += "\n\n此程序需能正常连接Google地图\n" + "作者:thomas92911@gmail.com";
    	String[] strSP = strRS.split("@@");
    	strOutput += strSP[0];
    	
        strOutput += "\n";
        
        strOutput += "当前位置:\n";
        strOutput += strSP[1];
        
        //strOutput += "\n\n此程序需能正常连接Google地图\n" + "作者:thomas92911@gmail.com";
        myTextView.setText(strOutput);
        
        //new AsyncLoader().execute(strCid);
    }
    
    // 网络IO访问
    public String GetCIDName(String url)
    {
    	URL internetUrl = null;
    	String strRS = new String("无效结果");
    	int length = -1;
    	
    	try {
    		internetUrl = new URL(url);
    	}
    	catch (MalformedURLException e)
    	{
    		e.printStackTrace();
    		ShowDebugInfo("网络连接异常,地址错误");
    		return strRS;
    	}
    	
    	HttpURLConnection conn = null;
    	try
    	{
    		conn = (HttpURLConnection)internetUrl.openConnection();
    		conn.setDoInput(true);
    		conn.setConnectTimeout(2000);
    		byte[] data = new byte[4096];
    		for (int i = 0; i < 4096; i++) {
    			data[i] = 0;
    		}
    		conn.connect();
    		
    		InputStream is = conn.getInputStream();
    		length = is.read(data);
    		//String str = new String(data, 0, length);
    		//String strEnc = EncodingUtils.getString(data, "UNICODE");
    		//String strEnc = new String(data, "GBK");
    		strRS = new String(data, "GBK");
    		//myTextView.setText(strEnc);
    		
    		//ShowDebugInfo("网络获取成功");
    	}
    	catch (IOException e)
    	{
    		e.printStackTrace();
    		ShowDebugInfo(e.getMessage());
    		//myTextView.setText(e.getMessage());
    	}
    	finally
    	{
    		if (conn != null)
    		{
    			conn.disconnect();
    			conn = null;
    			internetUrl = null;
    		}
    	}
    	
    	if (length == -1 || strRS.length() < 10) {
    		return strRS;
    	}

    	ShowDebugInfo("网络获取成功");
        return strRS.substring(0, length);
    }
    
    // 调试输出
    public void ShowDebugInfo(String txt)
    {
    	Toast.makeText(this, txt, Toast.LENGTH_LONG).show();
    }
    
    // 创建菜单
    public boolean onCreateOptionsMenu(Menu menu) {
    	menu.add(0, 0, 0, "关于");
    	menu.add(0, 1, 1, "退出");
    	return super.onCreateOptionsMenu(menu);
	}
    
	// 菜单响应
	public boolean onOptionsItemSelected(MenuItem item) {
		super.onOptionsItemSelected(item);
		switch (item.getItemId()) {
		case 0:
			Toast.makeText(this, "我在哪(基站定位小程序)\nthomas92911@gmail.com", Toast.LENGTH_LONG).show();
			break;
		case 1:
			this.finish();
			break;
		}  
		return true;
	}
}