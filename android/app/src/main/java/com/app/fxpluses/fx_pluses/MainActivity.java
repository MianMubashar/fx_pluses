package com.app.fxpluses.fx_pluses;


import io.flutter.embedding.android.FlutterFragmentActivity;
import android.app.NotificationManager;
import android.content.Context;

public class MainActivity extends FlutterFragmentActivity {



    @Override
    protected void onResume() {
        super.onResume();

        // Removing All Notifications
        cancelAllNotifications();
    }

    private void cancelAllNotifications() {
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }
}

