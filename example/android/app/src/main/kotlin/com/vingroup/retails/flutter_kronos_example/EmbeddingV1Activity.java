package com.vingroup.retails.flutter_kronos_example;

import android.os.Bundle;

import com.vingroup.retails.flutter_kronos.FlutterKronosPlugin;

import io.flutter.app.FlutterActivity;

public class EmbeddingV1Activity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        FlutterKronosPlugin.registerWith(registrarFor("flutter_kronos"));
    }
}
