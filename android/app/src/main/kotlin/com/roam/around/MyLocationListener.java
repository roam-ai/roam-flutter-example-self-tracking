package com.roam.around;

import android.content.Context;
import android.util.Log;

import com.google.gson.Gson;
import com.roam.sdk.models.RoamLocation;
import com.roam.sdk.service.RoamReceiver;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;

import io.flutter.view.FlutterMain;

public class MyLocationListener extends RoamReceiver {
    @Override
    public void onLocationUpdated(Context context, List<RoamLocation> list) {
        super.onLocationUpdated(context, list);
        for (RoamLocation roamLocation : list) {
            try {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("latitude", roamLocation.getLocation().getLatitude());
                jsonObject.put("longitude", roamLocation.getLocation().getLongitude());
                jsonObject.put("accuracy", roamLocation.getLocation().getAccuracy());
                jsonObject.put("altitude", roamLocation.getLocation().getAltitude());
                jsonObject.put("speed", roamLocation.getLocation().getSpeed());
                jsonObject.put("bearing", roamLocation.getLocation().getBearing());
                jsonObject.put("userId", roamLocation.getUserId());
                jsonObject.put("activity", roamLocation.getActivity());
                jsonObject.put("recordedAt", roamLocation.getRecordedAt());
                jsonObject.put("timezoneOffset", roamLocation.getTimezoneOffset());
                jsonObject.put("metadata", roamLocation.getMetadata() == null ? new JSONObject() : roamLocation.getMetadata());
                jsonObject.put("batteryStatus", roamLocation.getBatteryStatus());
                jsonObject.put("networkStatus", roamLocation.getNetworkStatus());

                HashMap<String, Object> map = new Gson().fromJson(jsonObject.toString(), HashMap.class);
                Log.e("Location from Native", jsonObject.toString());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
