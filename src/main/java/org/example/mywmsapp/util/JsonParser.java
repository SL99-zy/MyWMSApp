package org.example.mywmsapp.util;

import org.json.JSONObject;

public class JsonParser {

    public static String getString(JSONObject json, String key) {
        return json.has(key) ? json.getString(key) : "";
    }

    public static double getDouble(JSONObject json, String key) {
        return json.has(key) ? json.getDouble(key) : 0.0;
    }

    public static int getInt(JSONObject json, String key) {
        return json.has(key) ? json.getInt(key) : 0;
    }
}
